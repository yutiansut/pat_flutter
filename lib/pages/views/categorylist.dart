import 'dart:async' show Future;

import 'package:flutter/material.dart' show AlignmentDirectional, AppBar, BuildContext, CircularProgressIndicator, Column, Container, CrossAxisAlignment, Divider, EdgeInsets, FontWeight, FutureBuilder, ListView, Scaffold, State, StatefulWidget, Text, TextStyle, Widget;
import 'package:flutter/material.dart';

import '../models/category.dart' show Category;
import './categ_detail.dart' show CategoryDetailPage;

Category categDb = Category();
//Future<List<Map<String, dynamic>>>
Future<List<Map>> fetchCategoriesFromDatabase() async {
  return categDb.getCategories();
}

class MyCategoryList extends StatefulWidget {
  @override
  MyCategoryListPageState createState() => new MyCategoryListPageState();
}

class MyCategoryListPageState extends State<MyCategoryList> {
  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Category List'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Add New Category',
              onPressed: () {
                navigateToCategoryDetail("Add Category", {});
              },
            )
        ],
      ),
      body: new Container(
        padding: new EdgeInsets.all(16.0),
        child: new FutureBuilder<List<Map>>(
          future: fetchCategoriesFromDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    // return new Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: <Widget>[
                    //       new Text(snapshot.data[index]['name'],
                    //           style: new TextStyle(
                    //               fontWeight: FontWeight.bold, fontSize: 18.0)),
                    //       new Text(snapshot.data[index]['createDate'],
                    //           style: new TextStyle(
                    //               fontWeight: FontWeight.bold, fontSize: 14.0)),
                    //      /*  new Text(snapshot.data[index]['parentId'],
                    //           style: new TextStyle(
                    //               fontWeight: FontWeight.bold, fontSize: 14.0)), */
                    //       new Divider()
                    //     ],
                    // );
                    return Card(
                      elevation: 2.0,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.purple,
                          child: Text(snapshot.data[index]['name'][0], style:  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                        ),
                        title: Text(snapshot.data[index]['name'], style: titleStyle),
                        trailing: GestureDetector(
                          child: Icon(Icons.delete, color: Colors.red),
                          onTap: () {
                            // _delete(context, snapshot.data[index]['id']);
                            print(snapshot.data[index]);
                            _delete(snapshot.data[index]['id']);
                          },
                        ),


                        onTap: () {
                          // navigateToDetail(this.accountList[position],'Edit AccountType');
                          navigateToCategoryDetail("Edit Category", snapshot.data[index]);
                        },
                      ),                      
                    );
                  });
            } else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }
            return new Container(alignment: AlignmentDirectional.center,child: new CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }

  void moveToLastScreen(){
    Navigator.pop(context);
  }
  
  void _delete(int id) async {

		// moveToLastScreen();

		// Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
		// the detail page by pressing the FAB of NoteList page.
		if (id == null) {
			print('Warning : No Type was deleted');
			return;
		}
    
    categDb.delete("Category", id);
    MyCategoryList();

  }

  

  void navigateToCategoryDetail(String title, Map listData){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryDetailPage(title, listData)),
    );
  }
}
