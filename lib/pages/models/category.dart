import 'package:flutter/material.dart' show Colors;

// Categ Badge Colors
const Map<String, dynamic> categColor = <String, dynamic>{
  "Income": Colors.green,
  "Expense": Colors.red,
  "Borrow": Colors.orange,
  "Lend": Colors.teal,
};

List categoryTypes = ['Income', 'Expense', 'Borrow', 'Lend'];

List transactionTypes = ['Card', 'Cash'];

// DB Fields
String categoryTable = 'Category';
String colId = 'id';
String colName = 'name';
String colCreateDate = 'createDate';
String colCategoryType = 'categoryType';
String colParentId = "parentId";

String createQry = """
      CREATE TABLE $categoryTable(
        $colId INTEGER PRIMARY KEY,
        $colName TEXT,
        $colCreateDate TEXT,
        $colCategoryType TEXT,
        $colParentId INTEGER,
        CONSTRAINT fk_CategoryId
          FOREIGN KEY($colParentId)
          REFERENCES $categoryTable($colId)
          ON DELETE SET NULL
        )
     """;
String defaultOrderBy = '$colName ASC';
