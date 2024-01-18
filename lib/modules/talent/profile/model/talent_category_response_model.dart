class TalentCategoryResponseModel {
  bool? success;
  int? statusCode;
  String? msg;
  Data? data;

  TalentCategoryResponseModel(
      {this.success, this.statusCode, this.msg, this.data});

  TalentCategoryResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<LookingForArr>? lookingForArr;

  Data({this.lookingForArr});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['lookingForArr'] != null) {
      lookingForArr = <LookingForArr>[];
      json['lookingForArr'].forEach((v) {
        lookingForArr!.add(new LookingForArr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lookingForArr != null) {
      data['lookingForArr'] =
          this.lookingForArr!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LookingForArr {
  String? option;
  int? id;
  bool? value;

  LookingForArr({this.option, this.id, this.value});

  LookingForArr.fromJson(Map<String, dynamic> json) {
    option = json['option'];
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option'] = this.option;
    data['id'] = this.id;
    data['value'] = this.value;
    return data;
  }
}
