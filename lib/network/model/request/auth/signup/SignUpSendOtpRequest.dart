class SignupSendOtpRequest {
  String? email;
  String? mobileNumber;

  SignupSendOtpRequest({this.email, this.mobileNumber});

  SignupSendOtpRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    mobileNumber = json['mobileNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    return data;
  }
}
