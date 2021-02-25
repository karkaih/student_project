class Student {
//attributes
  int _id;

  String _name;

  String _desc;
  int _pass;
  String _date;

  //Constructor
  Student(this._name, this._desc, this._pass, this._date);

  Student.withId(this._id, this._name, this._desc, this._pass, this._date);

  // Getters
  String get date => _date;

  int get pass => _pass;

  String get desc => _desc;

  String get name => _name;

  int get id => _id;

  // Setters

  set date(String value) {
    _date = value;
  }

  set pass(int value) {
    if (value >= 1 && value <= 2) {
      _pass = value;
    }
  }

  set desc(String value) {
    if (value.length <= 155) {
      _desc = value;
    }
  }

  set name(String value) {
    if (value.length <= 155) {
      _name = value;
    }
  }

// Functions

  Map<String, dynamic> toMap() {
    //Object to map
    var map = Map<String, dynamic>();

    map["id"] = this._id;
    map["name"] = this._name;
    map["desc"] = this._desc;
    map["pass"] = this._pass;
    map["date"] = this._date;

    return map;
  }

  Student.getMap(Map<String, dynamic> map) {
    //map to obj
    this._id = map["id"];
    this._name = map["name"];
    this._desc = map["desc"];
    this._pass = map["pass"];
    this._date = map["date"];
  }
}
