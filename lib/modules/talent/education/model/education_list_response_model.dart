class EducationListResponseModel {
  bool? success;
  String? msg;
  List<Data>? data;

  EducationListResponseModel({this.success, this.msg, this.data});

  EducationListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
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
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? description;
  String? thumbnailImage;
  String? videolink;
  int? duration;
  int? eduSubId;
  int? eduFilterId;
  int? eduLevId;
  String? datetime;
  String? date;
  String? time;

  Data(
      {this.id,
        this.title,
        this.description,
        this.thumbnailImage,
        this.videolink,
        this.duration,
        this.eduSubId,
        this.eduFilterId,
        this.eduLevId,
        this.datetime,
        this.date,
        this.time});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    thumbnailImage = json['thumbnailImage'];
    videolink = json['videolink'];
    duration = json['duration'];
    eduSubId = json['eduSubId'];
    eduFilterId = json['eduFilterId'];
    eduLevId = json['eduLevId'];
    datetime = json['datetime'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['thumbnailImage'] = this.thumbnailImage;
    data['videolink'] = this.videolink;
    data['duration'] = this.duration;
    data['eduSubId'] = this.eduSubId;
    data['eduFilterId'] = this.eduFilterId;
    data['eduLevId'] = this.eduLevId;
    data['datetime'] = this.datetime;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}
