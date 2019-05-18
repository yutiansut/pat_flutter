import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import '../config/config.dart' as conf;

Color strToCol(String s) {
  return Color(
    int.parse('0xFF' + s?.substring(1)?.toUpperCase() ?? "FFFFFF")
  );
}

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
  // print(items);
  return items;  
  });
}
