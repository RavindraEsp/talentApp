class BasicResponse {
  bool? success;
  int? statusCode;
  String? msg;

  BasicResponse({this.success, this.statusCode, this.msg});

  BasicResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    data['msg'] = this.msg;
    return data;
  }
}
