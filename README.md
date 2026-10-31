# Carbon Price Stress Test: Profit and Valuation Risk

📌**Project Overview**: This project develops a Power BI dashboard to stress-test 1,000 companies under hypothetical carbon pricing scenarios, assessing the impact on profitability, solvency, and market value, as well as whether ESG scores can signal potential carbon-related financial exposure.

> **Data note:** the dataset is synthetic. All results are scenario outputs, not market findings.

## Business question

If carbon emissions were priced, which industries and companies would stay profitable, how much market value would be at risk, and do ESG scores give an early warning?

##
📊 **Dataset Summary**
- Total Data: 11,000 rows × 16 columns
- Source: https://www.kaggle.com/datasets/shriyashjagtap/esg-and-financial-performance-dataset
#
| Column Name       | Description                                         |
|-------------------|-----------------------------------------------------|
| CompanyID         | Unique identifier for each synthetic company        |
| CompanyName       | Synthetic name (e.g., "Company_123")                |
| Industry          | Industry sector (e.g., Technology, Finance, Energy) |
| Year              | Industry sector (e.g., Technology, Finance, Energy) |
| Region            | Geographic region (e.g., North America, Europe)     |
| Revenue           | Annual revenue in millions USD                      |
| ProfitMargin      | Net profit margin as percentage of revenue          |
| MarketCap         | Market capitalization in millions USD               |
| GrowthRate        | Year-over-year revenue growth rate (%)              |
| ESG_Overall       | Aggregate ESG sustainability score (0–100)          |
| ESG_Environmental | Environmental sustainability score (0–100)          |
| ESG_Social        | Social responsibility score (0–100)                 |
| ESG_Governance    | Corporate governance quality score (0–100)          |
| CarbonEmissions   | Annual carbon emissions in tons CO₂                 |
| WaterUsage        | Annual water usage in cubic meters                  |
| EnergyConsumption | Annual energy consumption in megawatt-hours (MWh)   |

## Workflow

1. **Ingest and clean (Power Query):** load the Excel file, set types, trim text, remove duplicate company-years, keep `GrowthRate` null for 2015.
2. **Model:** split into a fact table and company/year dimensions; create one-to-many relationships.
3. **Derive new fields (DAX columns):** net profit per row, carbon intensity per row, ESG blind-spot flag, sector carbon group.
4. **Build the scenario engine:** a what-if parameter feeds measures for carbon cost, carbon-adjusted margin, loss-making share and stressed market cap.
5. **Visualise:** KPI cards, margin before/after, market cap at risk, emission growth with a 5-year forecast, ESG blind-spot map, carbon intensity vs earnings volatility.
6. **Control interactions:** Year slicer disconnected from visuals that need the full time series (YoY, forecast, volatility); Industry slicer disconnected from the industry-comparison charts.

## Key findings for 2025, with carbon price scenario = $100 per tonne CO₂

- Annual carbon cost reaches **$174.9B**, equal to **20.6% of total net profit**.
- Aggregate margin falls from **12.9% to 10.2%**; **23.9%** of companies become loss-making, **11.5%** of them because of the carbon cost alone.
- The impact is concentrated: margins fall to about **0.8% in Energy**, **0.1% in Transportation** and **3.3% in Utilities**; Technology and Finance are almost unaffected.
- About **10%** of total market cap is at risk (Utilities 50.5%, Energy 35.6%, Transportation 30.3%), assuming a constant P/E.
- Emission growth accelerated from roughly 4–5% a year (2017–2021) to 7–9% a year (since 2022).
- **70 companies** score above the median on ESG yet sit in the top 25% of carbon intensity: ESG scores are peer-relative and do not reveal absolute carbon exposure.
- High-carbon sectors (Energy, Utilities, Transportation) show higher average margin volatility (about 3.9 vs 2.9 points).

## Assumptions and limitations

- The carbon price is a **uniform, hypothetical scenario**; emissions do not fall in response (no abatement).
- Valuation impact assumes **constant P/E** (market cap moves in proportion to profit).
- Margins in the stress test are **revenue-weighted**, so they differ from the simple average margin.
- The forecast is a **trend extrapolation** (kept to 2030); methods differ widely beyond that.
- Within-sector correlations between carbon intensity and volatility are weaker than the overall correlation, which partly reflects the difference between sector groups.
- Synthetic data: relationships may reflect how the data were generated.
