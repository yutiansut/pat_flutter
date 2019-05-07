import 'package:flutter/material.dart';
import '../config/config.dart' as conf;
import '../pages/models/category.dart' as categ;

class XListTile extends StatefulWidget {
  String desc = "";
  String category = "";
  String transactionType = "";
  double amount = 0.0;
  Widget leading = Icon(Icons.account_balance_wallet);

  XListTile({Key key, @required this.desc, @required this.category, this.transactionType, this.amount, this.leading}): super(key: key);

  @override
  _XListTileState createState() => _XListTileState();
}

class _XListTileState  extends State<XListTile>{
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(widget.desc),
          subtitle: Row(
            children: <Widget>[
              Text(widget.transactionType, style: TextStyle(color: Colors.green, fontSize: 10)),
            ],
          ),
          leading: CircleAvatar(backgroundColor: categ.categColor[widget.category], child: Text(widget.category[0], style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),),),
          trailing: Chip(
            label: Text(widget.amount.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            avatar: CircleAvatar(
              child: Image(image: AssetImage(conf.currencyIcon), width: 16,),
              backgroundColor: Colors.white,
              // foregroundColor: Colors.white,
            ),
            backgroundColor: categ.categColor[widget.category],
          ),
          onTap: (){
            // print("Pressed1");
          },
        ),
        Divider()
      ],
    );
  } 
}