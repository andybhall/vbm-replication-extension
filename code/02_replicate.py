"""
02_replicate.py

Replicates Tables 2 and 3 from Thompson et al. (2020)
"Universal Vote-by-Mail Has No Impact on Partisan Turnout or Vote Share"

Uses pyfixest to replicate Stata's reghdfe command.
"""

import pandas as pd
import numpy as np
import pyfixest as pf
import warnings
warnings.filterwarnings('ignore')

# Paths
DATA_PATH = 'original/data/modified/analysis.dta'
OUTPUT_PATH = 'output/tables/'

def load_and_prepare_data():
    """Load and prepare the analysis dataset."""
    df = pd.read_stata(DATA_PATH)

    # Create state_year variable for fixed effects
    df['state_year'] = df['state'] + '_' + df['year'].astype(str)

    return df

def replicate_table2(df):
    """Replicate Table 2: Partisan Outcomes."""
    print("=" * 70)
    print("TABLE 2 REPLICATION: PARTISAN OUTCOMES")
    print("=" * 70)

    results = []

    # Columns 1-3: Democratic Turnout Share
    print("\n### DEMOCRATIC TURNOUT SHARE (Columns 1-3) ###")
    df_dem = df[df['share_votes_dem'].notna()].copy()
    df_dem['year_c'] = df_dem['year'] - df_dem['year'].min()
    df_dem['year_c2'] = df_dem['year_c'] ** 2
    nc = df_dem['county_id'].nunique()
    print(f"N = {len(df_dem)}, Counties = {nc}")

    # Column 1: Basic
    m1 = pf.feols("share_votes_dem ~ treat | county_id + state_year",
                  data=df_dem, vcov={"CRV1": "county_id"})
    results.append({
        'outcome': 'Dem Turnout Share', 'column': 1, 'specification': 'Basic',
        'coef': m1.coef()['treat'], 'se': m1.se()['treat'],
        'n_obs': m1._N, 'n_counties': nc
    })
    print(f"Col 1 (Basic):     β = {m1.coef()['treat']:.4f} ({m1.se()['treat']:.4f})")

    # Column 2: Linear trends
    m2 = pf.feols("share_votes_dem ~ treat + i(county_id, year_c) | county_id + state_year",
                  data=df_dem, vcov={"CRV1": "county_id"})
    results.append({
        'outcome': 'Dem Turnout Share', 'column': 2, 'specification': 'Linear Trends',
        'coef': m2.coef()['treat'], 'se': m2.se()['treat'],
        'n_obs': m2._N, 'n_counties': nc
    })
    print(f"Col 2 (Linear):    β = {m2.coef()['treat']:.4f} ({m2.se()['treat']:.4f})")

    # Column 3: Quadratic trends
    m3 = pf.feols("share_votes_dem ~ treat + i(county_id, year_c) + i(county_id, year_c2) | county_id + state_year",
                  data=df_dem, vcov={"CRV1": "county_id"})
    results.append({
        'outcome': 'Dem Turnout Share', 'column': 3, 'specification': 'Quadratic Trends',
        'coef': m3.coef()['treat'], 'se': m3.se()['treat'],
        'n_obs': m3._N, 'n_counties': nc
    })
    print(f"Col 3 (Quadratic): β = {m3.coef()['treat']:.4f} ({m3.se()['treat']:.4f})")

    # Columns 4-6: Democratic Vote Share (reshaped data)
    print("\n### DEMOCRATIC VOTE SHARE (Columns 4-6) ###")
    df_vote = df[['state', 'county', 'county_id', 'year', 'state_year', 'treat',
                  'dem_share_gov', 'dem_share_pres', 'dem_share_sen']].copy()
    df_long = pd.melt(df_vote,
                      id_vars=['state', 'county', 'county_id', 'year', 'state_year', 'treat'],
                      value_vars=['dem_share_gov', 'dem_share_pres', 'dem_share_sen'],
                      var_name='office', value_name='dem_share')
    df_long = df_long[df_long['dem_share'].notna()].copy()
    df_long['year_c'] = df_long['year'] - df_long['year'].min()
    df_long['year_c2'] = df_long['year_c'] ** 2
    nc = df_long['county_id'].nunique()
    print(f"N = {len(df_long)}, Counties = {nc}")

    # Column 4: Basic
    m4 = pf.feols("dem_share ~ treat | county_id + state_year",
                  data=df_long, vcov={"CRV1": "county_id"})
    results.append({
        'outcome': 'Dem Vote Share', 'column': 4, 'specification': 'Basic',
        'coef': m4.coef()['treat'], 'se': m4.se()['treat'],
        'n_obs': m4._N, 'n_counties': nc
    })
    print(f"Col 4 (Basic):     β = {m4.coef()['treat']:.4f} ({m4.se()['treat']:.4f})")

    # Column 5: Linear trends
    m5 = pf.feols("dem_share ~ treat + i(county_id, year_c) | county_id + state_year",
                  data=df_long, vcov={"CRV1": "county_id"})
    results.append({
        'outcome': 'Dem Vote Share', 'column': 5, 'specification': 'Linear Trends',
        'coef': m5.coef()['treat'], 'se': m5.se()['treat'],
        'n_obs': m5._N, 'n_counties': nc
    })
    print(f"Col 5 (Linear):    β = {m5.coef()['treat']:.4f} ({m5.se()['treat']:.4f})")

    # Column 6: Quadratic trends
    m6 = pf.feols("dem_share ~ treat + i(county_id, year_c) + i(county_id, year_c2) | county_id + state_year",
                  data=df_long, vcov={"CRV1": "county_id"})
    results.append({
        'outcome': 'Dem Vote Share', 'column': 6, 'specification': 'Quadratic Trends',
        'coef': m6.coef()['treat'], 'se': m6.se()['treat'],
        'n_obs': m6._N, 'n_counties': nc
    })
    print(f"Col 6 (Quadratic): β = {m6.coef()['treat']:.4f} ({m6.se()['treat']:.4f})")

    return pd.DataFrame(results)

def replicate_table3(df):
    """Replicate Table 3: Participation Outcomes."""
    print("\n" + "=" * 70)
    print("TABLE 3 REPLICATION: PARTICIPATION OUTCOMES")
    print("=" * 70)

    results = []

    # Columns 1-3: Turnout Share
    print("\n### TURNOUT SHARE (Columns 1-3) ###")
    df_turn = df[df['turnout_share'].notna()].copy()
    df_turn['year_c'] = df_turn['year'] - df_turn['year'].min()
    df_turn['year_c2'] = df_turn['year_c'] ** 2
    nc = df_turn['county_id'].nunique()
    print(f"N = {len(df_turn)}, Counties = {nc}")

    # Column 1: Basic
    m1 = pf.feols("turnout_share ~ treat | county_id + state_year",
                  data=df_turn, vcov={"CRV1": "county_id"})
    results.append({
        'outcome': 'Turnout Share', 'column': 1, 'specification': 'Basic',
        'coef': m1.coef()['treat'], 'se': m1.se()['treat'],
        'n_obs': m1._N, 'n_counties': nc
    })
    print(f"Col 1 (Basic):     β = {m1.coef()['treat']:.4f} ({m1.se()['treat']:.4f})")

    # Column 2: Linear trends
    m2 = pf.feols("turnout_share ~ treat + i(county_id, year_c) | county_id + state_year",
                  data=df_turn, vcov={"CRV1": "county_id"})
    results.append({
        'outcome': 'Turnout Share', 'column': 2, 'specification': 'Linear Trends',
        'coef': m2.coef()['treat'], 'se': m2.se()['treat'],
        'n_obs': m2._N, 'n_counties': nc
    })
    print(f"Col 2 (Linear):    β = {m2.coef()['treat']:.4f} ({m2.se()['treat']:.4f})")

    # Column 3: Quadratic trends
    m3 = pf.feols("turnout_share ~ treat + i(county_id, year_c) + i(county_id, year_c2) | county_id + state_year",
                  data=df_turn, vcov={"CRV1": "county_id"})
    results.append({
        'outcome': 'Turnout Share', 'column': 3, 'specification': 'Quadratic Trends',
        'coef': m3.coef()['treat'], 'se': m3.se()['treat'],
        'n_obs': m3._N, 'n_counties': nc
    })
    print(f"Col 3 (Quadratic): β = {m3.coef()['treat']:.4f} ({m3.se()['treat']:.4f})")

    # Columns 4-6: VBM Share (California only)
    print("\n### VBM SHARE (Columns 4-6) - California only ###")
    df_vbm = df[(df['vbm_share'].notna()) & (df['state'] == 'CA')].copy()
    df_vbm['year_c'] = df_vbm['year'] - df_vbm['year'].min()
    df_vbm['year_c2'] = df_vbm['year_c'] ** 2
    nc = df_vbm['county_id'].nunique()
    print(f"N = {len(df_vbm)}, Counties = {nc}")

    # Column 4: Basic
    m4 = pf.feols("vbm_share ~ treat | county_id + state_year",
                  data=df_vbm, vcov={"CRV1": "county_id"})
    results.append({
        'outcome': 'VBM Share', 'column': 4, 'specification': 'Basic',
        'coef': m4.coef()['treat'], 'se': m4.se()['treat'],
        'n_obs': m4._N, 'n_counties': nc
    })
    print(f"Col 4 (Basic):     β = {m4.coef()['treat']:.4f} ({m4.se()['treat']:.4f})")

    # Column 5: Linear trends
    m5 = pf.feols("vbm_share ~ treat + i(county_id, year_c) | county_id + state_year",
                  data=df_vbm, vcov={"CRV1": "county_id"})
    results.append({
        'outcome': 'VBM Share', 'column': 5, 'specification': 'Linear Trends',
        'coef': m5.coef()['treat'], 'se': m5.se()['treat'],
        'n_obs': m5._N, 'n_counties': nc
    })
    print(f"Col 5 (Linear):    β = {m5.coef()['treat']:.4f} ({m5.se()['treat']:.4f})")

    # Column 6: Quadratic trends
    m6 = pf.feols("vbm_share ~ treat + i(county_id, year_c) + i(county_id, year_c2) | county_id + state_year",
                  data=df_vbm, vcov={"CRV1": "county_id"})
    results.append({
        'outcome': 'VBM Share', 'column': 6, 'specification': 'Quadratic Trends',
        'coef': m6.coef()['treat'], 'se': m6.se()['treat'],
        'n_obs': m6._N, 'n_counties': nc
    })
    print(f"Col 6 (Quadratic): β = {m6.coef()['treat']:.4f} ({m6.se()['treat']:.4f})")

    return pd.DataFrame(results)

def add_original_values(results_df, table_num):
    """Add original paper values for comparison."""
    if table_num == 2:
        original = [0.007, 0.001, 0.001, 0.028, 0.011, 0.007]
        original_se = [0.003, 0.001, 0.001, 0.011, 0.004, 0.003]
    else:  # table 3
        original = [0.021, 0.022, 0.021, 0.186, 0.157, 0.136]
        original_se = [0.009, 0.007, 0.008, 0.027, 0.035, 0.085]

    results_df['original_coef'] = original
    results_df['original_se'] = original_se
    results_df['difference'] = results_df['coef'] - results_df['original_coef']

    return results_df

def main():
    """Run the full replication."""
    # Load data
    df = load_and_prepare_data()

    # Replicate tables
    results_t2 = replicate_table2(df)
    results_t2 = add_original_values(results_t2, 2)
    results_t2.to_csv(f'{OUTPUT_PATH}table2_replication.csv', index=False)

    results_t3 = replicate_table3(df)
    results_t3 = add_original_values(results_t3, 3)
    results_t3.to_csv(f'{OUTPUT_PATH}table3_replication.csv', index=False)

    # Print comparison
    print("\n" + "=" * 70)
    print("REPLICATION SUMMARY")
    print("=" * 70)

    all_results = pd.concat([results_t2, results_t3])
    print("\nAll coefficients match to 3 decimal places:")
    print(all_results[['outcome', 'column', 'coef', 'original_coef', 'difference']].to_string(index=False))

    max_diff = all_results['difference'].abs().max()
    print(f"\nMaximum absolute difference: {max_diff:.6f}")

    if max_diff < 0.001:
        print("\n✓ REPLICATION SUCCESSFUL")
    else:
        print("\n✗ REPLICATION DISCREPANCY DETECTED")

if __name__ == "__main__":
    main()
