import 'package:flutter/material.dart';
import '../../main.utils/pat_db_helper.dart';
import '../../main.utils/models_models/model.login.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class SettingsExpenseLimit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExpenseLimit();
  }
}

class ExpenseLimit extends State<SettingsExpenseLimit> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  Settings setting_d = Settings('',0 ,0,0);
  List<Settings> settinglist;
  int count = 0;

 


  var _formKey = GlobalKey<FormState>();


  final double _minimumPadding = 5.0;




  TextEditingController expenselimitcontoller = TextEditingController();

 

  var displayResult = '';

   @override
  Widget build(BuildContext context){
    if(settinglist == null){
      settinglist = List<Settings>();
    }


     TextStyle textStyle = Theme.of(context).textTheme.title;

     return new Scaffold(
       appBar: AppBar(
          title: Text('ExpenseLimit'),
          backgroundColor: Colors.purpleAccent,
         leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
            ),
            actions: <Widget>[
              Image(
	            width: 50,
	            image: AssetImage("assets/profit.png"),
	          )
            ],
          
       ),
        body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: expenselimitcontoller,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter the ExpenseLimit';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Expense Limit',
                          hintText: 'Ex: 12000',
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
                              getRewardFormValues(context);
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
    
    expenselimitcontoller.text = '';
  }

  void getRewardFormValues(context) async{

      setting_d.expenselimit = num.tryParse( expenselimitcontoller.text).toDouble();
      var result = await databaseHelper.updateSettingsExpenseLimit(setting_d);
      if(result != 0){
        _asyncConfirmDialog(context,'Successfully Updated');
      }else{
        _asyncConfirmDialog(context,'DB Error');
      }
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context,String message) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Meassage'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: const Text('Ok'),
              onPressed: () {
                // _delete(context, id);
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  

}

