import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../../main.utils/pat_db_helper.dart';
import '../models/salary_model.dart';

class INForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Income_RewardFrom();
  }
}

class Income_RewardFrom extends State<INForm> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  Salary salary_d = Salary('', 0, DateTime.now());
  List<Salary> rewardlist;
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
  TextEditingController salarycontroller = TextEditingController();
  TextEditingController timecontoller = TextEditingController();
  TextEditingController descontroller = TextEditingController();

  var displayResult = '';

   @override
  Widget build(BuildContext context){
    if(rewardlist == null){
      rewardlist = List<Salary>();
    }


     TextStyle textStyle = Theme.of(context).textTheme.title;

     return new Scaffold(
       appBar: AppBar(
          title: Text('Salary'),
          backgroundColor: Color.fromRGBO(107, 99, 255, 1),
         leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
            ),
            actions: <Widget>[
              Image(
	            width: 38,
	            image: AssetImage("assets/salary.png"),
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
                      controller: salarycontroller,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter the Salary amount';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Salary Amount',
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
                
                Padding(
                    padding: EdgeInsets.only(
                        bottom: _minimumPadding, top: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color:Color.fromRGBO(107, 99, 255, 1),
                            textColor: Colors.white,
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
                            color:Color.fromRGBO(107, 99, 255, 1),
                            textColor: Colors.white,
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
      ),
      backgroundColor: Colors.white,
    );
  }

 

  void _reset() async{
    salarycontroller.text = '';
    contactcontoller.text = '';
    timecontoller.text = '';
    descontroller.text = '';
  }

  void getRewardFormValues() async{
    double sal = num.tryParse(salarycontroller.text).toDouble();
    salary_d.contact = contactcontoller.text;
    salary_d.amount = sal;
    salary_d.date = date;
    salary_d.desc = descontroller.text;
    dynamic result = await databaseHelper.insertSalary(salary_d);
    print(result);
    if(result != 0){
      print('Salary Saved Successfully');
      Navigator.pop(context, true);
      
    }else{
      print('Not Saved.');
    }
  }
}

