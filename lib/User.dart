class User {
  int cusId;
  String cusUsername;
  String res;

  User({this.cusId, this.cusUsername, this.res});

  User.fromJson(Map<String, dynamic> json) {
    cusId = json['cus_id'];
    cusUsername = json['cus_username'];
    res = json['res'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cus_id'] = this.cusId;
    data['cus_username'] = this.cusUsername;
    data['res'] = this.res;
    return data;
  }
}