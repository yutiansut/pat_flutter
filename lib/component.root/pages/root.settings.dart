import 'package:flutter/material.dart';
import '../pages/settings.password.dart';


enum ConfirmAction { CANCEL, ACCEPT }

class SettingsRoot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingRoot();
  }
}

class SettingRoot extends State<SettingsRoot> {

  static const List<Image> icons = const [ 
    Image(width: 50, image: AssetImage("assets/password.png")),
    Image(width: 50, image: AssetImage("assets/income.png")),
    Image(width: 50, image: AssetImage("assets/profit.png")),
    Image(width: 50, image: AssetImage("assets/borrow_lend.png"))
  ];

  TextStyle descStyle =  TextStyle(fontWeight: FontWeight.w500);


	List<Map<String, dynamic>> settingList;
  int count = 0;

  @override
  void initState(){
    super.initState();
    updateListView(); 
  }
   @override
  Widget build(BuildContext context) { 

    if (settingList == null) {
			settingList = List<Map<String, dynamic>>();
      updateListView(); 
		}
    
    return new Scaffold(
      appBar: AppBar(
        title: new Text('Settings'),
      backgroundColor: Colors.purpleAccent,
      ),
      
        body: ListView.builder(
       padding: EdgeInsets.all(12),
       
			itemCount: count,
			itemBuilder: (BuildContext context, int position) {
          return Card(
					color: Colors.white,
					elevation: 2.0,
					child: ListTile(
          
						leading: CircleAvatar(
              child: icons[position],
              // style: TextStyle(fontSize: 25,color: Colors.white),),
							// backgroundColor: Colors.blueGrey,
						),

						title: Text(this.settingList[position]['key'].toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold)),
          

						// subtitle: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
    
            //   children: <Widget>[
            //     Text(this.rewardList[position]['description'], style: descStyle,)
            //   ],
            // ),
            
            

						// trailing: Column(
            //   children: <Widget>[
            //     Chip(
            //       label: Text(this.rewardList[position]['amount'].toString()),
            //       avatar:  Image(
            //           width: 50,
            //           image: AssetImage("assets/rupees.png"),
            //         ),
            //       backgroundColor: Colors.yellowAccent,
            //     ),

            //   ],
            // ),
            // onLongPress: () async {
            //   await _asyncConfirmDialog(context, this.rewardList[position]['id']);
            // },
            


						onTap: () async{
							debugPrint("ListTile Tapped");
							await Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new SettingsPassword()));
						},

					),
				);	
			},
		),
    // floatingActionButton: new FloatingActionButton(
	  //     elevation: 0.0,
	  //     child: Image(
	  //       width: 50,
	  //       image: AssetImage("assets/inc_pen.png"),
	  //     ),
	  //     backgroundColor: Colors.transparent,
	  //     onPressed: () async{
	  //      var result = await Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new INForm()));

    //      if(result == true){
    //        updateListView();
    //      }
	  //     }
	  //   ),
      backgroundColor: Colors.black,
  );
  }

 
 void updateListView(){
   settingList = [];
   var sett = ['Password','Expenselimit','BarrowsLimit','Lendlimit'];

   for(var i=0;i<sett.length;i++){
     settingList.add({'key':sett[i]});
   }

   this.count = sett.length;
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
                // _delete(context, id);
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }
}