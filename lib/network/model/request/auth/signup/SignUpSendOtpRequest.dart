class SignupSendOtpRequest {
  String? email;
  String? mobileNumber;
  int? userType;

  SignupSendOtpRequest({this.email, this.mobileNumber,this.userType});

  SignupSendOtpRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['userType'] = this.userType;
    return data;
  }
}
