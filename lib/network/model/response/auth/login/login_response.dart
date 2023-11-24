class LoginResponse {
  bool? success;
  int? statusCode;
  String? msg;
  Data? data;

  LoginResponse({this.success, this.statusCode, this.msg, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? userName;
  int? talentType;
  String? mobileNumber;
  String? email;
  String? password;
  String? gender;
  String? profilePic;
  String? jwtToken;
  bool? isCardcreated;

  Data(
      {this.id,
        this.userName,
        this.talentType,
        this.mobileNumber,
        this.email,
        this.password,
        this.gender,
        this.profilePic,
        this.jwtToken,
        this.isCardcreated
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    talentType = json['talentType'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    password = json['password'];
    gender = json['gender'];
    profilePic = json['profilePic'];
    jwtToken = json['jwtToken'];
    isCardcreated = json['isCardcreated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['talentType'] = this.talentType;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['profilePic'] = this.profilePic;
    data['jwtToken'] = this.jwtToken;
    data['isCardcreated'] = this.isCardcreated;
    return data;
  }
}
