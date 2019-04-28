class Lender{

    int _id;
    String _lendername;
    double _amount;
    DateTime _date;
    String _desc;

    //default constructor
    Lender(this._lendername,this._amount,this._date,[this._desc]);

    //Named constructor 
    Lender.withId(this._id,this._lendername,this._amount,this._date,[this._desc]);

    //Getters
    int get id => _id;
    String get lendername => _lendername;
    double get amount => _amount;
    DateTime get date => _date;
    String get dec => _desc;


    //Setters
    set lendername(String name){
      if(name.length <= 20){
        this._lendername = name;
      }
    }

    set amount(double amo){
      this._amount = amo;
    }

    set date(DateTime date){
      this._date = date;
    }

    set description(String desc){
      this._desc = desc;
    }


    //Convert the input data into MapObject
    Map<String,dynamic> toMap(){
      var map = Map<String,dynamic>();

      if(_id != null){
        map['id'] = _id;
      }
      map['lendername'] = _lendername;
      map['amount'] = _amount;
      map['date'] = _date;
      map['description'] = _desc;

      return map;
    }



    //Get the Data From MapObject

    Lender.fromMapObject(Map<String,dynamic> map){
      this._id = map['id'];
      this._lendername = map['lendername'];
      this._amount = map['amount'];
      this._date = map['date'];
      this._desc = map['description'];
    }

}