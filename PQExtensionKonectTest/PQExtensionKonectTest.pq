section Konect;


DefaultRequestHeaders = [
    #"Accept" = "application/json;odata.metadata=minimal",  // column name and values only
    #"OData-MaxVersion" = "4.0",                             // we only support v4
    #"x-api-key"=Extension.CurrentCredential()[Key]
];

[DataSource.Kind="Konect", Publish="Konect.Publish"]
shared Konect.Feed = Value.ReplaceType(KonectImpl, type function (url as Uri.Type) as any);

KonectImpl = (url as text) =>
    let
        source = Json.Document( Web.Contents(url, [ Headers = DefaultRequestHeaders ])),
        #"Converted to Table" = Record.ToTable(source)
    in
        #"Converted to Table";

// Data Source Kind description
Konect = [
    Authentication = [
        Key = []
    ],
    Label = "Konect Part 1 - REST API"
];

// Data Source UI publishing description
Konect.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = { "Konect REST API", "Konect REST API" }
];