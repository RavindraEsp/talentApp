class WebContentResponseModel {
  bool? success;
  String? message;
  Data? data;

  WebContentResponseModel({this.success, this.message, this.data});

  WebContentResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? aboutus;
  String? privacypolicy;
  String? termscondition;

  Data({this.id, this.aboutus, this.privacypolicy, this.termscondition});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aboutus = json['aboutus'];
    privacypolicy = json['privacypolicy'];
    termscondition = json['termscondition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['aboutus'] = this.aboutus;
    data['privacypolicy'] = this.privacypolicy;
    data['termscondition'] = this.termscondition;
    return data;
  }
}
