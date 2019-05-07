import 'package:flutter/material.dart';
import '../../main.utils/pat_db_helper.dart';
import '../../main.utils/models_models/model.login.dart';

class SettingsPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingPass();
  }
}

class SettingPass extends State<SettingsPassword> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  Settings setting_d = Settings('',0 ,0,0);
  List<Settings> settinglist;
  int count = 0;

 


  var _formKey = GlobalKey<FormState>();


  final double _minimumPadding = 5.0;




  TextEditingController currentpasswordcontoller = TextEditingController();
  TextEditingController newpasswordcontroller = TextEditingController();
 

  var displayResult = '';

   @override
  Widget build(BuildContext context){
    if(settinglist == null){
      settinglist = List<Settings>();
    }


     TextStyle textStyle = Theme.of(context).textTheme.title;

     return new Scaffold(
       appBar: AppBar(
          title: Text('Password'),
          backgroundColor: Colors.purpleAccent,
         leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
            ),
            actions: <Widget>[
              Image(
	            width: 50,
	            image: AssetImage("assets/password.png"),
	          )
            ],
          
       ),
        body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                // getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: currentpasswordcontoller,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter the Current Password';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Current Password' ,
                          hintText: '**********',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
  
                    ),
                  ),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: newpasswordcontroller,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter New Password';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'New Password',
                          hintText: '**********',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),  
                Padding(
                    padding: EdgeInsets.only(
                        bottom: _minimumPadding, top: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            textColor: Theme.of(context).primaryColorDark,
                            child: Text(
                              'Update',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              getRewardFormValues();
                            },
                          ),
                        ),
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              'Reset',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    this.displayResult,
                    style: textStyle,
                  ),
                )
          
              ],
            )),
      )
    );
  }

 

  void _reset() async{
    newpasswordcontroller.text = '';
    currentpasswordcontoller.text = '';
  }

  void getRewardFormValues() async{
    var curpass = currentpasswordcontoller.text;
    var newpass = newpasswordcontroller.text;
    setting_d.password = newpass;

    if(curpass == newpass){
      var result = await databaseHelper.updateSettingsPassword(setting_d);
      if(result != 0 ){
        print('Password Updated Successfully');
      }else{
        print('Password updation failed');
      }
    }
  }
}

