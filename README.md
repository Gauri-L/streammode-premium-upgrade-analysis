# StreamMODE Premium Upgrade Analysis

**Power BI · DAX · SQL Server**

Generation Australia Data Analytics Capstone | Australia, FY2025–26

**My contribution:** Gauri Lohar – Dashboard 4: Premium Upgrade Opportunities

## Business Question

Which Basic subscribers should StreamMODE prioritise for a Premium upgrade offer?

For this team capstone, I developed a dashboard tracking subscription movements and comparing observed 30-day upgrade rates by customer tenure. I used the results to recommend an audience for a pilot offer.

## What I Did

- Used DAX to track distinct customers who upgraded or downgraded during the financial year.
- Compared 30-day upgrade rates across three Basic subscriber groups: under 90 days, 90–179 days, and 180 days or more. The comparison windows started on 1 May and 1 June 2026.
- Built Power BI visuals showing monthly upgrades and downgrades, upgrade rates by tenure, and upgrade activity by state.
- Separately validated 14,000 streaming session records in SQL Server for duplicate session IDs, missing values, negative values and playback consistency.
- Identified 213 sessions where playback did not start and retained them in the dataset.

## Key Findings

| Metric | Result |
|---|---:|
| Unique customers who upgraded from Basic to Premium in FY2025–26 | 991 |
| Unique customers who downgraded from Premium to Basic in FY2025–26 | 1,544 |
| 30-day upgrade rate for Basic subscribers with under 90 days of tenure, May window | 14.5% |
| 30-day upgrade rate for Basic subscribers with under 90 days of tenure, June window | 17.9% |

Basic subscribers with under 90 days of tenure had the highest observed 30-day upgrade rate in both windows.

## Recommendation

Run a randomised pilot for active Basic subscribers with under 90 days of tenure. Compare the 30-day upgrade rate of customers who receive the offer with that of a control group. Use the difference and campaign cost to decide whether to expand the offer.

## Scope and Limitations

The tenure comparison covers two historical windows. It describes observed patterns and does not estimate the effect of an offer.

The pilot was proposed, and the dashboard used cohort analysis. A predictive model was outside the completed work.

This portfolio summary describes my contribution to the team capstone using aggregate results. It does not contain the underlying datasets.
