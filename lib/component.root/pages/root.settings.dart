import 'package:flutter/material.dart';
import 'package:pat_dart/main.utils/pat_db_helper.dart';
import '../pages/settings.expenselmit.dart';


class SettingsRoot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingRoot();
  }
}

class SettingRoot extends State<SettingsRoot> {

  static const List<Image> icons = const [ 
    Image(width: 50, image: AssetImage("assets/profit.png")),
    Image(width: 50, image: AssetImage("assets/borrow.png")),
    Image(width: 50, image: AssetImage("assets/lend.png"))
  ];

  TextStyle descStyle =  TextStyle(fontWeight: FontWeight.w500);


	List<Map<String, dynamic>> settingList;
  double expenselimit = 0;
  int count = 0;
   DatabaseHelper databaseHelper = DatabaseHelper();

   var limts = [];

   

  @override
  void initState(){
    super.initState();
    updateListView(); 
    getExpenseLimit();
  }
   @override
  Widget build(BuildContext context) { 

    if (settingList == null) {
			settingList = List<Map<String, dynamic>>();
      updateListView(); 
		}

    if(this.limts == []){
      print('hello');
      getExpenseLimit();
    }
    
    return new Scaffold(
      appBar: AppBar(
        title: new Text('Settings'),
      backgroundColor: Colors.lightGreen[900],
      ),
      
        body: ListView.builder(
       padding: EdgeInsets.all(18),
       
			itemCount: count,
			itemBuilder: (BuildContext context, int position) {
          return Card(
          shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.0),
                
              ),
					color: Colors.white,
					child: Container(
            decoration: BoxDecoration(color: Colors.teal[50],
            borderRadius: BorderRadius.circular(60.0)),

            child:
             ListTile(
          
						leading: CircleAvatar(
              child: icons[position],
              backgroundColor: Colors.transparent
						),

						title: Text(this.settingList[position]['key'].toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold)),
						onTap: () async{
							debugPrint("ListTile Tapped");
              pageRoute(position);
						},
            trailing: Column(
              children: <Widget>[
                  Chip(
                label: Text(this.limts[position].toString()),
              avatar:  Image(
                  width: 50,
                  image: AssetImage("assets/rupees.png"),
        ),
      backgroundColor: Colors.purpleAccent,
    )

              ],
            ),

					),
          )
				);	
			},
		),
      backgroundColor: Colors.white,
  );
  }


  void pageRoute(index) async{
    var pages = [new SettingsExpenseLimit()];
    print(index);
    await Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> pages[index]));
  }

 
 void updateListView(){
   settingList = [];
   var sett = ['Expenselimit','BarrowsLimit','Lendlimit'];

   for(var i=0;i<sett.length;i++){
     settingList.add({'key':sett[i]});
   }

   this.count = sett.length;
 }

 void getExpenseLimit() async{
    var explim = await databaseHelper.getExpenseLimit();
    var barlim = await databaseHelper.getBarrowLimit();
    var lenlin = await databaseHelper.getLendsLimit();
    
    setState(() {
      this.limts.insert(0, explim[0]['expenselimit']);
      this.limts.insert(1, barlim[0]['barrowlimit']);
      this.limts.insert(2, lenlin[0]['lendlimit']);
    });  
 }

}