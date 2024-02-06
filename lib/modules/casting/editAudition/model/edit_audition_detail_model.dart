// class EditAuditionDetailModel {
//   bool? success;
//   int? statusCode;
//   String? msg;
//   Data? data;
//
//   EditAuditionDetailModel({this.success, this.statusCode, this.msg, this.data});
//
//   EditAuditionDetailModel.fromJson(Map<String, dynamic> json) {
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
//   String? email;
//   String? description;
//   String? datetime;
//   List<LookingFor>? lookingFor;
//   List<BodyDetail>? bodyDetail;
//   List<AuditionDates>? auditionDates;
//   int? id;
//   int? workExperience;
//   String? latitude;
//   String? longitude;
//   int? candidateRepresentation;
//   int? ageRangeMin;
//   int? ageRangeMax;
//   int? weightRangeMin;
//   int? weightRangeMax;
//   int? professionalTraining;
//   int? heightRangeMin;
//   int? heightRangeMax;
//   String? location;
//   int? totalView;
//   int? totalApply;
//
//   Data(
//       {this.email,
//         this.description,
//         this.datetime,
//         this.lookingFor,
//         this.bodyDetail,
//         this.auditionDates,
//         this.id,
//         this.workExperience,
//         this.latitude,
//         this.longitude,
//         this.candidateRepresentation,
//         this.ageRangeMin,
//         this.ageRangeMax,
//         this.weightRangeMin,
//         this.weightRangeMax,
//         this.professionalTraining,
//         this.heightRangeMin,
//         this.heightRangeMax,
//         this.location,
//         this.totalView,
//         this.totalApply});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     email = json['email'];
//     description = json['description'];
//     datetime = json['datetime'];
//     if (json['lookingFor'] != null) {
//       lookingFor = <LookingFor>[];
//       json['lookingFor'].forEach((v) {
//         lookingFor!.add(new LookingFor.fromJson(v));
//       });
//     }
//     if (json['bodyDetail'] != null) {
//       bodyDetail = <BodyDetail>[];
//       json['bodyDetail'].forEach((v) {
//         bodyDetail!.add(new BodyDetail.fromJson(v));
//       });
//     }
//     if (json['auditionDates'] != null) {
//       auditionDates = <AuditionDates>[];
//       json['auditionDates'].forEach((v) {
//         auditionDates!.add(new AuditionDates.fromJson(v));
//       });
//     }
//     id = json['id'];
//     workExperience = json['workExperience'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     candidateRepresentation = json['candidateRepresentation'];
//     ageRangeMin = json['ageRangeMin'];
//     ageRangeMax = json['ageRangeMax'];
//     weightRangeMin = json['weightRangeMin'];
//     weightRangeMax = json['weightRangeMax'];
//     professionalTraining = json['professionalTraining'];
//     heightRangeMin = json['heightRangeMin'];
//     heightRangeMax = json['heightRangeMax'];
//     location = json['location'];
//     totalView = json['totalView'];
//     totalApply = json['totalApply'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['email'] = this.email;
//     data['description'] = this.description;
//     data['datetime'] = this.datetime;
//     if (this.lookingFor != null) {
//       data['lookingFor'] = this.lookingFor!.map((v) => v.toJson()).toList();
//     }
//     if (this.bodyDetail != null) {
//       data['bodyDetail'] = this.bodyDetail!.map((v) => v.toJson()).toList();
//     }
//     if (this.auditionDates != null) {
//       data['auditionDates'] =
//           this.auditionDates!.map((v) => v.toJson()).toList();
//     }
//     data['id'] = this.id;
//     data['workExperience'] = this.workExperience;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['candidateRepresentation'] = this.candidateRepresentation;
//     data['ageRangeMin'] = this.ageRangeMin;
//     data['ageRangeMax'] = this.ageRangeMax;
//     data['weightRangeMin'] = this.weightRangeMin;
//     data['weightRangeMax'] = this.weightRangeMax;
//     data['professionalTraining'] = this.professionalTraining;
//     data['heightRangeMin'] = this.heightRangeMin;
//     data['heightRangeMax'] = this.heightRangeMax;
//     data['location'] = this.location;
//     data['totalView'] = this.totalView;
//     data['totalApply'] = this.totalApply;
//     return data;
//   }
// }
//
// class LookingFor {
//   int? id;
//   String? name;
//   int? isSelected;
//
//   LookingFor({this.id, this.name, this.isSelected});
//
//   LookingFor.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     isSelected = json['isSelected'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['isSelected'] = this.isSelected;
//     return data;
//   }
// }
//
// class BodyDetail {
//   String? name;
//   List<BodyData>? bodyData;
//
//   BodyDetail({this.name, this.bodyData});
//
//   BodyDetail.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     if (json['bodyData'] != null) {
//       bodyData = <BodyData>[];
//       json['bodyData'].forEach((v) {
//         bodyData!.add(new BodyData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     if (this.bodyData != null) {
//       data['bodyData'] = this.bodyData!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class BodyData {
//   int? id;
//   String? name;
//   String? isSelected;
//
//   BodyData({this.id, this.name, this.isSelected});
//
//   BodyData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     isSelected = json['isSelected'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['isSelected'] = this.isSelected;
//     return data;
//   }
// }
//
// class AuditionDates {
//   int? id;
//   String? date;
//   int? spot;
//   String? time;
//
//   AuditionDates({this.id, this.date, this.spot, this.time});
//
//   AuditionDates.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     date = json['date'];
//     spot = json['spot'];
//     time = json['time'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['date'] = this.date;
//     data['spot'] = this.spot;
//     data['time'] = this.time;
//     return data;
//   }
// }


class EditAuditionDetailModel {
  bool? success;
  int? statusCode;
  String? msg;
  Data? data;

  EditAuditionDetailModel({this.success, this.statusCode, this.msg, this.data});

  EditAuditionDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? email;
  String? description;
  String? datetime;
  List<LookingFor>? lookingFor;
  List<AuditionDates>? auditionDates;
  int? id;
  int? workExperience;
  String? latitude;
  String? longitude;
  int? candidateRepresentation;
  int? ageRangeMin;
  int? ageRangeMax;
  int? weightRangeMin;
  int? weightRangeMax;
  int? professionalTraining;
  int? heightRangeMin;
  int? heightRangeMax;
  String? location;
  int? totalView;
  int? totalApply;
  List<BodyDetail>? bodyDetail;

  Data(
      {this.email,
        this.description,
        this.datetime,
        this.lookingFor,
        this.auditionDates,
        this.id,
        this.workExperience,
        this.latitude,
        this.longitude,
        this.candidateRepresentation,
        this.ageRangeMin,
        this.ageRangeMax,
        this.weightRangeMin,
        this.weightRangeMax,
        this.professionalTraining,
        this.heightRangeMin,
        this.heightRangeMax,
        this.location,
        this.totalView,
        this.totalApply,
        this.bodyDetail});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    description = json['description'];
    datetime = json['datetime'];
    if (json['lookingFor'] != null) {
      lookingFor = <LookingFor>[];
      json['lookingFor'].forEach((v) {
        lookingFor!.add(new LookingFor.fromJson(v));
      });
    }
    if (json['auditionDates'] != null) {
      auditionDates = <AuditionDates>[];
      json['auditionDates'].forEach((v) {
        auditionDates!.add(new AuditionDates.fromJson(v));
      });
    }
    id = json['id'];
    workExperience = json['workExperience'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    candidateRepresentation = json['candidateRepresentation'];
    ageRangeMin = json['ageRangeMin'];
    ageRangeMax = json['ageRangeMax'];
    weightRangeMin = json['weightRangeMin'];
    weightRangeMax = json['weightRangeMax'];
    professionalTraining = json['professionalTraining'];
    heightRangeMin = json['heightRangeMin'];
    heightRangeMax = json['heightRangeMax'];
    location = json['location'];
    totalView = json['totalView'];
    totalApply = json['totalApply'];
    if (json['bodyDetail'] != null) {
      bodyDetail = <BodyDetail>[];
      json['bodyDetail'].forEach((v) {
        bodyDetail!.add(new BodyDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['description'] = this.description;
    data['datetime'] = this.datetime;
    if (this.lookingFor != null) {
      data['lookingFor'] = this.lookingFor!.map((v) => v.toJson()).toList();
    }
    if (this.auditionDates != null) {
      data['auditionDates'] =
          this.auditionDates!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['workExperience'] = this.workExperience;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['candidateRepresentation'] = this.candidateRepresentation;
    data['ageRangeMin'] = this.ageRangeMin;
    data['ageRangeMax'] = this.ageRangeMax;
    data['weightRangeMin'] = this.weightRangeMin;
    data['weightRangeMax'] = this.weightRangeMax;
    data['professionalTraining'] = this.professionalTraining;
    data['heightRangeMin'] = this.heightRangeMin;
    data['heightRangeMax'] = this.heightRangeMax;
    data['location'] = this.location;
    data['totalView'] = this.totalView;
    data['totalApply'] = this.totalApply;
    if (this.bodyDetail != null) {
      data['bodyDetail'] = this.bodyDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LookingFor {
  int? id;
  String? name;
  int? isSelected;

  LookingFor({this.id, this.name, this.isSelected});

  LookingFor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isSelected'] = this.isSelected;
    return data;
  }
}

class AuditionDates {
  int? id;
  String? date;
  int? spot;
  String? time;

  AuditionDates({this.id, this.date, this.spot, this.time});

  AuditionDates.fromJson(Map<String, dynamic> json) {
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

class BodyDetail {
  String? name;
  List<BodyData>? bodyData;

  BodyDetail({this.name, this.bodyData});

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
  String? name;
  String? isSelected;

  BodyData({this.id, this.name, this.isSelected});

  BodyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
