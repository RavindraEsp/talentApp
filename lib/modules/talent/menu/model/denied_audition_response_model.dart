class DeniedAuditionResponseModel {
  bool? success;
  int? statusCode;
  String? msg;
  List<Data>? data;

  DeniedAuditionResponseModel(
      {this.success, this.statusCode, this.msg, this.data});

  DeniedAuditionResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  List<GetAuditionDateArr>? getAuditionDateArr;
  int? applyId;
  int? id;
  int? auditionId;
  String? description;

  Data(
      {this.getAuditionDateArr,
        this.applyId,
        this.id,
        this.auditionId,
        this.description});

  Data.fromJson(Map<String, dynamic> json) {
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

class GetAuditionDateArr {
  String? date;
  int? spot;
  String? time;

  GetAuditionDateArr({this.date, this.spot, this.time});

  GetAuditionDateArr.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    spot = json['spot'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['spot'] = this.spot;
    data['time'] = this.time;
    return data;
  }
}
