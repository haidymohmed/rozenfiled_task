class LoginCredential {
  int? id;
  String? userName;
  String? password;

  LoginCredential({this.id, this.userName, this.password});

  LoginCredential.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['password'] = password;
    return data;
  }
}