class Salary{
  int _id;
  String _contact;
  double _amount;
  DateTime _date;
  String _desc;

  //default Constructor
  Salary(this._contact,this._amount,[this._date, this._desc]);

  //Named Constructor
  Salary.withId(this._id,this._contact,this._amount,[this._date, this._desc]);

  //Getters
  int get id => _id;
  String get contact => _contact;
  double get amount => _amount;
  DateTime get date => _date;
  String get desc => _desc;

  //Setters
  set contact(String newContact){
    if(newContact.length <= 25){
      this._contact = newContact;
    }
  }

  set amount(double amount){
    this._amount = amount;
  }

  set date(DateTime date){
    this._date = date;
  }

  set desc(String desc){
    if(desc.length <= 30){
      this._desc = desc;
    }
  }


  //Convert the input data to Map objects
  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    if(_id != null){
      map['id'] = _id;
    }
    map['contact'] = _contact;
    map['amount'] = _amount;
    map['date'] = _date;
    map['description'] = _desc;

    return map;
  }

  //Extract the data from MapObject
  // Salary.fromMapObject(Map<String,dynamic> map){
  //   this._id = map['_id'];
  //   this._contact = map['_contact'];
  //   this._amount = 0.0;
  //   this._date = map['date'];
  //   this._desc = map['description'];
  // }
}