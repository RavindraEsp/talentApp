class LoginRequest {
  String? userName;
  String? password;
  int? userType;
  String? fCMToken;

  LoginRequest({this.userName, this.password,this.userType, this.fCMToken});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    password = json['userType'];
    fCMToken = json['FCM_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['userType'] = this.userType;
    data['FCM_token'] = this.fCMToken;
    return data;
  }
}
