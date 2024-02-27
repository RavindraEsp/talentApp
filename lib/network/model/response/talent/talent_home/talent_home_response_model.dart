class TalentHomeResponseModel {
  bool? success;
  int? statusCode;
  String? msg;
  Data? data;

  TalentHomeResponseModel({this.success, this.statusCode, this.msg, this.data});

  TalentHomeResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<AuditionforyouList>? auditionforyouList;
  List<ApprovedAuditionList>? approvedAuditionList;

  Data({this.auditionforyouList, this.approvedAuditionList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['AuditionforyouList'] != null) {
      auditionforyouList = <AuditionforyouList>[];
      json['AuditionforyouList'].forEach((v) {
        auditionforyouList!.add(new AuditionforyouList.fromJson(v));
      });
    }
    if (json['ApprovedAuditionList'] != null) {
      approvedAuditionList = <ApprovedAuditionList>[];
      json['ApprovedAuditionList'].forEach((v) {
        approvedAuditionList!.add(new ApprovedAuditionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.auditionforyouList != null) {
      data['AuditionforyouList'] =
          this.auditionforyouList!.map((v) => v.toJson()).toList();
    }
    if (this.approvedAuditionList != null) {
      data['ApprovedAuditionList'] =
          this.approvedAuditionList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AuditionforyouList {
  List<GetAuditionDateArr>? getAuditionDateArr;
  int? applyId;
  int? applyStatus;
  int? id;
  int? auditionId;
  String? description;
  String? location;
  String? datetime;
  int? isComplete;
  int? isBoosted;

  AuditionforyouList(
      {this.getAuditionDateArr,
        this.applyId,
        this.applyStatus,
        this.id,
        this.auditionId,
        this.description,
        this.location,
        this.datetime,
        this.isComplete,
        this.isBoosted
      });

  AuditionforyouList.fromJson(Map<String, dynamic> json) {
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
    description = json['description'];
    location = json['location'];
    datetime = json['datetime'];
    isComplete = json['isComplete'];
    isBoosted = json['is_boosted'];
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
    data['description'] = this.description;
    data['location'] = this.location;
    data['datetime'] = this.datetime;
    data['isComplete'] = this.isComplete;
    data['is_boosted'] = this.isBoosted;
    return data;
  }
}

class GetAuditionDateArr {
  int? id;
  String? date;
  int? spot;
  String? time;


  GetAuditionDateArr({this.id, this.date, this.spot, this.time});

  GetAuditionDateArr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    spot = json['spot'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['spot'] = this.spot;
    data['time'] = this.time;
    return data;
  }
}

class ApprovedAuditionList {
  List<GetAuditionDateArr>? getAuditionDateArr;
  int? applyId;
  int? id;
  int? auditionId;
  String? description;

  ApprovedAuditionList(
      {this.getAuditionDateArr,
        this.applyId,
        this.id,
        this.auditionId,
        this.description});

  ApprovedAuditionList.fromJson(Map<String, dynamic> json) {
    if (json['getAuditionDateArr'] != null) {
      getAuditionDateArr = <GetAuditionDateArr>[];
      json['getAuditionDateArr'].forEach((v) {
        getAuditionDateArr!.add(new GetAuditionDateArr.fromJson(v));
      });
    }
    applyId = json['applyId'];
    id = json['id'];
    auditionId = json['auditionId'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getAuditionDateArr != null) {
      data['getAuditionDateArr'] =
          this.getAuditionDateArr!.map((v) => v.toJson()).toList();
    }
    data['applyId'] = this.applyId;
    data['id'] = this.id;
    data['auditionId'] = this.auditionId;
    data['description'] = this.description;
    return data;
  }
}

