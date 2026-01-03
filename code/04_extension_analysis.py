"""
04_extension_analysis.py

Runs the extension analysis for Thompson et al. (2020) replication.
Extends the original 1996-2018 analysis to include 2020-2024 elections.
"""

import pandas as pd
import numpy as np
import pyfixest as pf
import matplotlib.pyplot as plt
import warnings
warnings.filterwarnings('ignore')

# Paths
DATA_PATH = 'data/processed/analysis_extended.csv'
VCA_PATH = 'data/extension/california_vbm_adoption.csv'
OUTPUT_TABLES = 'output/tables/'
OUTPUT_FIGURES = 'output/figures/'


def load_data():
    """Load analysis data and VCA adoption info."""
    df = pd.read_csv(DATA_PATH)
    vca = pd.read_csv(VCA_PATH, na_values=[], keep_default_na=False)
    return df, vca


def create_long_format(df):
    """Create long-format dataset for vote share analysis."""
    df_vote = df[['state', 'county', 'county_id', 'year', 'state_year', 'treat',
                  'extension', 'dem_share_gov', 'dem_share_pres', 'dem_share_sen',
                  'year_c', 'year_c2']].copy()
    df_long = pd.melt(df_vote,
                      id_vars=['state', 'county', 'county_id', 'year', 'state_year',
                              'treat', 'extension', 'year_c', 'year_c2'],
                      value_vars=['dem_share_gov', 'dem_share_pres', 'dem_share_sen'],
                      var_name='office', value_name='dem_share')
    return df_long[df_long['dem_share'].notna()].copy()


def run_main_specifications(df_long):
    """Run main DiD specifications comparing original vs extended period."""
    results = []

    df_orig = df_long[df_long['extension'] == 0].copy()
    df_full = df_long.copy()

    specifications = [
        ('Basic', 'dem_share ~ treat | county_id + state_year'),
        ('Linear', 'dem_share ~ treat + i(county_id, year_c) | county_id + state_year'),
        ('Quadratic', 'dem_share ~ treat + i(county_id, year_c) + i(county_id, year_c2) | county_id + state_year')
    ]

    for spec_name, formula in specifications:
        # Original period
        m_orig = pf.feols(formula, data=df_orig, vcov={"CRV1": "county_id"})
        results.append({
            'outcome': 'Dem Vote Share',
            'specification': spec_name,
            'period': 'Original (1996-2018)',
            'coef': m_orig.coef()['treat'],
            'se': m_orig.se()['treat'],
            'n': m_orig._N
        })

        # Extended period
        m_full = pf.feols(formula, data=df_full, vcov={"CRV1": "county_id"})
        results.append({
            'outcome': 'Dem Vote Share',
            'specification': spec_name,
            'period': 'Extended (1996-2024)',
            'coef': m_full.coef()['treat'],
            'se': m_full.se()['treat'],
            'n': m_full._N
        })

    return pd.DataFrame(results)


def run_turnout_analysis(df):
    """Run turnout analysis for original vs extended period."""
    results = []

    df_turn = df[df['turnout_share'].notna()].copy()
    df_orig = df_turn[df_turn['extension'] == 0].copy()

    specifications = [
        ('Basic', 'turnout_share ~ treat | county_id + state_year'),
        ('Linear', 'turnout_share ~ treat + i(county_id, year_c) | county_id + state_year'),
        ('Quadratic', 'turnout_share ~ treat + i(county_id, year_c) + i(county_id, year_c2) | county_id + state_year')
    ]

    for spec_name, formula in specifications:
        m_orig = pf.feols(formula, data=df_orig, vcov={"CRV1": "county_id"})
        results.append({
            'outcome': 'Turnout',
            'specification': spec_name,
            'period': 'Original (1996-2018)',
            'coef': m_orig.coef()['treat'],
            'se': m_orig.se()['treat'],
            'n': m_orig._N
        })

        m_full = pf.feols(formula, data=df_turn, vcov={"CRV1": "county_id"})
        results.append({
            'outcome': 'Turnout',
            'specification': spec_name,
            'period': 'Extended (1996-2024)',
            'coef': m_full.coef()['treat'],
            'se': m_full.se()['treat'],
            'n': m_full._N
        })

    return pd.DataFrame(results)


def run_cohort_analysis(df, vca):
    """Run heterogeneity analysis by VCA adoption cohort."""
    df = df.merge(vca[['county', 'vca_first_year']], on='county', how='left')
    df['vca_first_year'] = df['vca_first_year'].fillna('Never')

    # Create cohort-specific treatment indicators
    df['treat_2018'] = ((df['vca_first_year'] == '2018') & (df['year'] >= 2018)).astype(int)
    df['treat_2020'] = ((df['vca_first_year'] == '2020') & (df['year'] >= 2020)).astype(int)
    df['treat_2022'] = ((df['vca_first_year'] == '2022') & (df['year'] >= 2022)).astype(int)
    df['treat_2024'] = ((df['vca_first_year'] == '2024') & (df['year'] >= 2024)).astype(int)

    results = []

    # Vote share
    df_pres = df[df['dem_share_pres'].notna()].copy()
    m = pf.feols("dem_share_pres ~ treat_2018 + treat_2020 + treat_2022 + treat_2024 | county_id + state_year",
                 data=df_pres, vcov={"CRV1": "county_id"})

    for cohort in ['treat_2018', 'treat_2020', 'treat_2022', 'treat_2024']:
        results.append({
            'outcome': 'Dem Vote Share (Pres)',
            'cohort': cohort.replace('treat_', ''),
            'coef': m.coef()[cohort],
            'se': m.se()[cohort]
        })

    # Turnout
    df_turn = df[df['turnout_share'].notna()].copy()
    m = pf.feols("turnout_share ~ treat_2018 + treat_2020 + treat_2022 + treat_2024 | county_id + state_year",
                 data=df_turn, vcov={"CRV1": "county_id"})

    for cohort in ['treat_2018', 'treat_2020', 'treat_2022', 'treat_2024']:
        results.append({
            'outcome': 'Turnout',
            'cohort': cohort.replace('treat_', ''),
            'coef': m.coef()[cohort],
            'se': m.se()[cohort]
        })

    return pd.DataFrame(results)


def run_event_study(df, vca):
    """Run event study analysis for California.

    IMPORTANT: Includes all CA counties (both VCA adopters and never-treated)
    to ensure never-treated counties serve as controls in the DiD framework.
    Event-time dummies are created only for treated counties; never-treated
    counties have all event-time dummies set to 0 and contribute to fixed effects.
    """
    df = df.merge(vca[['county', 'vca_first_year']], on='county', how='left')
    df_ca = df[df['state'] == 'CA'].copy()
    df_ca['vca_year'] = pd.to_numeric(df_ca['vca_first_year'], errors='coerce')

    # Calculate event time for treated counties (NaN for never-treated)
    df_ca['event_time'] = df_ca['year'] - df_ca['vca_year']

    results = []
    event_times = [-10, -8, -6, -4, 0, 2, 4, 6]  # Even years only (elections)

    for outcome, outcome_var in [('Dem Vote Share (Pres)', 'dem_share_pres'),
                                   ('Turnout', 'turnout_share')]:
        # Include ALL CA counties with valid outcome data
        df_sub = df_ca[df_ca[outcome_var].notna()].copy()

        # Create event-time dummies manually
        # For never-treated counties, all dummies are 0 (they serve as controls)
        # Reference period is t=-2
        for t in event_times:
            if t == -2:
                continue  # Skip reference period
            col = f'et{t}'.replace('-', 'm')
            df_sub[col] = ((df_sub['event_time'] == t)).fillna(False).astype(int)

        # Build formula with event-time dummies (excluding reference t=-2)
        et_cols = [f'et{t}'.replace('-', 'm') for t in event_times if t != -2]
        formula = f"{outcome_var} ~ " + " + ".join(et_cols) + " | county_id + year"

        m = pf.feols(formula, data=df_sub, vcov={"CRV1": "county_id"})
        coefs = dict(m.coef())
        ses = dict(m.se())

        # Collect results
        for t in event_times:
            if t == -2:
                results.append({'outcome': outcome, 't': t, 'coef': 0.0, 'se': 0.0})
            else:
                col = f'et{t}'.replace('-', 'm')
                if col in coefs:
                    results.append({'outcome': outcome, 't': t,
                                   'coef': coefs[col], 'se': ses[col]})

    return pd.DataFrame(results)


def create_event_study_plot(es_results):
    """Create event study figure."""
    fig, axes = plt.subplots(1, 2, figsize=(14, 5))

    for ax, outcome, color, title in [
        (axes[0], 'Dem Vote Share (Pres)', 'steelblue', 'Democratic Vote Share (Presidential)'),
        (axes[1], 'Turnout', 'darkgreen', 'Turnout')
    ]:
        data = es_results[es_results['outcome'] == outcome].sort_values('t')
        ax.errorbar(data['t'], data['coef'], yerr=1.96*data['se'],
                   fmt='o-', capsize=3, color=color, markersize=8)
        ax.axhline(y=0, color='gray', linestyle='--', alpha=0.5)
        ax.axvline(x=-0.5, color='red', linestyle='--', alpha=0.7, label='VCA Adoption')
        ax.set_xlabel('Years Relative to VCA Adoption', fontsize=12)
        ax.set_ylabel('Coefficient (relative to t=-2)', fontsize=12)
        ax.set_title(f'Effect on {title}', fontsize=14)
        ax.legend(fontsize=10)

    plt.tight_layout()
    plt.savefig(f'{OUTPUT_FIGURES}event_study.png', dpi=150, bbox_inches='tight')
    plt.savefig(f'{OUTPUT_FIGURES}event_study.pdf', bbox_inches='tight')
    plt.close()


def main():
    """Run full extension analysis."""
    print("=" * 70)
    print("EXTENSION ANALYSIS: Thompson et al. (2020)")
    print("=" * 70)

    # Load data
    df, vca = load_data()
    df_long = create_long_format(df)

    print(f"\nTotal observations: {len(df)}")
    print(f"Extension observations: {(df['extension'] == 1).sum()}")

    # Main specifications
    print("\n### Running main DiD specifications...")
    partisan_results = run_main_specifications(df_long)
    partisan_results.to_csv(f'{OUTPUT_TABLES}extension_partisan_results.csv', index=False)
    print(partisan_results.to_string(index=False))

    # Turnout analysis
    print("\n### Running turnout analysis...")
    turnout_results = run_turnout_analysis(df)
    turnout_results.to_csv(f'{OUTPUT_TABLES}extension_turnout_results.csv', index=False)
    print(turnout_results.to_string(index=False))

    # Cohort analysis
    print("\n### Running cohort heterogeneity analysis...")
    cohort_results = run_cohort_analysis(df.copy(), vca)
    cohort_results.to_csv(f'{OUTPUT_TABLES}cohort_results.csv', index=False)
    print(cohort_results.to_string(index=False))

    # Event study
    print("\n### Running event study...")
    es_results = run_event_study(df.copy(), vca)
    es_results.to_csv(f'{OUTPUT_TABLES}event_study_results.csv', index=False)
    create_event_study_plot(es_results)
    print("Event study plot saved.")

    print("\n" + "=" * 70)
    print("ANALYSIS COMPLETE")
    print("=" * 70)


if __name__ == "__main__":
    main()
