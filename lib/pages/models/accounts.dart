// Accounts Fields
String accountsTable = 'Accounts';
String colId = 'id';
String colName = 'name';
String colAmount = 'amount';
String colAcDate = 'acDate';
String colCreateDate = 'createDate';
String colCategoryId = 'categoryId';
String colTransType = "transType";

String createQry = """
      CREATE TABLE $accountsTable(
        $colId INTEGER PRIMARY KEY,
        $colName TEXT,
        $colAmount REAL DEFAULT 0,
        $colAcDate DATETIME,
        $colCreateDate TEXT,
        $colCategoryId INTEGER,
        $colTransType TEXT,
        CONSTRAINT fk_CategoryId
          FOREIGN KEY ($colCategoryId)
          REFERENCES Category(id)
          ON DELETE SET NULL
        )
     """;
String defaultOrderBy = '$colAcDate ASC';
