class SignupSendOtpResponse {
  bool? success;
  int? statusCode;
  String? msg;
  int? data;

  SignupSendOtpResponse({this.success, this.statusCode, this.msg, this.data});

  SignupSendOtpResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    msg = json['msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    data['msg'] = this.msg;
    data['data'] = this.data;
    return data;
  }
}
