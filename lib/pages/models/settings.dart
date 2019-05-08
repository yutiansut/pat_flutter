// Settings Fields
String settingsTable = 'Settings';
String colId = 'id';
String colName = 'name';
String colValue = 'value';

String createQry = """
      CREATE TABLE IF NOT EXISTS $settingsTable(
        $colId INTEGER PRIMARY KEY,
        $colName TEXT,
        $colValue TEXT
        )
     """;  // rec_name
String defaultOrderBy = '$colName ASC';  // rec_name
