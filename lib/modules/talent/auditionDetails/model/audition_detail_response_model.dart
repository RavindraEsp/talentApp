class AuditionDetailResponseModel {
  bool? success;
  int? statusCode;
  String? msg;
  Data? data;

  AuditionDetailResponseModel(
      {this.success, this.statusCode, this.msg, this.data});

  AuditionDetailResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<GetAuditionDateArr>? getAuditionDateArr;
  int? applyId;
  int? applyStatus;
  int? id;
  int? auditionId;
  int? casterUserId;
  String? description;
  String? location;
  String? latitude;
  String? longitude;
  String? castername;
  String? casterProfile;
  String? companyName;
  String? casterLogo;

  Data(
      {this.getAuditionDateArr,
        this.applyId,
        this.applyStatus,
        this.id,
        this.auditionId,
        this.casterUserId,
        this.description,
        this.location,
        this.latitude,
        this.longitude,
        this.castername,
        this.casterProfile,
        this.companyName,
        this.casterLogo});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['getAuditionDateArr'] != null) {
      getAuditionDateArr = <GetAuditionDateArr>[];
      json['getAuditionDateArr'].forEach((v) {
        getAuditionDateArr!.add(new GetAuditionDateArr.fromJson(v));
      });
    }
    applyId = json['applyId'];
    applyStatus = json['applyStatus'];
    id = json['id'];
    auditionId = json['auditionId'];
    casterUserId = json['casterUserId'];
    description = json['description'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    castername = json['castername'];
    casterProfile = json['casterProfile'];
    companyName = json['companyName'];
    casterLogo = json['casterLogo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getAuditionDateArr != null) {
      data['getAuditionDateArr'] =
          this.getAuditionDateArr!.map((v) => v.toJson()).toList();
    }
    data['applyId'] = this.applyId;
    data['applyStatus'] = this.applyStatus;
    data['id'] = this.id;
    data['auditionId'] = this.auditionId;
    data['casterUserId'] = this.casterUserId;
    data['description'] = this.description;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['castername'] = this.castername;
    data['casterProfile'] = this.casterProfile;
    data['companyName'] = this.companyName;
    data['casterLogo'] = this.casterLogo;
    return data;
  }
}

class GetAuditionDateArr {
  int? id;
  String? date;
  int? spot;
  String? time;
  bool? isSelected;

  GetAuditionDateArr(
      {this.id, this.date, this.spot, this.time, this.isSelected});

  GetAuditionDateArr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    spot = json['spot'];
    time = json['time'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['spot'] = this.spot;
    data['time'] = this.time;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
