class TalantUserProfileModel {
  bool? success;
  int? statusCode;
  String? msg;
  List<Data>? data;

  TalantUserProfileModel({this.success, this.statusCode, this.msg, this.data});

  TalantUserProfileModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  int? gender;
  String? phone;
  String? email;
  String? address;
  String? dateofbirth;
  String? about;
  String? height;
  String? weight;
  int? experience;
  int? participated;
  String? instalink;
  String? facebooklink;
  String? youtubelink;
  String? tiktoklink;
  List<Files>? imageFiles;
  List<Files>? audioFiles;
  List<Files>? videoFiles;
  String? name;
  String? firstName;
  String? lastName;
  var govtId;
  String? age;
  List<String>? lookingFor;
  List<String>? bodyList;

  Data(
      {this.id,
      this.userId,
      this.gender,
      this.phone,
      this.email,
      this.address,
      this.dateofbirth,
      this.about,
      this.height,
      this.weight,
      this.experience,
      this.participated,
      this.instalink,
      this.facebooklink,
      this.youtubelink,
      this.tiktoklink,
      this.imageFiles,
      this.audioFiles,
      this.videoFiles,
      this.name,
      this.firstName,
      this.lastName,
      this.govtId,
      this.age,
      this.lookingFor,
      this.bodyList});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    gender = json['Gender'];
    phone = json['Phone'];
    email = json['Email'];
    address = json['Address'];
    dateofbirth = json['Dateofbirth'];
    about = json['About'];
    height = json['Height'];
    weight = json['Weight'];
    experience = json['experience'];
    participated = json['participated'];
    instalink = json['instalink'];
    facebooklink = json['facebooklink'];
    youtubelink = json['youtubelink'];
    tiktoklink = json['tiktoklink'];
    if (json['imageFiles'] != null) {
      imageFiles = <Files>[];
      json['imageFiles'].forEach((v) {
        imageFiles!.add(new Files.fromJson(v));
      });
    }
    if (json['audioFiles'] != null) {
      audioFiles = <Files>[];
      json['audioFiles'].forEach((v) {
        audioFiles!.add(new Files.fromJson(v));
      });
    }
    if (json['videoFiles'] != null) {
      videoFiles = <Files>[];
      json['videoFiles'].forEach((v) {
        videoFiles!.add(new Files.fromJson(v));
      });
    }
    name = json['name'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    govtId = json['GovtId'];
    age = json['Age'];
    lookingFor = json['lookingFor'].cast<String>();
    bodyList = json['bodyList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['Gender'] = this.gender;
    data['Phone'] = this.phone;
    data['Email'] = this.email;
    data['Address'] = this.address;
    data['Dateofbirth'] = this.dateofbirth;
    data['About'] = this.about;
    data['Height'] = this.height;
    data['Weight'] = this.weight;
    data['experience'] = this.experience;
    data['participated'] = this.participated;
    data['instalink'] = this.instalink;
    data['facebooklink'] = this.facebooklink;
    data['youtubelink'] = this.youtubelink;
    data['tiktoklink'] = this.tiktoklink;
    if (this.imageFiles != null) {
      data['imageFiles'] = this.imageFiles!.map((v) => v.toJson()).toList();
    }
    if (this.audioFiles != null) {
      data['audioFiles'] = this.audioFiles!.map((v) => v.toJson()).toList();
    }
    if (this.videoFiles != null) {
      data['videoFiles'] = this.videoFiles!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['GovtId'] = this.govtId;
    data['Age'] = this.age;
    data['lookingFor'] = this.lookingFor;
    data['bodyList'] = this.bodyList;
    return data;
  }
}

class Files {
  String? files;

  Files({this.files});

  Files.fromJson(Map<String, dynamic> json) {
    files = json['files'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['files'] = this.files;
    return data;
  }
}
