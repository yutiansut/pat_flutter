import '../pages/models/category.dart' as category;
import '../pages/models/accounts.dart' as accounts;
import '../pages/models/settings.dart' as settings;

List createTables = [
  category.createQry,
  accounts.createQry,
  settings.createQry,
];

void main() {
  print("----");
}