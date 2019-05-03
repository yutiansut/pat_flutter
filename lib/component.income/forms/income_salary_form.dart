import 'package:flutter/material.dart';
import '../models/salary_model.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../../main.utils/pat_db_helper.dart';

class INForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Income_salaryFrom();
  }
}

class Income_salaryFrom extends State<INForm> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  Salary salary_d = Salary('', 0, DateTime.now());
  List<Salary> salarylist;
  int count = 0;

  static var _priorities = ['Salary', 'Reward'];



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
    if(salarylist == null){
      salarylist = List<Salary>();
    }


     TextStyle textStyle = Theme.of(context).textTheme.title;

     return new Scaffold(
       appBar: AppBar(
          title: Text('Salary'),
          backgroundColor: Colors.black,
         leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
            ),
            actions: <Widget>[
              Image(
	            width: 50,
	            image: AssetImage("assets/salary.png"),
	          )
            ],
          
       ),
        body: Padding(
		    padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
		    child: ListView(
			    children: <Widget>[

			    	// First element
				    ListTile(
					    title: DropdownButton(
							    items: _priorities.map((String dropDownStringItem) {
							    	return DropdownMenuItem<String> (
									    value: dropDownStringItem,
									    child: Text(dropDownStringItem),
								    );
							    }).toList(),

							    style: textStyle,

							    // value: getPriorityAsString(),

							    onChanged: (valueSelectedByUser) {
							    	setState(() {
							    	  debugPrint('User selected $valueSelectedByUser');
							    	  updatePriorityAsInt(valueSelectedByUser);
							    	});
							    }
					    ),
				    ),

				    // Second Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
						    controller: contactcontoller,
						    style: textStyle,
						    onChanged: (value) {
						    	debugPrint('Something changed in Title Text Field');
						    	
						    },
						    decoration: InputDecoration(
							    labelText: 'Title',
							    labelStyle: textStyle,
							    border: OutlineInputBorder(
								    borderRadius: BorderRadius.circular(5.0)
							    )
						    ),
					    ),
				    ),

				    // Third Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
                keyboardType: TextInputType.number,
						    controller: salarycontroller,
						    style: textStyle,
						    onChanged: (value) {
							    debugPrint('Something changed in Description Text Field');
						    },
						    decoration: InputDecoration(
								    labelText: 'Amount',
								    labelStyle: textStyle,
								    border: OutlineInputBorder(
										    borderRadius: BorderRadius.circular(5.0)
								    )
						    ),
					    ),
				    ),

				    // Fourth Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: Row(
						    children: <Widget>[
						    	Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'Save',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
									    	setState(() {
									    	  debugPrint("Save button clicked");
									    	  getSalaryFormValues();
									    	});
									    },
								    ),
							    ),

							    Container(width: 5.0,),

							    Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'Delete',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
										    setState(() {
											    debugPrint("Delete button clicked");
											    _reset();
										    });
									    },
								    ),
							    ),

						    ],
					    ),
				    ),

			    ],
		    ),
	    ),


    );
  }

  String getPriorityAsString(int value) {
		String priority;
		switch (value) {
			case 1:
				priority = _priorities[0];  // 'High'
				break;
			case 2:
				priority = _priorities[1];  // 'Low'
				break;
		}
		return priority;
	}

  void _reset() async{
    salarycontroller.text = '';
    contactcontoller.text = '';
    timecontoller.text = '';
    descontroller.text = '';
  }

  void updatePriorityAsInt(String value) {
		switch (value) {
			case 'Salary':
				
				break;
			case 'Reward':
				
				break;
		}
	}


  void backtoScreen() async{
    await Navigator.pop(context);
    setState(() {});
  }

  void getSalaryFormValues() async{
    double sal = num.tryParse(salarycontroller.text).toDouble();
    salary_d.contact = contactcontoller.text;
    salary_d.amount = sal;
    salary_d.date = date;
    salary_d.desc = descontroller.text;
    dynamic result = await databaseHelper.insertSalary(salary_d);
    print(result);
    if(result != 0){
      print('Saved Successfully');
      await backtoScreen();
      // com.showSnackBar(context, 'Saved Successfully');
    }else{
      print('Not Saved.');
      // com.showSnackBar(context, 'Not Saved.');
    }
  }
}

