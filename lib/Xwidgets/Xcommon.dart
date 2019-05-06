// import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import '../config/config.dart' as conf;

DateTime convertToDate(String input) {
  try 
  {
    var d = new DateFormat.yMd().parseStrict(input);
    return d;
  } catch (e) {
    return null;
  }    
}

getM2o(listFeature) {
  List<Map<dynamic, dynamic>> items = List();
  listFeature.then((lists){
    for (var i = 0; i < lists.length; i++) {
      // print(lists[i]);
      Map m = Map();
      m['id'] = lists[i]['id'];
      m['name'] = lists[i]['name'];
      items.add(m);
    }
  print(items);
  return items;  
  });
}

/* class Xmany2one extends StatefulWidget {
  Future<List<Map>> listItems;
  Widget leading = Icon(Icons.account_balance_wallet);

  Xmany2one(this.listItems);

  @override
  _Xmany2oneState createState() => _Xmany2oneState();
}

class _Xmany2oneState  extends State<Xmany2one>{

  // Future<List<Map>> listItems;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedItem;

  getNames(mapList){
    List newList;
    print(widget.listItems);
    for (var i = 0; i < mapList; i++) {
      newList.add({'id': mapList[i]['id'], 'name': mapList[i]['name']});
    }
    return newList;
  }


  @override
  void initState() {
    _dropDownMenuItems = buildAndGetDropDownMenuItems(widget.listItems);
    if(_dropDownMenuItems.length > 0){
    _selectedItem = _dropDownMenuItems[1].value;
    }
    super.initState();
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(Future<List<Map>> _listItems) {
    List<DropdownMenuItem<String>> items = new List();
    _listItems.then((lists){
      for (var i = 1; i < lists.length; i++) {
        items.add(new DropdownMenuItem(value:  lists[i]['id'].toString(), child: new Text(lists[i]['name'])));
      }
    });
    return items;
  }

  void changedDropDownItem(String selectedItem) {
    setState(() {
      _selectedItem = selectedItem;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: _selectedItem,
      items: _dropDownMenuItems,
      onChanged: changedDropDownItem,
    );
  } 
} */