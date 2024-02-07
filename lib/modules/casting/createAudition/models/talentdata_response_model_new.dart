
class TalentDataResponseModelNew {
  bool? success;
  int? statusCode;
  String? msg;
  Data? data;

  TalentDataResponseModelNew(
      {this.success, this.statusCode, this.msg, this.data});

  TalentDataResponseModelNew.fromJson(Map<String, dynamic> json) {
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
  List<BodyDetail>? bodyDetail;
  List<LookingFor>? lookingFor;

  Data({this.bodyDetail, this.lookingFor});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['bodyDetail'] != null) {
      bodyDetail = <BodyDetail>[];
      json['bodyDetail'].forEach((v) {
        bodyDetail!.add(new BodyDetail.fromJson(v));
      });
    }
    if (json['lookingFor'] != null) {
      lookingFor = <LookingFor>[];
      json['lookingFor'].forEach((v) {
        lookingFor!.add(new LookingFor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bodyDetail != null) {
      data['bodyDetail'] = this.bodyDetail!.map((v) => v.toJson()).toList();
    }
    if (this.lookingFor != null) {
      data['lookingFor'] = this.lookingFor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BodyDetail {
  String? name;
  List<BodyData>? bodyData;
  BodyData? selectDropDown;

  BodyDetail({this.name, this.bodyData,this.selectDropDown});

  BodyDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['bodyData'] != null) {
      bodyData = <BodyData>[];
      json['bodyData'].forEach((v) {
        bodyData!.add(new BodyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.bodyData != null) {
      data['bodyData'] = this.bodyData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BodyData {
  int? id;
  int? talentId;
  String? name;
  String? datetime;
  String? talentName;
  bool isSelect = false;


  BodyData({this.id, this.talentId, this.name, this.datetime, this.talentName,
    required this.isSelect});

  BodyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    talentId = json['talentId'];
    name = json['name'];
    datetime = json['datetime'];
    talentName = json['talentName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['talentId'] = this.talentId;
    data['name'] = this.name;
    data['datetime'] = this.datetime;
    data['talentName'] = this.talentName;
    return data;
  }
}

class LookingFor {
  int? id;
  String? name;
  int? status;
  String? datetime;
  bool isSelect = false;

  LookingFor({this.id, this.name, this.status, this.datetime,required this.isSelect});

  LookingFor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['datetime'] = this.datetime;
    return data;
  }
}


