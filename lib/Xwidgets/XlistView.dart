import 'package:flutter/material.dart';

class XListView extends StatefulWidget {
  String title = "";
  String subtitle = "";
  Widget leading = Icon(Icons.account_balance_wallet);

  XListView({Key key, this.title, this.subtitle, this.leading}): super(key: key);

  @override
  _XListViewState createState() => _XListViewState();
}

class _XListViewState  extends State<XListView>{
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.leading,
      title: Text(widget.title),
      subtitle: Text(widget.subtitle),
      trailing: widget.leading,
      onTap: (){
        print("Pressed1");
      },
    );
  } 
}