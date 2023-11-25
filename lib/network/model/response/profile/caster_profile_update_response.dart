class CasterProfileUpdateResponse {
  bool? success;
  int? statusCode;
  String? msg;
  Data? data;

  CasterProfileUpdateResponse(
      {this.success, this.statusCode, this.msg, this.data});

  CasterProfileUpdateResponse.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  String? gender;
  String? address;
  String? companyName;
  String? logo;
  String? profilePic;

  Data(
      {this.firstName,
        this.lastName,
        this.gender,
        this.address,
        this.companyName,
        this.logo,
        this.profilePic});

  Data.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    address = json['address'];
    companyName = json['companyName'];
    logo = json['logo'];
    profilePic = json['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['companyName'] = this.companyName;
    data['logo'] = this.logo;
    data['profilePic'] = this.profilePic;
    return data;
  }
}
