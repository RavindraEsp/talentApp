class SignupSendOtpRequest {
  String? email;
  String? mobileNumber;
  int? userType;
  String? userName;
  String? apiType;

  SignupSendOtpRequest({this.email, this.mobileNumber,this.userType,this.userName,this.apiType});

  SignupSendOtpRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    userType = json['userType'];
    userName = json['userName'];
    apiType = json['apiType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['userType'] = this.userType;
    data['userName'] = this.userName;
    data['apiType'] = this.apiType;
    return data;
  }
}
