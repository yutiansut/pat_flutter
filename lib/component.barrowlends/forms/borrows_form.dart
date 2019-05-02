import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../../main.utils/pat_db_helper.dart';
import '../models/barrows_model.dart';

class BarrowForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BarrowsForm();
  }
}


class BarrowsForm extends State<BarrowForm> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  Barrow barrow_d = Barrow('', 0, DateTime.now());
  List<Barrow> barrowlist;
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

  TextEditingController lendercontoller = TextEditingController();
  TextEditingController barrowcontroller = TextEditingController();
  TextEditingController timecontoller = TextEditingController();
  TextEditingController descontroller = TextEditingController();

  var displayResult = '';


   @override
  Widget build(BuildContext context){

    if(barrowlist == null){
      barrowlist = List<Barrow>();
    }

     TextStyle textStyle = Theme.of(context).textTheme.title;

     return new Scaffold(
       appBar: AppBar(
          title: Text('Barrows'),
          backgroundColor: Colors.black,
         leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
            ),
            actions: <Widget>[
              Image(
	            width: 50,
	            image: AssetImage("assets/barrow.png"),
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
                      controller: lendercontoller,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter the Lender name';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Lender Name' ,
                          hintText: 'Name eg:Bala or Kalai',
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
                      controller: barrowcontroller,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter the barrow amount';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Barrow Amount',
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
                              getSalaryFormValues();
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
    lendercontoller.text = '';
    barrowcontroller.text = '';
    timecontoller.text = '';
    descontroller.text = '';
  }

 

  void getSalaryFormValues() async{
    double sal = num.tryParse(barrowcontroller.text).toDouble();
    barrow_d.lendername = lendercontoller.text;
    barrow_d.amount = sal;
    barrow_d.date = date;
    barrow_d.description = descontroller.text;
    dynamic result = await databaseHelper.insertBarrows(barrow_d);
    print(result);
    if(result != 0){
      print('Saved Successfully');
      Navigator.pop(context, false);
      // com.showSnackBar(context, 'Saved Successfully');
    }else{
      print('Not Saved.');
      // com.showSnackBar(context, 'Not Saved.');
    }
  }
}

