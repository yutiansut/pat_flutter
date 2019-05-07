import 'dart:async' show Future;
import 'package:flutter/material.dart';

import './../../Xwidgets/XDialog.dart' as Dialog;

import './../../dbutils/DBhelper.dart' show Models;
import '../models/category.dart' show categColor;
import './categ_detail.dart' show CategoryDetailPage;


Models models = Models();

Dialog.Dialog dialog = Dialog.Dialog();

//Future<List<Map<String, dynamic>>>
Future<List<Map>> fetchCategoriesFromDatabase() async {
  return models.getTableData("Category");
}

class MyCategoryList extends StatefulWidget {
  @override
  MyCategoryListPageState createState() => new MyCategoryListPageState();
}

class MyCategoryListPageState extends State<MyCategoryList> {
  Future listViewFeature = fetchCategoriesFromDatabase();
  
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
        padding: new EdgeInsets.all(0.0),
        child: new FutureBuilder<List<Map>>(
          future: listViewFeature,
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
                          backgroundColor: categColor[snapshot.data[index]['categoryType']],
                          child: Text(snapshot.data[index]['name'][0].toUpperCase(), style:  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                        ),
                        title: Text(snapshot.data[index]['name'].toString(), style: titleStyle),
                        subtitle: Row(
                          children: <Widget>[
                            Text(snapshot.data[index]['categoryType']),
                            // Text(snapshot.data[index]['createDate'],),
                            // Text(snapshot.data[index]['parentId'].toString()),
                          ],
                        ),
                        trailing: GestureDetector(
                          child: Icon(Icons.delete, color: Colors.red),
                          onTap: () {
                            dialog.asyncConfirm(context).then((choice){
                              if(choice == true){
                                _delete(snapshot.data[index]['id']);
                              }
                            });
                          },
                        ),

                        onTap: () {
                          // navigateToDetail(this.accountList[position],'Edit AccountType');
                          navigateToCategoryDetail("Edit Category(" + snapshot.data[index]['id'].toString() + ")", snapshot.data[index]);
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
    
    models.delete("Category", id);
    updateListView();
  }

  void updateListView(){
    setState(() {
      listViewFeature = fetchCategoriesFromDatabase();
    });
  }  

  void navigateToCategoryDetail(String title, Map listData) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
		  return CategoryDetailPage(title, listData);
	  }));

	  if (result == true) {
	  	updateListView();
	  }
  }
}
