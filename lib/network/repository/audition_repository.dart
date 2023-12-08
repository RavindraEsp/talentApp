import 'dart:convert';

import 'package:talent_app/modules/casting/editAudition/model/adition_details_model.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/screens/model/manage_audition_created_screen_model.dart';
import 'package:talent_app/modules/casting/manageAudition/managefinishedAudition/model/manage_finish_data_response_model.dart';
import 'package:talent_app/network/client/dio_http_service.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/network/model/response/basic_response.dart';
import 'package:talent_app/network/model/response/casterAudition/CasterHomeResponseModel.dart';

import '../model/response/casterAudition/talent_data_response_model.dart';

class AuditionRepository {
  DioHttpService dioHttpService = DioHttpService();

  Future<TalentDataResponseModel> getTalentData(
      {Map<String, dynamic>? queryParameters}) {
    return dioHttpService
        .get(Endpoints.baseUrl + Endpoints.apiEndPoints.getTalentData)
        .then((value) => TalentDataResponseModel.fromJson(value));
  }

  Future<BasicResponse> createAudition(Map<String, dynamic>? request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.createAudition,
            data: jsonEncode(request))
        .then((value) => BasicResponse.fromJson(value));
  }

  Future<CastHomeResponseModel> getHomeDataForCaster() {
    return dioHttpService
        .get(
          Endpoints.baseUrl +
              Endpoints.apiEndPoints.getCreatedFinishedAuditionList,
        )
        .then((value) => CastHomeResponseModel.fromJson(value));
  }

  Future<ManageFinishedAuditionScreenModel> getfinishedAuditionmanage(
      {Map<String, dynamic>? queryParameters}) {
    return dioHttpService
        .get(
            Endpoints.baseUrl +
                Endpoints.apiEndPoints.getfinishedAuditionmanage,
            queryParameters: queryParameters)
        .then((value) => ManageFinishedAuditionScreenModel.fromJson(value));
  }

  Future<ManagAuditionCreatedScreenModel> getcreatedAuditionmanage(
      {Map<String, dynamic>? queryParameters}) {
    return dioHttpService
        .get(
            Endpoints.baseUrl + Endpoints.apiEndPoints.getcreatedAuditionmanage,
            queryParameters: queryParameters)
        .then((value) => ManagAuditionCreatedScreenModel.fromJson(value
            // value11
            ));
  }

  //   Future<ManageFinishedAuditionScreenModel> getAuditionDetailById(
  //     {Map<String, dynamic>? rowPerm}) {
  //   return dioHttpService
  //       .get(
  //           Endpoints.baseUrl +
  //               Endpoints.apiEndPoints.getfinishedAuditionmanage,
  //           queryParameters: queryParameters)
  //       .then((value) => ManageFinishedAuditionScreenModel.fromJson(value));
  // }

  Future<AuditionDetails> getAuditionDetailById(Map<String, dynamic>? request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.getAuditionDetailById,
            data: jsonEncode(request))
        .then((value) => AuditionDetails.fromJson(value22));
  }

  Future<BasicResponse> updateAudition(Map<String, dynamic>? request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.updateAudition,
            data: jsonEncode(request))
        .then((value) => BasicResponse.fromJson(value));
  }
}

var value22 = {
  "success": true,
  "statusCode": 200,
  "msg": "Get Audition details!",
  "data": {
    "email": "aman6.espsofttech@gmail.com",
    "datetime": "2023-10-04T09:41:32.000Z",
    "lookingFor": [
      {"id": 1, "name": "model", "isSelected": 1},
      {"id": 2, "name": "actor", "isSelected": 1},
      {"id": 3, "name": "Network Star", "isSelected": 0},
      {"id": 4, "name": "Singer", "isSelected": 0}
    ],
    "EyeColor": [
      {"id": 1, "name": "Brown", "isSelected": "0"},
      {"id": 2, "name": "Blue", "isSelected": "0"}
    ],
    "HairColor": [
      {"id": 3, "name": "Brown", "isSelected": "1"},
      {"id": 4, "name": "Blue", "isSelected": "0"}
    ],
    "PantSize": [
      {"id": 5, "name": "xs", "isSelected": "0"},
      {"id": 6, "name": "s", "isSelected": "0"}
    ],
    "ShirtSize": [
      {"id": 7, "name": "xs", "isSelected": "0"},
      {"id": 8, "name": "s", "isSelected": "0"}
    ],
    "ShoeSize": [
      {"id": 9, "name": "36", "isSelected": "0"},
      {"id": 10, "name": "37", "isSelected": "0"}
    ],
    "auditionDates": [
      {"date": "10-04-2023", "spot": 2, "time": "07:14:52"}
    ],
    "id": 3,
    "description": "Hello first autdition update",
    "workExperience": 1,
    "candidateRepresentation": 1,
    "ageRangeMin": 10,
    "ageRangeMax": 40,
    "weightRangeMin": 20,
    "weightRangeMax": 50,
    "professionalTraining": 0,
    "heightRangeMin": 10,
    "heightRangeMax": 20,
    "location": "indore",
    "totalView": 1,
    "totalApply": 0
  }
};


// var value11 = {
//   "success": true,
//   "statusCode": 200,
//   "msg": "Get Audition created details!",
//   "data": {
//     "id": "19",
//     "description": "Hello  caster hemant first audition",
//     "datetime": "2023-12-01T11:22:01.000Z",
//     "viewCount": 2,
//     "appliedCount": 3,
//     "appliedUsers": [
//       {
//         "id": 2,
//         "talentUserId": 13,
//         "casterUserId": 25,
//         "auditionId": 19,
//         "status": 0,
//         "viewapplystatus": 0,
//         "datetime": "2023-12-06T07:05:49.000Z",
//         "username": "Gagan Shukla",
//         "talentProfileId": 2,
//         "Height": "5.5",
//         "Weight": "23",
//         "profilePic": "image-1700900344657.png",
//         "Gender": "Male",
//         "Address": "indore",
//         "Age": "22",
//         "lookingFor": ["model"],
//         "bodyList": [
//           "EyeColor:Blue",
//           "HairColor:Brown",
//           "PantSize:xs",
//           "ShirtSize:xs",
//           "ShoeSize:36"
//         ],
//         "profileFiles": [
//           {"filename": "image-1697019296967.jpg", "type": "image"},
//           {"filename": "image-1697019296973.jpg", "type": "audio"},
//           {"filename": "image-1697019296979.mp4", "type": "video"}
//         ],
//         "intro_text":
//             "Hi, my name is Model and I am a model. I have worked with Bollywood and was featured in fashion designer."
//       },
//       {
//         "id": 4,
//         "talentUserId": 10,
//         "casterUserId": 25,
//         "auditionId": 19,
//         "status": 0,
//         "viewapplystatus": 1,
//         "datetime": "2023-12-07T07:05:49.000Z",
//         "username": "aman3 Shukla3",
//         "talentProfileId": 5,
//         "Height": "4",
//         "Weight": "20",
//         "profilePic": null,
//         "Gender": "Male",
//         "Address": "indored",
//         "Age": "24",
//         "lookingFor": ["model"],
//         "bodyList": [
//           "EyeColor:null",
//           "HairColor:Brown",
//           "PantSize:null",
//           "ShirtSize:null",
//           "ShoeSize:null"
//         ],
//         "profileFiles": [],
//         "intro_text":
//             "Hi, my name is Model and I am a model. I have worked with Bollywood and was featured in fashion designer."
//       }
//     ],
//     "approvedUsers": [
//       {
//         "id": 3,
//         "talentUserId": 8,
//         "casterUserId": 13,
//         "auditionId": 19,
//         "status": 1,
//         "viewapplystatus": 0,
//         "datetime": "2023-12-07T07:05:49.000Z",
//         "username": "Gagan1 Shukla1",
//         "talentProfileId": 3,
//         "Height": "3",
//         "Weight": "2",
//         "profilePic": "image-1701089383581.jpg",
//         "Gender": "Male",
//         "Address": "indore",
//         "Age": "22"
//       },
//       {
//         "id": 5,
//         "talentUserId": 11,
//         "casterUserId": 25,
//         "auditionId": 19,
//         "status": 1,
//         "viewapplystatus": 1,
//         "datetime": "2023-12-07T07:05:49.000Z",
//         "username": "aman4 Shukla4",
//         "talentProfileId": 4,
//         "Height": "3",
//         "Weight": "2",
//         "profilePic": null,
//         "Gender": "Male",
//         "Address": "indored",
//         "Age": "23"
//       },
//       {
//         "id": 6,
//         "talentUserId": 12,
//         "casterUserId": 25,
//         "auditionId": 19,
//         "status": 1,
//         "viewapplystatus": 1,
//         "datetime": "2023-12-07T07:05:49.000Z",
//         "username": "aman5 Shukla2",
//         "talentProfileId": 7,
//         "Height": "2",
//         "Weight": "25",
//         "profilePic": null,
//         "Gender": "Male",
//         "Address": "indored",
//         "Age": "23"
//       }
//     ]
//   }
// };
