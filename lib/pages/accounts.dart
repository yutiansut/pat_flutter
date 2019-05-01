import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Xwidgets/XlistTile.dart';

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
        XListTile(desc: "Room Rent", category: "Expense", amount: 2500),
        XListTile(desc: "Salary", category: "Income", amount: 27500),
        XListTile(desc: "Abi", category: "Borrow", amount: 500),
        XListTile(desc: "BalaVignesh", category: "Lend", amount: 2500),
      ],
    );
  } 
}