// class TalentBodyResponseModelNew {
//   bool? success;
//   int? statusCode;
//   String? msg;
//   Data? data;
//
//   TalentBodyResponseModelNew(
//       {this.success, this.statusCode, this.msg, this.data});
//
//   TalentBodyResponseModelNew.fromJson(Map<String, dynamic> json) {
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
//   List<BodyDetail>? bodyDetail;
//
//   Data({this.bodyDetail});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['bodyDetail'] != null) {
//       bodyDetail = <BodyDetail>[];
//       json['bodyDetail'].forEach((v) {
//         bodyDetail!.add(new BodyDetail.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.bodyDetail != null) {
//       data['bodyDetail'] = this.bodyDetail!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class BodyDetail {
//   String? name;
//   List<BodyData>? bodyData;
//   BodyData? selectDropDown;
//
//   BodyDetail({this.name, this.bodyData,this.selectDropDown});
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
//   String? option;
//   int? id;
//   bool? value;
//
//   BodyData({this.option, this.id, this.value});
//
//   BodyData.fromJson(Map<String, dynamic> json) {
//     option = json['option'];
//     id = json['id'];
//     value = json['value'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['option'] = this.option;
//     data['id'] = this.id;
//     data['value'] = this.value;
//     return data;
//   }
// }


class TalentBodyEditResponseMode {
  bool? success;
  int? statusCode;
  String? msg;
  Data? data;

  TalentBodyEditResponseMode(
      {this.success, this.statusCode, this.msg, this.data});

  TalentBodyEditResponseMode.fromJson(Map<String, dynamic> json) {
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
  List<BodyDetail>? bodyDetail;

  Data({this.bodyDetail});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['bodyDetail'] != null) {
      bodyDetail = <BodyDetail>[];
      json['bodyDetail'].forEach((v) {
        bodyDetail!.add(new BodyDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bodyDetail != null) {
      data['bodyDetail'] = this.bodyDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BodyDetail {
  String? name;
  List<BodyData>? bodyData;
  BodyData? selectDropDown;

  BodyDetail({this.name, this.bodyData,this.selectDropDown});

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
  int? talentId;
  String? name;
  String? groupName;
  bool? value;

  BodyData({this.id, this.talentId, this.name, this.groupName, this.value});

  BodyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    talentId = json['talentId'];
    name = json['name'];
    groupName = json['groupName'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['talentId'] = this.talentId;
    data['name'] = this.name;
    data['groupName'] = this.groupName;
    data['value'] = this.value;
    return data;
  }
}
