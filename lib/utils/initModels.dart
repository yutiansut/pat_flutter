import './../pages/models/category.dart' as categ;

modelProvider(String modelKey) async {

  if (modelKey == categ.categoryTable) {
    return {'model': categ.ModelCategory, 'createQry': categ.createQry};
  }
}