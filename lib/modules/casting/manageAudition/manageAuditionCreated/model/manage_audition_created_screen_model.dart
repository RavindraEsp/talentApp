// class ManagAuditionCreatedScreenModel {
//   bool? success;
//   int? statusCode;
//   String? msg;
//   Data? data;
//
//   ManagAuditionCreatedScreenModel(
//       {this.success, this.statusCode, this.msg, this.data});
//
//   ManagAuditionCreatedScreenModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     statusCode = json['statusCode'];
//     msg = json['msg'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['statusCode'] = this.statusCode;
//     data['msg'] = this.msg;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? id;
//   String? description;
//   String? datetime;
//   int? viewCount;
//   int? appliedCount;
//   List<AppliedUsers>? appliedUsers;
//   List<ApprovedUsers>? approvedUsers;
//
//   Data(
//       {this.id,
//       this.description,
//       this.datetime,
//       this.viewCount,
//       this.appliedCount,
//       this.appliedUsers,
//       this.approvedUsers});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     description = json['description'];
//     datetime = json['datetime'];
//     viewCount = json['viewCount'];
//     appliedCount = json['appliedCount'];
//     if (json['appliedUsers'] != null) {
//       appliedUsers = <AppliedUsers>[];
//       json['appliedUsers'].forEach((v) {
//         appliedUsers!.add(new AppliedUsers.fromJson(v));
//       });
//     }
//     if (json['approvedUsers'] != null) {
//       approvedUsers = <ApprovedUsers>[];
//       json['approvedUsers'].forEach((v) {
//         approvedUsers!.add(new ApprovedUsers.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['description'] = this.description;
//     data['datetime'] = this.datetime;
//     data['viewCount'] = this.viewCount;
//     data['appliedCount'] = this.appliedCount;
//     if (this.appliedUsers != null) {
//       data['appliedUsers'] = this.appliedUsers!.map((v) => v.toJson()).toList();
//     }
//     if (this.approvedUsers != null) {
//       data['approvedUsers'] =
//           this.approvedUsers!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class AppliedUsers {
//   int? id;
//   int? talentUserId;
//   int? casterUserId;
//   int? auditionId;
//   int? status;
//   int? viewapplystatus;
//   String? username;
//   int? talentProfileId;
//   String? height;
//   String? weight;
//   String? profilePic;
//   String? gender;
//   String? address;
//   String? age;
//   List<String>? lookingFor;
//   List<String>? bodyList;
//   List<ProfileFiles>? profileFiles;
//   String? introText;
//
//   AppliedUsers(
//       {this.id,
//       this.talentUserId,
//       this.casterUserId,
//       this.auditionId,
//       this.status,
//       this.viewapplystatus,
//       this.username,
//       this.talentProfileId,
//       this.height,
//       this.weight,
//       this.profilePic,
//       this.gender,
//       this.address,
//       this.age,
//       this.lookingFor,
//       this.bodyList,
//       this.profileFiles,
//       this.introText});
//
//   AppliedUsers.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     talentUserId = json['talentUserId'];
//     casterUserId = json['casterUserId'];
//     auditionId = json['auditionId'];
//     status = json['status'];
//     viewapplystatus = json['viewapplystatus'];
//     username = json['username'];
//     talentProfileId = json['talentProfileId'];
//     height = json['Height'];
//     weight = json['Weight'];
//     profilePic = json['profilePic'];
//     gender = json['Gender'];
//     address = json['Address'];
//     age = json['Age'];
//     lookingFor = json['lookingFor'].cast<String>();
//     bodyList = json['bodyList'].cast<String>();
//     if (json['profileFiles'] != null) {
//       profileFiles = <ProfileFiles>[];
//       json['profileFiles'].forEach((v) {
//         profileFiles!.add(new ProfileFiles.fromJson(v));
//       });
//     }
//     introText = json['intro_text'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['talentUserId'] = this.talentUserId;
//     data['casterUserId'] = this.casterUserId;
//     data['auditionId'] = this.auditionId;
//     data['status'] = this.status;
//     data['viewapplystatus'] = this.viewapplystatus;
//     data['username'] = this.username;
//     data['talentProfileId'] = this.talentProfileId;
//     data['Height'] = this.height;
//     data['Weight'] = this.weight;
//     data['profilePic'] = this.profilePic;
//     data['Gender'] = this.gender;
//     data['Address'] = this.address;
//     data['Age'] = this.age;
//     data['lookingFor'] = this.lookingFor;
//     data['bodyList'] = this.bodyList;
//     if (this.profileFiles != null) {
//       data['profileFiles'] = this.profileFiles!.map((v) => v.toJson()).toList();
//     }
//     data['intro_text'] = this.introText;
//     return data;
//   }
// }
//
// class ProfileFiles {
//   String? filename;
//   String? type;
//
//   ProfileFiles({this.filename, this.type});
//
//   ProfileFiles.fromJson(Map<String, dynamic> json) {
//     filename = json['filename'];
//     type = json['type'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['filename'] = this.filename;
//     data['type'] = this.type;
//     return data;
//   }
// }
//
// class ApprovedUsers {
//   int? id;
//   int? talentUserId;
//   int? casterUserId;
//   int? auditionId;
//   int? status;
//   int? viewapplystatus;
//   String? username;
//   int? talentProfileId;
//   String? height;
//   String? weight;
//   String? profilePic;
//   String? gender;
//   String? address;
//   String? age;
//
//   ApprovedUsers(
//       {this.id,
//       this.talentUserId,
//       this.casterUserId,
//       this.auditionId,
//       this.status,
//       this.viewapplystatus,
//       this.username,
//       this.talentProfileId,
//       this.height,
//       this.weight,
//       this.profilePic,
//       this.gender,
//       this.address,
//       this.age});
//
//   ApprovedUsers.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     talentUserId = json['talentUserId'];
//     casterUserId = json['casterUserId'];
//     auditionId = json['auditionId'];
//     status = json['status'];
//     viewapplystatus = json['viewapplystatus'];
//     username = json['username'];
//     talentProfileId = json['talentProfileId'];
//     height = json['Height'];
//     weight = json['Weight'];
//     profilePic = json['profilePic'];
//     gender = json['Gender'];
//     address = json['Address'];
//     age = json['Age'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['talentUserId'] = this.talentUserId;
//     data['casterUserId'] = this.casterUserId;
//     data['auditionId'] = this.auditionId;
//     data['status'] = this.status;
//     data['viewapplystatus'] = this.viewapplystatus;
//     data['username'] = this.username;
//     data['talentProfileId'] = this.talentProfileId;
//     data['Height'] = this.height;
//     data['Weight'] = this.weight;
//     data['profilePic'] = this.profilePic;
//     data['Gender'] = this.gender;
//     data['Address'] = this.address;
//     data['Age'] = this.age;
//     return data;
//   }
// }


class ManagAuditionCreatedScreenModel {
  bool? success;
  int? statusCode;
  String? msg;
  Data? data;

  ManagAuditionCreatedScreenModel(
      {this.success, this.statusCode, this.msg, this.data});

  ManagAuditionCreatedScreenModel.fromJson(Map<String, dynamic> json) {
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
  int? viewCount;
  int? appliedCount;
  List<AppliedUsers>? appliedUsers;
  List<ApprovedUsers>? approvedUsers;

  Data(
      {this.id,
        this.description,
        this.datetime,
        this.viewCount,
        this.appliedCount,
        this.appliedUsers,
        this.approvedUsers});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    datetime = json['datetime'];
    viewCount = json['viewCount'];
    appliedCount = json['appliedCount'];
    if (json['appliedUsers'] != null) {
      appliedUsers = <AppliedUsers>[];
      json['appliedUsers'].forEach((v) {
        appliedUsers!.add(new AppliedUsers.fromJson(v));
      });
    }
    if (json['approvedUsers'] != null) {
      approvedUsers = <ApprovedUsers>[];
      json['approvedUsers'].forEach((v) {
        approvedUsers!.add(new ApprovedUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['datetime'] = this.datetime;
    data['viewCount'] = this.viewCount;
    data['appliedCount'] = this.appliedCount;
    if (this.appliedUsers != null) {
      data['appliedUsers'] = this.appliedUsers!.map((v) => v.toJson()).toList();
    }
    if (this.approvedUsers != null) {
      data['approvedUsers'] =
          this.approvedUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppliedUsers {
  int? id;
  int? talentUserId;
  int? casterUserId;
  int? auditionId;
  int? auditionDateId;
  int? status;
  int? viewapplystatus;
  String? datetime;
  String? username;
  List<Images>? images;
  int? talentProfileId;
  String? about;
  String? height;
  String? weight;
  dynamic? profilePic;
  int? gender;
  String? address;
  String? age;
  int? appliedId;
  List<String>? lookingFor;
  List<String>? bodyList;
  List<ProfileFiles>? profileFiles;
  String? introText;

  AppliedUsers(
      {this.id,
        this.talentUserId,
        this.casterUserId,
        this.auditionId,
        this.auditionDateId,
        this.status,
        this.viewapplystatus,
        this.datetime,
        this.username,
        this.images,
        this.talentProfileId,
        this.about,
        this.height,
        this.weight,
        this.profilePic,
        this.gender,
        this.address,
        this.age,
        this.appliedId,
        this.lookingFor,
        this.bodyList,
        this.profileFiles,
        this.introText});

  AppliedUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    talentUserId = json['talentUserId'];
    casterUserId = json['casterUserId'];
    auditionId = json['auditionId'];
    auditionDateId = json['auditionDateId'];
    status = json['status'];
    viewapplystatus = json['viewapplystatus'];
    datetime = json['datetime'];
    username = json['username'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    talentProfileId = json['talentProfileId'];
    about = json['about'];
    height = json['Height'];
    weight = json['Weight'];
    profilePic = json['profilePic'];
    gender = json['Gender'];
    address = json['Address'];
    age = json['Age'];
    appliedId = json['appliedId'];
    lookingFor = json['lookingFor'].cast<String>();
    bodyList = json['bodyList'].cast<String>();
    if (json['profileFiles'] != null) {
      profileFiles = <ProfileFiles>[];
      json['profileFiles'].forEach((v) {
        profileFiles!.add(new ProfileFiles.fromJson(v));
      });
    }
    introText = json['intro_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['talentUserId'] = this.talentUserId;
    data['casterUserId'] = this.casterUserId;
    data['auditionId'] = this.auditionId;
    data['auditionDateId'] = this.auditionDateId;
    data['status'] = this.status;
    data['viewapplystatus'] = this.viewapplystatus;
    data['datetime'] = this.datetime;
    data['username'] = this.username;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['talentProfileId'] = this.talentProfileId;
    data['about'] = this.about;
    data['Height'] = this.height;
    data['Weight'] = this.weight;
    data['profilePic'] = this.profilePic;
    data['Gender'] = this.gender;
    data['Address'] = this.address;
    data['Age'] = this.age;
    data['appliedId'] = this.appliedId;
    data['lookingFor'] = this.lookingFor;
    data['bodyList'] = this.bodyList;
    if (this.profileFiles != null) {
      data['profileFiles'] = this.profileFiles!.map((v) => v.toJson()).toList();
    }
    data['intro_text'] = this.introText;
    return data;
  }
}

class Images {
  String? files;

  Images({this.files});

  Images.fromJson(Map<String, dynamic> json) {
    files = json['files'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['files'] = this.files;
    return data;
  }
}

class ProfileFiles {
  String? filename;
  String? type;

  ProfileFiles({this.filename, this.type});

  ProfileFiles.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filename'] = this.filename;
    data['type'] = this.type;
    return data;
  }
}

class ApprovedUsers {
  String? date;
  String? time;
  int? spotCount;
  List<UserList>? userList;
  int? appliedCount;

  ApprovedUsers(
      {this.date, this.time, this.spotCount, this.userList, this.appliedCount});

  ApprovedUsers.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    spotCount = json['spotCount'];
    if (json['userList'] != null) {
      userList = <UserList>[];
      json['userList'].forEach((v) {
        userList!.add(new UserList.fromJson(v));
      });
    }
    appliedCount = json['appliedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['time'] = this.time;
    data['spotCount'] = this.spotCount;
    if (this.userList != null) {
      data['userList'] = this.userList!.map((v) => v.toJson()).toList();
    }
    data['appliedCount'] = this.appliedCount;
    return data;
  }
}

class UserList {
  int? id;
  int? talentUserId;
  int? casterUserId;
  int? auditionId;
  int? auditionDateId;
  int? status;
  int? viewapplystatus;
  String? datetime;
  int? totalApplied;
  int? appliedId;
  String? username;
  List<Images>? images;
  int? talentProfileId;
  String? about;
  String? height;
  String? weight;
  String? profilePic;
  int? gender;
  String? address;
  String? age;

  UserList(
      {this.id,
        this.talentUserId,
        this.casterUserId,
        this.auditionId,
        this.auditionDateId,
        this.status,
        this.viewapplystatus,
        this.datetime,
        this.totalApplied,
        this.appliedId,
        this.username,
        this.images,
        this.talentProfileId,
        this.about,
        this.height,
        this.weight,
        this.profilePic,
        this.gender,
        this.address,
        this.age});

  UserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    talentUserId = json['talentUserId'];
    casterUserId = json['casterUserId'];
    auditionId = json['auditionId'];
    auditionDateId = json['auditionDateId'];
    status = json['status'];
    viewapplystatus = json['viewapplystatus'];
    datetime = json['datetime'];
    totalApplied = json['totalApplied'];
    appliedId = json['appliedId'];
    username = json['username'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    talentProfileId = json['talentProfileId'];
    about = json['about'];
    height = json['Height'];
    weight = json['Weight'];
    profilePic = json['profilePic'];
    gender = json['Gender'];
    address = json['Address'];
    age = json['Age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['talentUserId'] = this.talentUserId;
    data['casterUserId'] = this.casterUserId;
    data['auditionId'] = this.auditionId;
    data['auditionDateId'] = this.auditionDateId;
    data['status'] = this.status;
    data['viewapplystatus'] = this.viewapplystatus;
    data['datetime'] = this.datetime;
    data['totalApplied'] = this.totalApplied;
    data['appliedId'] = this.appliedId;
    data['username'] = this.username;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['talentProfileId'] = this.talentProfileId;
    data['about'] = this.about;
    data['Height'] = this.height;
    data['Weight'] = this.weight;
    data['profilePic'] = this.profilePic;
    data['Gender'] = this.gender;
    data['Address'] = this.address;
    data['Age'] = this.age;
    return data;
  }
}



