class NotificationResponseModel {
  bool? success;
  int? statusCode;
  String? msg;
  List<Data>? data;

  NotificationResponseModel(
      {this.success, this.statusCode, this.msg, this.data});

  NotificationResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? fromUserId;
  int? auditionId;
  String? message;
  String? datetime;

  Data(
      {this.id, this.fromUserId, this.auditionId, this.message, this.datetime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromUserId = json['fromUserId'];
    auditionId = json['auditionId'];
    message = json['message'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fromUserId'] = this.fromUserId;
    data['auditionId'] = this.auditionId;
    data['message'] = this.message;
    data['datetime'] = this.datetime;
    return data;
  }
}
