class LoginRequest {
  String? userName;
  String? password;
  String? fCMToken;

  LoginRequest({this.userName, this.password, this.fCMToken});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    fCMToken = json['FCM_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['FCM_token'] = this.fCMToken;
    return data;
  }
}
