class FilterListResponseModel {
  bool? success;
  int? statusCode;
  String? msg;
  Data? data;

  FilterListResponseModel({this.success, this.statusCode, this.msg, this.data});

  FilterListResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Subjects>? subjects;
  List<Subjects>? levels;
  List<Subjects>? filterby;

  Data({this.subjects, this.levels, this.filterby});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(new Subjects.fromJson(v));
      });
    }
    if (json['levels'] != null) {
      levels = <Subjects>[];
      json['levels'].forEach((v) {
        levels!.add(new Subjects.fromJson(v));
      });
    }
    if (json['filterby'] != null) {
      filterby = <Subjects>[];
      json['filterby'].forEach((v) {
        filterby!.add(new Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    if (this.levels != null) {
      data['levels'] = this.levels!.map((v) => v.toJson()).toList();
    }
    if (this.filterby != null) {
      data['filterby'] = this.filterby!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  int? id;
  String? name;
  bool isSelect = false;

  Subjects({this.id, this.name,required this.isSelect});

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
