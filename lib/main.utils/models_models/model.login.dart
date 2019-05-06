class Settings{
  
    int _id;
    String _password;
    double _expenselimit;
    double _barrowlimit;
    double _lendlimit;

    //default constructor
    Settings([this._password,this._expenselimit,this._barrowlimit,this._lendlimit]);

    //Named constructor
    Settings.withId(this._id,[this._password,this._expenselimit,this._barrowlimit,this._lendlimit]);

    //Getters
    int get id => _id;
    String get password => _password;
    double get expenselimit => _expenselimit;
    double get barrowlimit => _barrowlimit;
    double get lendlimti => _lendlimit;
   

   //Setters
   set password(String pass){
     if(pass.length < 10){
       this._password = pass;
     }
   }


   set expenselimit(double exp){
     this._expenselimit = exp;
   }

   set barrowlimt(double barrow){
     this._barrowlimit = barrow;
   }

   set lendlimt(double lend){
     this._lendlimit = lend;
   }


//Convert the input data to Map objects
  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    if(_id != null){
      map['id'] = _id;
    }
   
  }  

     
}