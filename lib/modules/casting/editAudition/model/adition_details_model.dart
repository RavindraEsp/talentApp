class AuditionDetails {
  bool? success;
  int? statusCode;
  String? msg;
  Data? data;

  AuditionDetails({this.success, this.statusCode, this.msg, this.data});

  AuditionDetails.fromJson(Map<String, dynamic> json) {
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
  String? datetime;
  List<LookingFor>? lookingFor;
  List<NameSelectedAttrButeModel>? eyeColor;
  List<NameSelectedAttrButeModel>? hairColor;
  List<NameSelectedAttrButeModel>? pantSize;
  List<NameSelectedAttrButeModel>? shirtSize;
  List<NameSelectedAttrButeModel>? shoeSize;
  List<AuditionDates>? auditionDates;
  int? id;
  String? description;
  int? workExperience;
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

  Data(
      {this.email,
      this.datetime,
      this.lookingFor,
      this.eyeColor,
      this.hairColor,
      this.pantSize,
      this.shirtSize,
      this.shoeSize,
      this.auditionDates,
      this.id,
      this.description,
      this.workExperience,
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
      this.totalApply});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    datetime = json['datetime'];
    if (json['lookingFor'] != null) {
      lookingFor = <LookingFor>[];
      json['lookingFor'].forEach((v) {
        lookingFor!.add(new LookingFor.fromJson(v));
      });
    }
    if (json['EyeColor'] != null) {
      eyeColor = <NameSelectedAttrButeModel>[];
      json['EyeColor'].forEach((v) {
        eyeColor!.add(new NameSelectedAttrButeModel.fromJson(v));
      });
    }
    if (json['HairColor'] != null) {
      hairColor = <NameSelectedAttrButeModel>[];
      json['HairColor'].forEach((v) {
        hairColor!.add(new NameSelectedAttrButeModel.fromJson(v));
      });
    }
    if (json['PantSize'] != null) {
      pantSize = <NameSelectedAttrButeModel>[];
      json['PantSize'].forEach((v) {
        pantSize!.add(new NameSelectedAttrButeModel.fromJson(v));
      });
    }
    if (json['ShirtSize'] != null) {
      shirtSize = <NameSelectedAttrButeModel>[];
      json['ShirtSize'].forEach((v) {
        shirtSize!.add(new NameSelectedAttrButeModel.fromJson(v));
      });
    }
    if (json['ShoeSize'] != null) {
      shoeSize = <NameSelectedAttrButeModel>[];
      json['ShoeSize'].forEach((v) {
        shoeSize!.add(new NameSelectedAttrButeModel.fromJson(v));
      });
    }
    if (json['auditionDates'] != null) {
      auditionDates = <AuditionDates>[];
      json['auditionDates'].forEach((v) {
        auditionDates!.add(new AuditionDates.fromJson(v));
      });
    }
    id = json['id'];
    description = json['description'];
    workExperience = json['workExperience'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['datetime'] = this.datetime;
    if (this.lookingFor != null) {
      data['lookingFor'] = this.lookingFor!.map((v) => v.toJson()).toList();
    }
    if (this.eyeColor != null) {
      data['EyeColor'] = this.eyeColor!.map((v) => v.toJson()).toList();
    }
    if (this.hairColor != null) {
      data['HairColor'] = this.hairColor!.map((v) => v.toJson()).toList();
    }
    if (this.pantSize != null) {
      data['PantSize'] = this.pantSize!.map((v) => v.toJson()).toList();
    }
    if (this.shirtSize != null) {
      data['ShirtSize'] = this.shirtSize!.map((v) => v.toJson()).toList();
    }
    if (this.shoeSize != null) {
      data['ShoeSize'] = this.shoeSize!.map((v) => v.toJson()).toList();
    }
    if (this.auditionDates != null) {
      data['auditionDates'] =
          this.auditionDates!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['description'] = this.description;
    data['workExperience'] = this.workExperience;
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

class NameSelectedAttrButeModel {
  int? id;
  String? name;
  String? isSelected;

  NameSelectedAttrButeModel({this.id, this.name, this.isSelected});

  NameSelectedAttrButeModel.fromJson(Map<String, dynamic> json) {
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
  String? date;
  int? spot;
  String? time;

  AuditionDates({this.date, this.spot, this.time});

  AuditionDates.fromJson(Map<String, dynamic> json) {
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



// class AuditionDetails {
//   bool? success;
//   int? statusCode;
//   String? msg;
//   Data? data;

//   AuditionDetails({this.success, this.statusCode, this.msg, this.data});

//   AuditionDetails.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     statusCode = json['statusCode'];
//     msg = json['msg'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

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

// class Data {
//   String? email;
//   String? datetime;
//   List<LookingFor>? lookingFor;
//   List<nameSelectedAttrButeModel>? eyeColor;
//   List<nameSelectedAttrButeModel>? hairColor;
//   List<nameSelectedAttrButeModel>? pantSize;
//   List<nameSelectedAttrButeModel>? shirtSize;
//   List<nameSelectedAttrButeModel>? shoeSize;
//   List<AuditionDates>? auditionDates;
//   int? id;
//   String? description;
//   int? workExperience;
//   int? professionalTraining;
//   int? candidateRepresentation;
//   int? ageRangeMin;
//   int? ageRangeMax;
//   int? weightRangeMin;
//   int? weightRangeMax;
//   int? heightRangeMin;
//   int? heightRangeMax;
//   String? location;
//   int? totalView;
//   int? totalApply;

//   Data(
//       {this.email,
//       this.datetime,
//       this.lookingFor,
//       this.eyeColor,
//       this.hairColor,
//       this.pantSize,
//       this.shirtSize,
//       this.shoeSize,
//       this.auditionDates,
//       this.id,
//       this.description,
//       this.workExperience,
//       this.professionalTraining,
//       this.candidateRepresentation,
//       this.ageRangeMin,
//       this.ageRangeMax,
//       this.weightRangeMin,
//       this.weightRangeMax,
//       this.heightRangeMin,
//       this.heightRangeMax,
//       this.location,
//       this.totalView,
//       this.totalApply});

//   Data.fromJson(Map<String, dynamic> json) {
//     email = json['email'];
//     datetime = json['datetime'];
//     if (json['lookingFor'] != null) {
//       lookingFor = <LookingFor>[];
//       json['lookingFor'].forEach((v) {
//         lookingFor!.add(new LookingFor.fromJson(v));
//       });
//     }
//     if (json['EyeColor'] != null) {
//       eyeColor = <nameSelectedAttrButeModel>[];
//       json['EyeColor'].forEach((v) {
//         eyeColor!.add(new nameSelectedAttrButeModel.fromJson(v));
//       });
//     }
//     if (json['HairColor'] != null) {
//       hairColor = <nameSelectedAttrButeModel>[];
//       json['HairColor'].forEach((v) {
//         hairColor!.add(new nameSelectedAttrButeModel.fromJson(v));
//       });
//     }
//     if (json['PantSize'] != null) {
//       pantSize = <nameSelectedAttrButeModel>[];
//       json['PantSize'].forEach((v) {
//         pantSize!.add(new nameSelectedAttrButeModel.fromJson(v));
//       });
//     }
//     if (json['ShirtSize'] != null) {
//       shirtSize = <nameSelectedAttrButeModel>[];
//       json['ShirtSize'].forEach((v) {
//         shirtSize!.add(new nameSelectedAttrButeModel.fromJson(v));
//       });
//     }
//     if (json['ShoeSize'] != null) {
//       shoeSize = <nameSelectedAttrButeModel>[];
//       json['ShoeSize'].forEach((v) {
//         shoeSize!.add(new nameSelectedAttrButeModel.fromJson(v));
//       });
//     }
//     if (json['auditionDates'] != null) {
//       auditionDates = <AuditionDates>[];
//       json['auditionDates'].forEach((v) {
//         auditionDates!.add(new AuditionDates.fromJson(v));
//       });
//     }
//     id = json['id'];
//     description = json['description'];
//     workExperience = json['workExperience'];
//     professionalTraining = json['professionalTraining'];
//     candidateRepresentation = json['candidateRepresentation'];
//     ageRangeMin = json['ageRangeMin'];
//     ageRangeMax = json['ageRangeMax'];
//     weightRangeMin = json['weightRangeMin'];
//     weightRangeMax = json['weightRangeMax'];
//     heightRangeMin = json['heightRangeMin'];
//     heightRangeMax = json['heightRangeMax'];
//     location = json['location'];
//     totalView = json['totalView'];
//     totalApply = json['totalApply'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['email'] = this.email;
//     data['datetime'] = this.datetime;
//     if (this.lookingFor != null) {
//       data['lookingFor'] = this.lookingFor!.map((v) => v.toJson()).toList();
//     }
//     if (this.eyeColor != null) {
//       data['EyeColor'] = this.eyeColor!.map((v) => v.toJson()).toList();
//     }
//     if (this.hairColor != null) {
//       data['HairColor'] = this.hairColor!.map((v) => v.toJson()).toList();
//     }
//     if (this.pantSize != null) {
//       data['PantSize'] = this.pantSize!.map((v) => v.toJson()).toList();
//     }
//     if (this.shirtSize != null) {
//       data['ShirtSize'] = this.shirtSize!.map((v) => v.toJson()).toList();
//     }
//     if (this.shoeSize != null) {
//       data['ShoeSize'] = this.shoeSize!.map((v) => v.toJson()).toList();
//     }
//     if (this.auditionDates != null) {
//       data['auditionDates'] =
//           this.auditionDates!.map((v) => v.toJson()).toList();
//     }
//     data['id'] = this.id;
//     data['description'] = this.description;
//     data['workExperience'] = this.workExperience;
//     data['professionalTraining'] = this.professionalTraining;
//     data['candidateRepresentation'] = this.candidateRepresentation;
//     data['ageRangeMin'] = this.ageRangeMin;
//     data['ageRangeMax'] = this.ageRangeMax;
//     data['weightRangeMin'] = this.weightRangeMin;
//     data['weightRangeMax'] = this.weightRangeMax;
//     data['heightRangeMin'] = this.heightRangeMin;
//     data['heightRangeMax'] = this.heightRangeMax;
//     data['location'] = this.location;
//     data['totalView'] = this.totalView;
//     data['totalApply'] = this.totalApply;
//     return data;
//   }
// }

// class LookingFor {
//   String? name;
//   int? isSelected;

//   LookingFor({this.name, this.isSelected});

//   LookingFor.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     isSelected = json['isSelected'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['isSelected'] = this.isSelected;
//     return data;
//   }
// }

// class nameSelectedAttrButeModel {
//   String? name;
//   String? isSelected;

//   nameSelectedAttrButeModel({this.name, this.isSelected});

//   nameSelectedAttrButeModel.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     isSelected = json['isSelected'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['isSelected'] = this.isSelected;
//     return data;
//   }
// }

// class AuditionDates {
//   String? date;
//   int? spot;
//   String? time;

//   AuditionDates({this.date, this.spot, this.time});

//   AuditionDates.fromJson(Map<String, dynamic> json) {
//     date = json['date'];
//     spot = json['spot'];
//     time = json['time'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['date'] = this.date;
//     data['spot'] = this.spot;
//     data['time'] = this.time;
//     return data;
//   }
// }
