import 'package:flutter/material.dart';
import '../forms/income_reward_form.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/incomedb_helper.dart';


class IncomeReward extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IncomeRewardList();
  }
}

class IncomeRewardList extends State<IncomeReward> {

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
			itemCount: count,
			itemBuilder: (BuildContext context, int position) {
        print(this.rewardList[position]['amount']);
          return Card(
					color: Colors.white,
					elevation: 2.0,
					child: ListTile(

						leading: CircleAvatar(
							backgroundColor: Colors.black87,
              child: Text(this.rewardList[position]['contact'][0], style: TextStyle(color: Colors.yellow, fontSize: 28.0),),
						),

						title: Text(this.rewardList[position]['contact']),

						subtitle: Text(this.rewardList[position]['amount'].toString()),

						trailing: GestureDetector(
							child: Icon(Icons.delete, color: Colors.grey,),
							onTap: () {
								_delete(context, this.rewardList[position]['id']);
							},
						),


						// onTap: () {
						// 	debugPrint("ListTile Tapped");
						// 	navigateToDetail(this.noteList[position],'Edit Note');
						// },

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
	      onPressed: (){
	        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new INForm()));
	      }
	    )
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
			_showSnackBar(context, 'Reward Deleted Successfully');
			updateListView();
		}else{
      print('Reward deleted');
    }
	}

  void _showSnackBar(BuildContext context, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(context).showSnackBar(snackBar);
	}
}