"""
03_prepare_extension.py

Prepares the extended analysis dataset by:
1. Loading original analysis data (1996-2018)
2. Creating extension observations (2020-2024)
3. Merging with VCA adoption, election results, and CVAP data
4. Creating analysis variables for regression
"""

import pandas as pd
import numpy as np
import warnings
warnings.filterwarnings('ignore')

# Paths
ORIGINAL_DATA = 'original/data/modified/analysis.dta'
VCA_DATA = 'data/extension/california_vbm_adoption.csv'
ELECTIONS_DATA = 'data/extension/election_results_2020_2024.csv'
CVAP_DATA = 'data/extension/cvap_2018_2022.csv'
OUTPUT_PATH = 'data/processed/analysis_extended.csv'


def load_original_data():
    """Load and subset original analysis data."""
    df = pd.read_stata(ORIGINAL_DATA)

    key_vars = ['state', 'county', 'county_id', 'year', 'treat',
                'dem_share_pres', 'dem_share_gov', 'dem_share_sen',
                'turnout_share', 'vbm_share', 'share_votes_dem', 'cvap']

    df = df[key_vars].copy()
    df['state_year'] = df['state'] + '_' + df['year'].astype(str)

    return df


def create_extension_observations(orig_df, vca_df, elections_df, cvap_df):
    """Create observations for 2020, 2022, 2024."""

    # Get county mapping
    county_map = orig_df[['state', 'county', 'county_id']].drop_duplicates()

    extension_years = [2020, 2022, 2024]
    rows = []

    for state in ['CA', 'UT', 'WA']:
        state_counties = county_map[county_map['state'] == state]

        for _, county_row in state_counties.iterrows():
            county = county_row['county']
            county_id = county_row['county_id']

            for year in extension_years:
                row = {
                    'state': state,
                    'county': county,
                    'county_id': county_id,
                    'year': year
                }

                # Determine treatment status
                if state == 'CA':
                    vca_row = vca_df[vca_df['county'] == county]
                    if len(vca_row) > 0:
                        vca_year = vca_row['vca_first_year'].values[0]
                        if vca_year != 'NA' and int(vca_year) <= year:
                            row['treat'] = 1
                        else:
                            row['treat'] = 0
                    else:
                        row['treat'] = 0
                else:
                    # UT and WA already 100% VBM
                    row['treat'] = 1

                rows.append(row)

    ext_df = pd.DataFrame(rows)

    # Merge election results
    for office, col_suffix in [('PRESIDENT', 'pres'), ('GOVERNOR', 'gov'), ('SENATE', 'sen')]:
        office_data = elections_df[elections_df['office'] == office][
            ['state', 'county', 'year', 'dem_share']
        ].copy()
        office_data = office_data.rename(columns={'dem_share': f'dem_share_{col_suffix}'})
        ext_df = ext_df.merge(office_data, on=['state', 'county', 'year'], how='left')

    # Merge CVAP
    ext_df = ext_df.merge(cvap_df[['state', 'county', 'cvap']], on=['state', 'county'], how='left')

    # Calculate turnout for presidential years
    pres_votes = elections_df[elections_df['office'] == 'PRESIDENT'][
        ['state', 'county', 'year', 'total_votes']
    ]
    ext_df = ext_df.merge(pres_votes, on=['state', 'county', 'year'], how='left')
    ext_df['turnout_share'] = ext_df['total_votes'] / ext_df['cvap']
    ext_df = ext_df.drop(columns=['total_votes'])

    # Add missing columns
    for col in ['vbm_share', 'share_votes_dem']:
        ext_df[col] = np.nan

    # Create state_year
    ext_df['state_year'] = ext_df['state'] + '_' + ext_df['year'].astype(str)

    return ext_df


def combine_and_finalize(orig_df, ext_df):
    """Combine original and extension data, add analysis variables."""

    # Ensure column order matches
    cols = ['state', 'county', 'county_id', 'year', 'treat',
            'dem_share_pres', 'dem_share_gov', 'dem_share_sen',
            'turnout_share', 'vbm_share', 'share_votes_dem', 'cvap', 'state_year']

    orig_df = orig_df[cols]
    ext_df = ext_df[cols]

    # Combine
    combined = pd.concat([orig_df, ext_df], ignore_index=True)
    combined = combined.sort_values(['state', 'county', 'year']).reset_index(drop=True)

    # Add analysis variables
    min_year = combined['year'].min()
    combined['year_c'] = combined['year'] - min_year
    combined['year_c2'] = combined['year_c'] ** 2
    combined['extension'] = (combined['year'] >= 2020).astype(int)

    return combined


def main():
    """Run the full data preparation."""
    print("Loading data...")
    orig = load_original_data()
    vca = pd.read_csv(VCA_DATA, na_values=[], keep_default_na=False)
    elections = pd.read_csv(ELECTIONS_DATA)
    cvap = pd.read_csv(CVAP_DATA)

    print(f"Original data: {len(orig)} observations")

    print("Creating extension observations...")
    ext = create_extension_observations(orig, vca, elections, cvap)
    print(f"Extension data: {len(ext)} observations")

    print("Combining datasets...")
    combined = combine_and_finalize(orig, ext)
    print(f"Combined data: {len(combined)} observations")

    # Save
    combined.to_csv(OUTPUT_PATH, index=False)
    print(f"Saved to {OUTPUT_PATH}")

    # Summary
    print("\n=== SUMMARY ===")
    print(f"Total observations: {len(combined)}")
    print(f"Counties: {combined['county_id'].nunique()}")
    print(f"Years: {combined['year'].min()} - {combined['year'].max()}")
    print(f"\nTreatment by period:")
    print(combined.groupby('extension')['treat'].mean().round(3))


if __name__ == "__main__":
    main()
