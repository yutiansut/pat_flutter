import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import '../../Xwidgets/XlistTile.dart';
// import '../models/category.dart' as categ;

class AccountsPage extends StatefulWidget {
  
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState  extends State<AccountsPage>{

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(0.8),
      children: <Widget>[
        // XListTile(desc: "Room Rent", category: categ.defaultCateg[1].name, amount: 2500),
        // XListTile(desc: "Salary", category: categ.defaultCateg[0].name, amount: 27500),
        // XListTile(desc: "Abi", category: categ.defaultCateg[2].name, amount: 500),
        // XListTile(desc: "BalaVignesh", category: categ.defaultCateg[3].name, amount: 2500),
        // XListTile(desc: "BalaVignesh", category: categ.defaultCateg[2].name, amount: 2500),
        // XListTile(desc: "BalaVignesh", category: categ.defaultCateg[1].name, amount: 2500),
        // XListTile(desc: "Room Rent", category: categ.defaultCateg[1].name, amount: 2500),
        // XListTile(desc: "Salary", category: categ.defaultCateg[0].name, amount: 27500),
        // XListTile(desc: "Abi", category: categ.defaultCateg[2].name, amount: 500),
        // XListTile(desc: "BalaVignesh", category: categ.defaultCateg[3].name, amount: 2500),
        // XListTile(desc: "BalaVignesh", category: categ.defaultCateg[2].name, amount: 2500),
        // XListTile(desc: "BalaVignesh", category: categ.defaultCateg[1].name, amount: 2500),
      ],
    );
  } 
}