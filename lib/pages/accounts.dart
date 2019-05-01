import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Xwidgets/XlistView.dart';

class AccountsPage extends StatefulWidget {
  
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState  extends State<AccountsPage>{
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(.5),
      children: <Widget>[
        ListTile(
          title: Text("Income"),
          subtitle: Text("SubTitle"),
          trailing: Chip(
            label: Text("2000", style: TextStyle(fontWeight: FontWeight.bold),),
            avatar: CircleAvatar(
              child: Image(image: AssetImage("assets/rupee-16.png")),
              backgroundColor: Colors.amber,
              foregroundColor: Colors.white,
            ),
            backgroundColor: Colors.amber,
          ),
          onTap: (){
            print("Pressed1");
          },
        ),
        Divider()
      ],
    );
  } 
}