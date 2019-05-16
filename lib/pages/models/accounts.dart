// Accounts Fields
String accountsTable = 'Accounts';
String colId = 'id';
String colName = 'name';
String colAmount = 'amount';
String colAcDate = 'acDate';
String colCreateDate = 'createDate';
String colCategoryType = 'categoryType';
String colTransType = "transType";

String createQry = """
      CREATE TABLE $accountsTable(
        $colId INTEGER PRIMARY KEY,
        $colName TEXT,
        $colAmount REAL DEFAULT 0,
        $colAcDate DATETIME,
        $colCreateDate TEXT,
        $colCategoryType TEXT,
        $colTransType TEXT
        )
     """;
String defaultOrderBy = '$colAcDate ASC';
