/// error : false
/// message : "Services Get Successfully"
/// data : [{"id":"2","name":"Gas Bill","convenience_fee":"2","transaction_limit":"3","image":"https://taskglare.in/new/uploads/media/2023/Group_71752.png"},{"id":"3","name":"Mobile Recharge","convenience_fee":"3","transaction_limit":"3","image":"https://taskglare.in/new/uploads/media/2023/Group_71754.png"},{"id":"4","name":"Water Bill Recharge","convenience_fee":"2","transaction_limit":"4","image":"https://taskglare.in/new/uploads/media/2023/Group_71751.png"},{"id":"5","name":"DTH Bill","convenience_fee":"1","transaction_limit":"2","image":"https://taskglare.in/new/uploads/media/2023/Group_71753.png"},{"id":"6","name":"Electricity Bill","convenience_fee":"3","transaction_limit":"5","image":"https://taskglare.in/new/uploads/media/2023/Group_71750.png"}]

class GetServicesModel {
  GetServicesModel({
      bool? error, 
      String? message, 
      List<Services>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetServicesModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Services.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Services>? _data;
GetServicesModel copyWith({  bool? error,
  String? message,
  List<Services>? data,
}) => GetServicesModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Services>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "2"
/// name : "Gas Bill"
/// convenience_fee : "2"
/// transaction_limit : "3"
/// image : "https://taskglare.in/new/uploads/media/2023/Group_71752.png"

class Services {
  Services({
      String? id, 
      String? name, 
      String? convenienceFee, 
      String? transactionLimit, 
      String? image,}){
    _id = id;
    _name = name;
    _convenienceFee = convenienceFee;
    _transactionLimit = transactionLimit;
    _image = image;
}

  Services.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _convenienceFee = json['convenience_fee'];
    _transactionLimit = json['transaction_limit'];
    _image = json['image'];
  }
  String? _id;
  String? _name;
  String? _convenienceFee;
  String? _transactionLimit;
  String? _image;
Services copyWith({  String? id,
  String? name,
  String? convenienceFee,
  String? transactionLimit,
  String? image,
}) => Services(  id: id ?? _id,
  name: name ?? _name,
  convenienceFee: convenienceFee ?? _convenienceFee,
  transactionLimit: transactionLimit ?? _transactionLimit,
  image: image ?? _image,
);
  String? get id => _id;
  String? get name => _name;
  String? get convenienceFee => _convenienceFee;
  String? get transactionLimit => _transactionLimit;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['convenience_fee'] = _convenienceFee;
    map['transaction_limit'] = _transactionLimit;
    map['image'] = _image;
    return map;
  }

}