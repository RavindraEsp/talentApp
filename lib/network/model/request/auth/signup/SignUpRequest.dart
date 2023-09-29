class SignupRequest {
  String? userName;
  String? email;
  String? mobileNumber;
  String? password;
  String? confirmPassword;
  String? oTP;
  int? talentType;

  SignupRequest(
      {this.userName,
        this.email,
        this.mobileNumber,
        this.password,
        this.confirmPassword,
        this.oTP,
        this.talentType});

  SignupRequest.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    oTP = json['OTP'];
    talentType = json['talentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    data['OTP'] = this.oTP;
    data['talentType'] = this.talentType;
    return data;
  }
}
