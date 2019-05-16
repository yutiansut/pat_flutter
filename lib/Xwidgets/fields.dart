
import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import './../dbutils/DBhelper.dart' show Models;

Models models = Models();

//Future<List<Map<String, dynamic>>>
Future<List<Map>> fetchTableFromDatabase(tbl) async {
  return models.getTableData(tbl);
}

bool validateStr(String s){
  if (s != '' || s != null || s != '0' || s.length == 0) {
    return true;
  }
  return false;
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
                      Text(validateStr(valueField1) ? data[i][valueField1].toString() : defaultValue.keys.first, style: TextStyle(fontSize: 12, color: Colors.grey[400])),
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
}

class WidgetSelection extends StatefulWidget {
  final String label;
  final String controllerText;
  final String defaultValue;
  final List items;
  final onChanged;
  final onSaved;

  WidgetSelection({Key key, @required this.label, @required this.controllerText, this.defaultValue, @required this.items, this.onChanged, this.onSaved}) : super(key: key);

  _WidgetSelectionState createState() => _WidgetSelectionState();
}

class _WidgetSelectionState extends State<WidgetSelection> {

  String controllerText;
  String defaultValue;
  List items;

  @override
  void initState() {
    super.initState();
    defaultValue = widget.defaultValue ?? '';
    controllerText = widget.controllerText;
    items = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: widget.label),
      value: validateStr(controllerText) ? controllerText : defaultValue,
      items: items.map((item){
        return DropdownMenuItem(
          value: item,
          child:Text(item)
        );
      }).toList()
      ..add(DropdownMenuItem(value: defaultValue, child: Text(defaultValue),)),
      onChanged: (val){
        setState(() {
          controllerText = val;
          val = (val == null || val == '') ? null : val;
          widget.onChanged(val);
        });
      },
      onSaved: widget.onSaved,
    );
  }
}

class DateTimeItem extends StatelessWidget {
  DateTimeItem({Key key, DateTime dateTime, @required this.onChanged})
      : assert(onChanged != null),
        date = dateTime == null
            ? new DateTime.now()
            : new DateTime(dateTime.year, dateTime.month, dateTime.day),
        time = dateTime == null
            ? new DateTime.now()
            : new TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
        super(key: key);

  final DateTime date;
  final TimeOfDay time;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new InkWell(
            onTap: (() => _showDatePicker(context)),
            child: new Padding(
                padding: new EdgeInsets.symmetric(vertical: 8.0),
                child: new Text(new DateFormat('EEEE, MMMM d').format(date))),
          ),
        ),
        new InkWell(
          onTap: (() => _showTimePicker(context)),
          child: new Padding(
              padding: new EdgeInsets.symmetric(vertical: 8.0),
              child: new Text('$time')),
        ),
      ],
    );
  }

  Future _showDatePicker(BuildContext context) async {
    DateTime dateTimePicked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: date.subtract(const Duration(days: 20000)),
        lastDate: new DateTime.now());

    if (dateTimePicked != null) {
      onChanged(new DateTime(dateTimePicked.year, dateTimePicked.month,
          dateTimePicked.day, time.hour, time.minute));
    }
  }

  Future _showTimePicker(BuildContext context) async {
    TimeOfDay timeOfDay =
        await showTimePicker(context: context, initialTime: time);

    if (timeOfDay != null) {
      onChanged(new DateTime(
          date.year, date.month, date.day, timeOfDay.hour, timeOfDay.minute));
    }
  }
}