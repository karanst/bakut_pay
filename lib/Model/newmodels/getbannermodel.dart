/// error : false
/// data : [{"id":"7","type":"default","type_id":"102","image":"https://developmentalphawizz.com/financego/uploads/media/2021/Launch_PrintStop_Plus_Program.jpg","date_added":"2021-11-30 16:52:36","data":[]},{"id":"16","type":"","type_id":"0","image":"https://developmentalphawizz.com/financego/uploads/media/2023/3014BankitRechargeImage.png","date_added":"2023-03-29 12:43:28","data":[]}]

class Getbannermodel {
  Getbannermodel({
      bool? error, 
      List<Data>? data,}){
    _error = error;
    _data = data;
}

  Getbannermodel.fromJson(dynamic json) {
    _error = json['error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  List<Data>? _data;
Getbannermodel copyWith({  bool? error,
  List<Data>? data,
}) => Getbannermodel(  error: error ?? _error,
  data: data ?? _data,
);
  bool? get error => _error;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "7"
/// type : "default"
/// type_id : "102"
/// image : "https://developmentalphawizz.com/financego/uploads/media/2021/Launch_PrintStop_Plus_Program.jpg"
/// date_added : "2021-11-30 16:52:36"
/// data : []

class Data {
  Data({
      String? id, 
      String? type, 
      String? typeId, 
      String? image, 
      String? dateAdded, 
      List<dynamic>? data,}){
    _id = id;
    _type = type;
    _typeId = typeId;
    _image = image;
    _dateAdded = dateAdded;
    _data = data;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _typeId = json['type_id'];
    _image = json['image'];
    _dateAdded = json['date_added'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(v.fromJson(v));
      });
    }
  }
  String? _id;
  String? _type;
  String? _typeId;
  String? _image;
  String? _dateAdded;
  List<dynamic>? _data;
Data copyWith({  String? id,
  String? type,
  String? typeId,
  String? image,
  String? dateAdded,
  List<dynamic>? data,
}) => Data(  id: id ?? _id,
  type: type ?? _type,
  typeId: typeId ?? _typeId,
  image: image ?? _image,
  dateAdded: dateAdded ?? _dateAdded,
  data: data ?? _data,
);
  String? get id => _id;
  String? get type => _type;
  String? get typeId => _typeId;
  String? get image => _image;
  String? get dateAdded => _dateAdded;
  List<dynamic>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['type_id'] = _typeId;
    map['image'] = _image;
    map['date_added'] = _dateAdded;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}