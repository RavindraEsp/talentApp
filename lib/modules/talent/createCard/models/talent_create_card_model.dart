import 'package:image_picker/image_picker.dart';

class TalentCreateCardModel {
  int? userId;
  String? firstName;
  String? lastName;
  String? gender;
  String? email;
  String? address;
  String? dateofbirth;
  String? about;
  String? height;
  String? weight;
  String? experience;
  String? participated;
  List<int>? profileTalentdata;
  List<int>? careerModel;
  String? instalink;
  String? facebooklink;
  String? youtubelink;
  String? tiktoklink;
  String? govtId;

  TalentCreateCardModel(
      {this.userId,
        this.firstName,
        this.lastName,
        this.gender,
        this.email,
        this.address,
        this.dateofbirth,
        this.about,
        this.height,
        this.weight,
        this.experience,
        this.participated,
        this.profileTalentdata,
        this.careerModel,
        this.instalink,
        this.facebooklink,
        this.youtubelink,
        this.tiktoklink,
        this.govtId
      });

  TalentCreateCardModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    gender = json['Gender'];
    email = json['Email'];
    address = json['Address'];
    dateofbirth = json['Dateofbirth'];
    about = json['About'];
    height = json['Height'];
    weight = json['Weight'];
    experience = json['experience'];
    participated = json['participated'];
    profileTalentdata = json['profileTalentdata'].cast<String>();
    careerModel = json['careerModel'].cast<String>();
    instalink = json['instalink'];
    facebooklink = json['facebooklink'];
    youtubelink = json['youtubelink'];
    tiktoklink = json['tiktoklink'];
    govtId = json['GovtId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['Gender'] = this.gender;
    data['Email'] = this.email;
    data['Address'] = this.address;
    data['Dateofbirth'] = this.dateofbirth;
    data['About'] = this.about;
    data['Height'] = this.height;
    data['Weight'] = this.weight;
    data['experience'] = this.experience;
    data['participated'] = this.participated;
    data['profileTalentdata'] = this.profileTalentdata;
    data['careerModel'] = this.careerModel;
    data['instalink'] = this.instalink;
    data['facebooklink'] = this.facebooklink;
    data['youtubelink'] = this.youtubelink;
    data['tiktoklink'] = this.tiktoklink;
    data['GovtId'] = this.govtId;
    return data;
  }
}
