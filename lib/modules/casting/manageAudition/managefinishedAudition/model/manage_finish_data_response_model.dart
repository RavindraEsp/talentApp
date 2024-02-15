class ManageFinishedAuditionScreenModel {
  bool? success;
  int? statusCode;
  String? msg;
  Data? data;

  ManageFinishedAuditionScreenModel(
      {this.success, this.statusCode, this.msg, this.data});

  ManageFinishedAuditionScreenModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? description;
  String? datetime;
  List<Candidates>? candidates;

  Data({this.id, this.description, this.datetime, this.candidates});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    datetime = json['datetime'];
    if (json['candidates'] != null) {
      candidates = <Candidates>[];
      json['candidates'].forEach((v) {
        candidates!.add(new Candidates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['datetime'] = this.datetime;
    if (this.candidates != null) {
      data['candidates'] = this.candidates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Candidates {
  int? id;
  int? talentUserId;
  int? casterUserId;
  int? auditionId;
  int? status;
  int? viewapplystatus;
  String? username;
  String? fullname;
  String? height;
  var weight;
  String? profilePic;
  int? gender;
  String? address;
  String? age;
  String? roomId;
  bool? entant;
  bool? accepted;

  Candidates(
      {this.id,
      this.talentUserId,
      this.casterUserId,
      this.auditionId,
      this.status,
      this.viewapplystatus,
      this.username,
      this.fullname,
      this.height,
      this.weight,
      this.profilePic,
      this.gender,
      this.address,
      this.age,
      this.roomId,
      this.entant,
      this.accepted});

  Candidates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    talentUserId = json['talentUserId'];
    casterUserId = json['casterUserId'];
    auditionId = json['auditionId'];
    status = json['status'];
    viewapplystatus = json['viewapplystatus'];
    username = json['username'];
    fullname = json['fullname'];
    height = json['Height'];
    weight = json['Weight'];
    profilePic = json['profilePic'];
    gender = json['Gender'];
    address = json['Address'];
    age = json['Age'];
    roomId = json['roomId'];
    entant = json['entant'];
    accepted = json['accepted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['talentUserId'] = this.talentUserId;
    data['casterUserId'] = this.casterUserId;
    data['auditionId'] = this.auditionId;
    data['status'] = this.status;
    data['viewapplystatus'] = this.viewapplystatus;
    data['username'] = this.username;
    data['fullname'] = this.fullname;
    data['Height'] = this.height;
    data['Weight'] = this.weight;
    data['profilePic'] = this.profilePic;
    data['Gender'] = this.gender;
    data['Address'] = this.address;
    data['Age'] = this.age;
    data['roomId'] = this.roomId;
    data['entant'] = this.entant;
    data['accepted'] = this.accepted;
    return data;
  }
}
