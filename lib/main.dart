import 'package:flutter/material.dart';
import 'package:pat_dart/main.utils/models_models/model.login.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'component.root/pages/root.dart';
import 'main.utils/pat_db_helper.dart';
import 'package:sqflite/sqflite.dart';



void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  DatabaseHelper databaseHelper = DatabaseHelper();
	List<Map<String, dynamic>> SettingsList;
  int count = 0;
  bool is_confrim = false;
  bool is_first_set = false;
  String is_set_temp1 = '';
  String is_set_temp2 = '';
  bool is_set_password = false;

  Settings setting_d =Settings('',0 ,0,0);
  List<Settings> settingslist;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  TextEditingController controller = TextEditingController();
  String thisText = "";
  int pinLength = 4;

  bool hasError = false;
  String errorMessage;

  

   @override
  Widget build(BuildContext context){
    if (SettingsList == null) {
			SettingsList = List<Map<String, dynamic>>();
      updateListView(); 
		}

    
    if(SettingsList.isNotEmpty){
      setState(() {
        if(this.SettingsList[0]['password'] != null){
        this.is_confrim = true;
      }
      });
    }

   
    

   

     return Scaffold(
      appBar: AppBar(
        title: Text("Personal Account Tracker"),
        backgroundColor: Color.fromRGBO(107, 99, 255, 1),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                   Image(
	                width: 300,
                  height: 200,
	                image: AssetImage("assets/icon.png"),
	              )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                // child: Text(thisText, style: Theme.of(context).textTheme.title),
              ),
              PinCodeTextField(
                autofocus: false,
                controller: controller,
                hideCharacter: true,
                highlight: true,
                highlightColor: Colors.blue,
                defaultBorderColor: Colors.black,
                hasTextBorderColor: Colors.blue,
                maxLength: pinLength,
                hasError: hasError,
                maskCharacter: "*",

                onTextChanged: (text) {
                  setState(() {
                    hasError = false;
                  });
                },
                onDone: (text){
                  print("DONE $text");
                },
                pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
                wrapAlignment: WrapAlignment.start,
                pinBoxDecoration: ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                pinTextStyle: TextStyle(fontSize: 30.0),
                pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
                pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
              ),
              Visibility(
                child: Text(
                  "Wrong PIN!",
                  style: TextStyle(color: Colors.red),
                ),
                visible: hasError,
              ),
              this.is_confrim ?
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MaterialButton(
                      color: Color.fromRGBO(107, 99, 255, 1),
                      textColor: Colors.white,
                      child: Text("Login"),
                      onPressed: () {
                        if(controller.text == this.SettingsList[0]['password']){
                          Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new RootPage()));
                        }
                      },
                    ),
                  ],
                ),
              ) :
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MaterialButton(
                      color: Color.fromRGBO(107, 99, 255, 1),
                      textColor: Colors.white,
                      child: this.is_set_password ? Text('Confirm Password'): Text("Set Password"),
                      onPressed: () {
                         if(this.is_set_password == false){
                         this.is_set_temp1 = controller.text;
                         controller.text = '';
                         this.is_set_password = true;
                         }else{
                           print('hello');
                             this.is_set_temp2 = controller.text;
                              
                         }
                         
                          if(this.is_set_temp1 == this.is_set_temp2){
                            setState(() {
                            this.is_confrim = true;
                            controller.text = '';
                            });
                            setPass(this.is_set_temp1);
                            setState(() {
                              updateListView();
                            });
                          }
                       
                         
                      },
                    ),
                  ],
                ),
              ) ,
            ],
          ),
        ),
      ),
      
      
    );
  }

  Future<List<Map<String, dynamic>>> updateListView() async {
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {
        Future<List<Map<String, dynamic>>> noteListFuture = databaseHelper.getSettingsList();
          noteListFuture.then((noteList) {
              setState(() {
                 this.SettingsList = noteList;
                this.count = SettingsList.length;
              });
        });
      });
  }

  void setPass(String pass) async{
    
    setting_d.password = pass;
     dynamic result = await databaseHelper.insetSettings(setting_d);

     if(result != 0){
       print('Password Successfully upated');
     }

  }
}
  

