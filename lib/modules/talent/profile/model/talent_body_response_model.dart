class TalentBodyResponseModel {
  bool? success;
  int? statusCode;
  String? msg;
  Data? data;

  TalentBodyResponseModel({this.success, this.statusCode, this.msg, this.data});

  TalentBodyResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<EyeColorArr>? eyeColorArr;
  List<EyeColorArr>? hairColorArr;
  List<EyeColorArr>? shirtSizeArr;
  List<EyeColorArr>? pantSizeArr;
  List<EyeColorArr>? shoeSizeArr;

  Data(
      {this.eyeColorArr,
        this.hairColorArr,
        this.shirtSizeArr,
        this.pantSizeArr,
        this.shoeSizeArr});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['eyeColorArr'] != null) {
      eyeColorArr = <EyeColorArr>[];
      json['eyeColorArr'].forEach((v) {
        eyeColorArr!.add(new EyeColorArr.fromJson(v));
      });
    }
    if (json['hairColorArr'] != null) {
      hairColorArr = <EyeColorArr>[];
      json['hairColorArr'].forEach((v) {
        hairColorArr!.add(new EyeColorArr.fromJson(v));
      });
    }
    if (json['shirtSizeArr'] != null) {
      shirtSizeArr = <EyeColorArr>[];
      json['shirtSizeArr'].forEach((v) {
        shirtSizeArr!.add(new EyeColorArr.fromJson(v));
      });
    }
    if (json['pantSizeArr'] != null) {
      pantSizeArr = <EyeColorArr>[];
      json['pantSizeArr'].forEach((v) {
        pantSizeArr!.add(new EyeColorArr.fromJson(v));
      });
    }
    if (json['shoeSizeArr'] != null) {
      shoeSizeArr = <EyeColorArr>[];
      json['shoeSizeArr'].forEach((v) {
        shoeSizeArr!.add(new EyeColorArr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eyeColorArr != null) {
      data['eyeColorArr'] = this.eyeColorArr!.map((v) => v.toJson()).toList();
    }
    if (this.hairColorArr != null) {
      data['hairColorArr'] = this.hairColorArr!.map((v) => v.toJson()).toList();
    }
    if (this.shirtSizeArr != null) {
      data['shirtSizeArr'] = this.shirtSizeArr!.map((v) => v.toJson()).toList();
    }
    if (this.pantSizeArr != null) {
      data['pantSizeArr'] = this.pantSizeArr!.map((v) => v.toJson()).toList();
    }
    if (this.shoeSizeArr != null) {
      data['shoeSizeArr'] = this.shoeSizeArr!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EyeColorArr {
  String? option;
  bool? value;
  int? id;

  EyeColorArr({this.option, this.value});

  EyeColorArr.fromJson(Map<String, dynamic> json) {
    option = json['option'];
    value = json['value'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option'] = this.option;
    data['value'] = this.value;
    data['id'] = this.id;
    return data;
  }
}
