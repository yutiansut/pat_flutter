import 'package:flutter/material.dart';
import '../forms/income_reward_form.dart';
import 'package:sqflite/sqflite.dart';
import '../../main.utils/pat_db_helper.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class IncomeReward extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IncomeRewardList();
  }
}

class IncomeRewardList extends State<IncomeReward> {
  TextStyle descStyle =  TextStyle(fontWeight: FontWeight.w500);

  DatabaseHelper databaseHelper = DatabaseHelper();
	List<Map<String, dynamic>> rewardList;
  int count = 0;

  @override
  void initState(){
    super.initState();
    updateListView(); 
  }
   @override
  Widget build(BuildContext context) { 

    if (rewardList == null) {
			rewardList = List<Map<String, dynamic>>();
      updateListView(); 
		}
    
    return new Scaffold(
      
   body: ListView.builder(
       padding: EdgeInsets.all(12),
       
			itemCount: count,
			itemBuilder: (BuildContext context, int position) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.0),
              ),
					color: Colors.white,
					elevation: 2.0,
					child: Container(
            decoration: BoxDecoration(color: Colors.teal[50],
            borderRadius: BorderRadius.circular(60.0)),
            child:ListTile(
          
						leading: CircleAvatar(
              child: Text(this.rewardList[position]['contact'][0].toUpperCase() , textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25,color: Colors.white),),
							backgroundColor: Colors.blueGrey,
						),

						title: Text(this.rewardList[position]['contact'].toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold)),
          

						subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
    
              children: <Widget>[
                Text(this.rewardList[position]['description'], style: descStyle,)
              ],
            ),
            
            

						trailing: Column(
              children: <Widget>[
                Chip(
                  label: Text(this.rewardList[position]['amount'].toString()),
                  avatar:  Image(
                      width: 50,
                      image: AssetImage("assets/rupees.png"),
                    ),
                  backgroundColor: Colors.yellowAccent,
                ),

              ],
            ),
            onLongPress: () async {
              await _asyncConfirmDialog(context, this.rewardList[position]['id']);
            },
            


						// onTap: () {
						// 	debugPrint("ListTile Tapped");
						// 	navigateToDetail(this.noteList[position],'Edit Note');
						// },

					),
          ),
				);	
			},
		),
    floatingActionButton: new FloatingActionButton(
	      elevation: 0.0,
	      child: Image(
	        width: 50,
	        image: AssetImage("assets/inc_pen.png"),
	      ),
	      backgroundColor: Colors.transparent,
	      onPressed: () async{
	       var result = await Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new INForm()));

         if(result == true){
           updateListView();
         }
	      }
	    ),
      backgroundColor: Colors.white,
  );
  }

  Future<List<Map<String, dynamic>>> updateListView() async {
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {
        Future<List<Map<String, dynamic>>> noteListFuture = databaseHelper.getRewardMapList();
          noteListFuture.then((noteList) {
              setState(() {
                 this.rewardList = noteList;
                this.count = rewardList.length;
              });
        });
      });
  }

  void _delete(BuildContext context, int id) async {
		int result = await databaseHelper.deleteReward(id);
		if (result != 0) {
			updateListView();
		}else{
      print('Reward deleted');
    }
	}

  void _showSnackBar(BuildContext context, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(context).showSnackBar(snackBar);
	}

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context, id) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Dialog'),
          content: const Text(
              'Do you want to delete ?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('ACCEPT'),
              onPressed: () {
                _delete(context, id);
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }
}