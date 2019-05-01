import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../utils/incomedb_helper.dart';
import '../models/reward_model.dart';

class INForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Income_RewardFrom();
  }
}

class Income_RewardFrom extends State<INForm> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  Reward reward_d = Reward('', 0, DateTime.now());
  List<Reward> rewardlist;
  int count = 0;

 


  final formats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };

  // Changeable in demo
  InputType inputType = InputType.both;
  bool editable = true;
  DateTime date;

  var _formKey = GlobalKey<FormState>();


  final double _minimumPadding = 5.0;




  TextEditingController contactcontoller = TextEditingController();
  TextEditingController rewardcontroller = TextEditingController();
  TextEditingController timecontoller = TextEditingController();
  TextEditingController descontroller = TextEditingController();

  var displayResult = '';

   @override
  Widget build(BuildContext context){
    if(rewardlist == null){
      rewardlist = List<Reward>();
    }


     TextStyle textStyle = Theme.of(context).textTheme.title;

     return new Scaffold(
       appBar: AppBar(
          title: Text('Reward'),
          backgroundColor: Colors.black,
         leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
            ),
            actions: <Widget>[
              Image(
	            width: 50,
	            image: AssetImage("assets/reward.png"),
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
                      // keyboardType: TextInputType.text,
                      style: textStyle,
                      controller: contactcontoller,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter the contact name';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Contact & Company' ,
                          hintText: 'Name eg:Bala or Dostrix',
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
                      controller: rewardcontroller,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter the Reward amount';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Reward Amount',
                          hintText: 'Rupees',
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
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      // keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: descontroller,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter the description';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'optional',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                DateTimePickerFormField(
              inputType: inputType,
              format: formats[inputType],
              editable: editable,
              controller: timecontoller,
              decoration: InputDecoration(
                  labelText: 'Date/Time', hasFloatingPlaceholder: false),
              onChanged: (dt) => setState((){ 
                print(dt);
                date = dt;
                print(date);
                }),
            ),
                
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
                              'Save',
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
    rewardcontroller.text = '';
    contactcontoller.text = '';
    timecontoller.text = '';
    descontroller.text = '';
  }

  void getRewardFormValues() async{
    double sal = num.tryParse(rewardcontroller.text).toDouble();
    reward_d.contact = contactcontoller.text;
    reward_d.amount = sal;
    reward_d.date = date;
    reward_d.desc = descontroller.text;
    dynamic result = await databaseHelper.insertReward(reward_d);
    print(result);
    if(result != 0){
      print('Reward Saved Successfully');
      Navigator.pop(context, false);
      
    }else{
      print('Not Saved.');
    }
  }
}

