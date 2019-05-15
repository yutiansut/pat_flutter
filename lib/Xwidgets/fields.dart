
import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';
import './../dbutils/DBhelper.dart' show Models;

Models models = Models();

//Future<List<Map<String, dynamic>>>
Future<List<Map>> fetchTableFromDatabase(tbl) async {
  return models.getTableData(tbl);
}

class WidgetMany2One extends StatefulWidget {
  
  final String label;
  final String tbl;
  final String valueKeyField;
  final String valueField;
  final String valueField1;
  final Map<String, String> defaultValue;
  final String controllerText;
  final onChanged;
  final onSaved;

  WidgetMany2One({Key key, this.tbl, this.label, this.valueKeyField, this.valueField, this.valueField1, this.defaultValue, this.controllerText, this.onChanged, this.onSaved}): super(key: key);

  @override
  WidgetMany2OneState createState() => new WidgetMany2OneState();
}

class WidgetMany2OneState extends State<WidgetMany2One> {
  
  String label;
  Future tableDataFeature;
  String valueKeyField;
  String valueField;
  String valueField1;
  Map<String, String> defaultValue;
  String controllerText;

  @override
  void initState() {
    super.initState();
    tableDataFeature = fetchTableFromDatabase(widget.tbl);
    valueKeyField = widget.valueKeyField ?? 'id';
    valueField = widget.valueField ?? 'name';
    valueField1 = widget.valueField1 ?? '';
    defaultValue = widget.defaultValue ?? {'': 'No-Data'};
    label = widget.label ?? widget.tbl[0].toUpperCase() + widget.tbl.substring(1);
    controllerText = widget.controllerText;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map>>(
      future: tableDataFeature,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var data = snapshot.data;
          var dataLen = data.length;
          if(dataLen > 0){
            dynamic dropItems = [DropdownMenuItem(value: defaultValue.keys.first, child: Text(defaultValue.values.first),)];
            for (var i = 0; i < dataLen; i++) {
              dropItems.add(
                DropdownMenuItem(
                  value: data[i][valueKeyField].toString(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(data[i][valueField]),
                      SizedBox(width: 5,),
                      Text((valueField1 != '' || valueField1 != null || valueField1 != '0' || valueField1.length == 0) ? data[i][valueField1].toString() : '', style: TextStyle(fontSize: 12, color: Colors.grey[400])),
                    ],
                  ),
                )
              );
            }
            return DropdownButtonFormField(
              decoration: InputDecoration(labelText: label),
              value: validateStr(controllerText) ? controllerText : defaultValue.keys.first,
              // value: defaultValue.keys.first,
              items: dropItems,
              onChanged: (val){
                setState(() {
                  controllerText = val;
                  val = (val == null || val == '-') ? null : val;
                  widget.onChanged(val);
                });
              },
              onSaved: widget.onSaved,
            );
          }
        }
        return new Container(alignment: AlignmentDirectional.center,child: new CircularProgressIndicator(),);
      }
    );
  }

  bool validateStr(String s){
    if (s != '' || s != null || s != '0') {
      return true;
    }
    return false;
  }
}