let
    Source  = Excel.Workbook(File.Contents("D:\Data Project\ESG & Financial Performance Dataset\company_esg_financial_dataset.xlsx"), null, true),
    Sheet   = Source{[Item = "Sheet1", Kind = "Sheet"]}[Data],
    Typed   = Table.TransformColumnTypes(Sheet, {
        {"CompanyID", Int64.Type},          {"CompanyName", type text},
        {"Industry", type text},            {"Region", type text},
        {"Year", Int64.Type},               {"Revenue", type number},
        {"ProfitMargin", type number},      {"MarketCap", type number},
        {"GrowthRate", type number},        {"ESG_Overall", type number},
        {"ESG_Environmental", type number}, {"ESG_Social", type number},
        {"ESG_Governance", type number},    {"CarbonEmissions", type number},
        {"WaterUsage", type number},        {"EnergyConsumption", type number}
    }),
    Trimmed = Table.TransformColumns(Typed, {
        {"CompanyName", Text.Trim, type text},
        {"Industry",    Text.Trim, type text},
        {"Region",      Text.Trim, type text}
    }),
    NoDupes = Table.Distinct(Trimmed, {"CompanyID", "Year"}),
    NoNulls = Table.SelectRows(NoDupes, each [CompanyID] <> null and [Year] <> null)
in
    NoNulls

let
    Source = Raw_ESG,
    Keep   = Table.RemoveColumns(Source, {"CompanyName", "Industry", "Region"})
in
    Keep

let
    Source   = Raw_ESG,
    Sel      = Table.SelectColumns(Source, {"CompanyID", "CompanyName", "Industry", "Region"}),
    Distinct = Table.Distinct(Sel, {"CompanyID"})
in
    Distinct

let
    Years   = List.Numbers(2015, 11),
    ToTable = Table.FromList(Years, Splitter.SplitByNothing(), {"Year"}, null, ExtraValues.Error),
    Typed   = Table.TransformColumnTypes(ToTable, {{"Year", Int64.Type}}),
    AddDate = Table.AddColumn(Typed, "Date", each #date([Year], 1, 1), type date)
in
    AddDate
