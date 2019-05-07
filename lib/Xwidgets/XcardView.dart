import 'package:flutter/material.dart';

class XCardView extends StatefulWidget {
  String title = "";
  String subtitle = "";
  Widget leading = Icon(Icons.account_balance_wallet);

  XCardView({Key key, this.title, this.subtitle, this.leading}): super(key: key);

  @override
  _XCardViewState createState() => _XCardViewState();
}

class _XCardViewState  extends State<XCardView>{
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: widget.leading,
              title: Text(widget.title),
              subtitle: Text(widget.subtitle),
              trailing: widget.leading,
              onTap: (){
                // print("Pressed");
              },
            ),
            ButtonTheme.bar(
              child: ButtonBar(
                children: <Widget>[
                  // FlatButton(
                  //   child: Text("Open"),
                  //   onPressed: (){},
                  // ),
                  /* FlatButton(
                    child: Text("Watch Trailer"),
                    onPressed: (){},
                  ), */
                ],
              ),
            )
          ],
        ),
      ),
    );
  } 
}