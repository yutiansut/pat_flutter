import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../../main.utils/pat_db_helper.dart';
import '../models/expense_purchase_model.dart';

class EXPForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Expense_purchaseForm();
  }
}

class Expense_purchaseForm extends State<EXPForm> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  ExpensePurchase exppur_d = ExpensePurchase('',0, DateTime.now());
  List<ExpensePurchase> expensePurchaselist;
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
  var displayResult = '';

  TextEditingController onlinestroecontoller = TextEditingController();
  // TextEditingController productcontroller = TextEditingController();
  TextEditingController expenseamountcontroller = TextEditingController();
  TextEditingController timecontoller = TextEditingController();
  TextEditingController descontroller = TextEditingController();

   @override
  Widget build(BuildContext context){

    if(expensePurchaselist == null){
      expensePurchaselist = List<ExpensePurchase>();
    }

     TextStyle textStyle = Theme.of(context).textTheme.title;

     return new Scaffold(
       appBar: AppBar(
          title: Text('Offline Expense'),
          backgroundColor: Colors.black,
         leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
            ),
            actions: <Widget>[
              Image(
	            width: 50,
	            image: AssetImage("assets/purchase.png"),
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
                      controller: onlinestroecontoller,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter the store name';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'CartName & Storename' ,
                          hintText: 'Name eg:amazon or Dostrix',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
  
                    ),
                  ),
                // Padding(
                //     padding: EdgeInsets.only(
                //         top: _minimumPadding, bottom: _minimumPadding),
                //     child: TextFormField(
                //       keyboardType: TextInputType.text,
                //       style: textStyle,
                //       controller: productcontroller,
                //       validator: (String value) {
                //         if (value.isEmpty) {
                //           return 'Please enter the productname';
                //         }
                //       },
                //       decoration: InputDecoration(
                //           labelText: 'Product Name',
                //           hintText: 'Eg: Sampoo',
                //           labelStyle: textStyle,
                //           errorStyle: TextStyle(
                //             color: Colors.yellowAccent,
                //             fontSize: 15.0
                //           ),
                //           border: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(5.0))),
                //     )),
                    Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: expenseamountcontroller,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter the Product amount';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Expense Amount',
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
    onlinestroecontoller.text = '';
    // productcontroller.text = '';
    expenseamountcontroller.text = '';
    timecontoller.text = '';
    descontroller.text = '';
  }

 

  void getSalaryFormValues() async{
    double expon = num.tryParse(expenseamountcontroller.text).toDouble();
    exppur_d.storename = onlinestroecontoller.text;
    // exppur_d.product = productcontroller.text;
    exppur_d.amount = expon;
    exppur_d.date = date;
    exppur_d.desc = descontroller.text;
    dynamic result = await databaseHelper.insertExpPurchase(exppur_d);
    print(result);
    if(result != 0){
      print('Purchase is Saved Successfully');
      Navigator.pop(context, true);
      // com.showSnackBar(context, 'Saved Successfully');
    }else{
      print('Not Saved.');
      // com.showSnackBar(context, 'Not Saved.');
    }
  }
}

