class Lender{

    int _id;
    String _barrowername;
    double _lendamount;
    DateTime _date;
    String _desc;

    //default constructor
    Lender(this._barrowername,this._lendamount,this._date,[this._desc]);

    //Named Constructor
    Lender.withId(this._id,this._barrowername,this._lendamount,this._date,[this._desc]);

    //Getters
    int get id => _id;
    String get barrowername => _barrowername;
    double get lendamount => _lendamount;
    DateTime get date => _date;
    String get desc => _desc;

    //Setters
    set barrowername(String banname){
      if(banname.length <= 20){
        this._barrowername = banname;
      }
    }

    set lendamount(double lendamo){
      this._lendamount = lendamo;
    }

    set date(DateTime date){
      this._date = date;
    }

    set description(String desc){
      this._desc = desc;
    }



    //converts the input data into Map Object
    Map<String,dynamic> toMap(){
      var map = Map<String,dynamic>();

      if(_id != null){
        map['id'] = _id;
      } 
      map['barrowername'] = _barrowername;
      map['lendamount'] = _lendamount;
      map['date'] = _date;
      map['description'] = _desc;

      return map;
    }

    //Get the date from MapObject
    Lender.fromMapObject(Map<String,dynamic> map){
      this._id = map['id'];
      this._barrowername = map['barrowername'];
      this._lendamount = map['lendamount'];
      this._date = map['date'];
      this._desc = map['description'];
    }

}