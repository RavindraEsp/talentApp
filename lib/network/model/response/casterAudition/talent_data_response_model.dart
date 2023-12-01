class TalentDataResponseModel {
  bool? success;
  String? message;
  Data? data;

  TalentDataResponseModel({this.success, this.message, this.data});

  TalentDataResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<EyeColor>? eyeColor;
  List<EyeColor>? hairColor;
  List<EyeColor>? pantSize;
  List<EyeColor>? shirtSize;
  List<EyeColor>? shoeSize;
  List<LookingFor>? lookingFor;

  Data(
      {this.eyeColor,
        this.hairColor,
        this.pantSize,
        this.shirtSize,
        this.shoeSize,
        this.lookingFor});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['EyeColor'] != null) {
      eyeColor = <EyeColor>[];
      json['EyeColor'].forEach((v) {
        eyeColor!.add(new EyeColor.fromJson(v));
      });
    }
    if (json['HairColor'] != null) {
      hairColor = <EyeColor>[];
      json['HairColor'].forEach((v) {
        hairColor!.add(new EyeColor.fromJson(v));
      });
    }
    if (json['PantSize'] != null) {
      pantSize = <EyeColor>[];
      json['PantSize'].forEach((v) {
        pantSize!.add(new EyeColor.fromJson(v));
      });
    }
    if (json['ShirtSize'] != null) {
      shirtSize = <EyeColor>[];
      json['ShirtSize'].forEach((v) {
        shirtSize!.add(new EyeColor.fromJson(v));
      });
    }
    if (json['ShoeSize'] != null) {
      shoeSize = <EyeColor>[];
      json['ShoeSize'].forEach((v) {
        shoeSize!.add(new EyeColor.fromJson(v));
      });
    }
    if (json['lookingFor'] != null) {
      lookingFor = <LookingFor>[];
      json['lookingFor'].forEach((v) {
        lookingFor!.add(new LookingFor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    if (this.lookingFor != null) {
      data['lookingFor'] = this.lookingFor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EyeColor {
  int? id;
  int? talentId;
  String? name;
  String? datetime;
  String? talentName;
  bool isSelect = false;

  EyeColor({this.id, this.talentId, this.name, this.datetime, this.talentName,required this.isSelect});

  EyeColor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    talentId = json['talentId'];
    name = json['name'];
    datetime = json['datetime'];
    talentName = json['talentName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['talentId'] = this.talentId;
    data['name'] = this.name;
    data['datetime'] = this.datetime;
    data['talentName'] = this.talentName;
    return data;
  }
}

class LookingFor {
  String? name;
  int? id;
  bool isSelect = false;

  LookingFor({this.name, this.id,required this.isSelect});

  LookingFor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
