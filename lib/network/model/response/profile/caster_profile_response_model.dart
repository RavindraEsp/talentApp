class CasterProfileResponseModel {
  bool? success;
  int? statusCode;
  String? msg;
  Data? data;

  CasterProfileResponseModel(
      {this.success, this.statusCode, this.msg, this.data});

  CasterProfileResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  String? logo;
  int? gender;
  String? address;
  String? companyName;
  String? userName;
  String? forgotOtp;
  String? mobileNumber;
  String? email;
  String? profilePic;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.logo,
        this.gender,
        this.address,
        this.companyName,
        this.userName,
        this.forgotOtp,
        this.mobileNumber,
        this.email,
        this.profilePic});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    logo = json['logo'];
    gender = json['gender'];
    address = json['address'];
    companyName = json['companyName'];
    userName = json['userName'];
    forgotOtp = json['forgotOtp'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    profilePic = json['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['logo'] = this.logo;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['companyName'] = this.companyName;
    data['userName'] = this.userName;
    data['forgotOtp'] = this.forgotOtp;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['profilePic'] = this.profilePic;
    return data;
  }
}
