class CastHomeResponseModel {
  bool? success;
  int? statusCode;
  String? msg;
  Data? data;

  CastHomeResponseModel({this.success, this.statusCode, this.msg, this.data});

  CastHomeResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<CreateAudition>? createAudition;
  List<CreateAudition>? finishedAudition;

  Data({this.createAudition, this.finishedAudition});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['createAudition'] != null) {
      createAudition = <CreateAudition>[];
      json['createAudition'].forEach((v) {
        createAudition!.add(new CreateAudition.fromJson(v));
      });
    }
    if (json['finishedAudition'] != null) {
      finishedAudition = <CreateAudition>[];
      json['finishedAudition'].forEach((v) {
        finishedAudition!.add(new CreateAudition.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.createAudition != null) {
      data['createAudition'] =
          this.createAudition!.map((v) => v.toJson()).toList();
    }
    if (this.finishedAudition != null) {
      data['finishedAudition'] =
          this.finishedAudition!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreateAudition {
  int? auditionId;
  String? description;
  int? totalView;
  int? totalApply;
  String? date;

  CreateAudition(
      {this.auditionId,
      this.description,
      this.totalView,
      this.totalApply,
      this.date});

  CreateAudition.fromJson(Map<String, dynamic> json) {
    auditionId = json['auditionId'];
    description = json['description'];
    totalView = json['totalView'];
    totalApply = json['totalApply'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auditionId'] = this.auditionId;
    data['description'] = this.description;
    data['totalView'] = this.totalView;
    data['totalApply'] = this.totalApply;
    data['date'] = this.date;
    return data;
  }
}
