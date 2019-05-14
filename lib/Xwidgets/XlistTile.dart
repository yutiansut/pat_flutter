import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class XListTile extends StatefulWidget {
  int index;
  String desc = "";
  String category = "";
  String transactionType = "";
  double amount = 0.0;
  String createDate;
  Widget leading = Icon(Icons.account_balance_wallet);

  XListTile({Key key, this.index, @required this.desc, this.createDate, @required this.category, this.transactionType, this.amount, this.leading}): super(key: key);

  @override
  _XListTileState createState() => _XListTileState();
}

class _XListTileState  extends State<XListTile>{

  @override
  Widget build(BuildContext context) {
    Color oddColor = ((widget.index % 2)!=0) ? Color(0xFFF7F7F9) : Colors.white;
    // return Column(
    //   children: <Widget>[
    //     ListTile(
    //       title: Text(widget.desc),
    //       subtitle: Row(
    //         children: <Widget>[
    //           Text(widget.transactionType, style: TextStyle(color: Colors.green, fontSize: 10)),
    //         ],
    //       ),
    //       leading: CircleAvatar(backgroundColor: categ.categColor[widget.category], child: Text(widget.category[0], style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),),),
    //       trailing: Chip(
    //         label: Text(widget.amount.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
    //         avatar: CircleAvatar(
    //           child: Image(image: AssetImage(conf.currencyIcon), width: 16,),
    //           backgroundColor: Colors.white,
    //           // foregroundColor: Colors.white,
    //         ),
    //         backgroundColor: categ.categColor[widget.category],
    //       ),
    //       onTap: (){
    //         // print("Pressed1");
    //       },
    //     ),
    //     Divider()
    //   ],
    // );
    String amtStr = ((widget.category == 'Lend' || widget.category == 'Expense') ? '-' : '+') + r" ₹ "+ widget.amount.toString();
    
    return accountItems(widget.desc, amtStr , widget.createDate != null ? DateFormat.yMMMd().format(DateTime.parse(widget.createDate))  : '', widget.category , widget.transactionType, oddColour: oddColor);
  }

  Container accountItems(String item, String charge, String dateString, String category, String type,{Color oddColour = Colors.white}) =>
      Container(
        decoration: BoxDecoration(color: oddColour),
        padding:
            EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(dateString, style: TextStyle(color: Colors.grey, fontSize: 14.0, fontStyle: FontStyle.italic )),
                Text(category + ' / ' + type, style: TextStyle(color: Colors.grey, fontSize: 14.0, fontStyle: FontStyle.italic ))
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(child: Text(item, style: TextStyle(fontSize: 16.0))),
                Text(charge, style: TextStyle(fontSize: 16.0, color: ((widget.category == 'Lend' || widget.category == 'Expense') ? Colors.red : Colors.green), fontStyle: FontStyle.italic ))
              ],
            ),
          ],
        ),
      );

}