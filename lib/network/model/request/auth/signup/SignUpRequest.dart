class SignupRequest {
  String? userName;
  String? email;
  String? mobileNumber;
  String? countryCode;
  String? countryISOCode;
  String? password;
  String? confirmPassword;
  String? oTP;
  int? userType;

  SignupRequest(
      {this.userName,
        this.email,
        this.mobileNumber,
        this.countryCode,
        this.countryISOCode,
        this.password,
        this.confirmPassword,
        this.oTP,
        this.userType});

  SignupRequest.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    countryCode = json['countryCode'];
    countryISOCode = json['countryISOCode'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    oTP = json['OTP'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['countryCode'] = this.countryCode;
    data['countryISOCode'] = this.countryISOCode;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    data['OTP'] = this.oTP;
    data['userType'] = this.userType;
    return data;
  }
}
