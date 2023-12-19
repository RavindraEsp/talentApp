import 'dart:convert';
import 'package:talent_app/modules/casting/editAudition/model/adition_details_model.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/model/manage_audition_created_screen_model.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/model/telent_user_profile_model.dart';
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

  Future<AuditionDetails> getAuditionDetailById(Map<String, dynamic>? request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.getAuditionDetailById,
            data: jsonEncode(request))
        .then((value) => AuditionDetails.fromJson(value));
  }

  Future<BasicResponse> updateAudition(Map<String, dynamic>? request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.updateAudition,
            data: jsonEncode(request))
        .then((value) => BasicResponse.fromJson(value));
  }

  Future<Map<String, dynamic>> cancelAudition(Map<String, dynamic>? request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.cancelAudition,
            data: jsonEncode(request))
        .then((value) => value);
  }

  Future<TalantUserProfileModel> getTalentProfile(
      {Map<String, dynamic>? queryParameters}) {
    return dioHttpService
        .get(Endpoints.baseUrl + Endpoints.apiEndPoints.getTalentProfile,
            queryParameters: queryParameters)
        .then((value) => TalantUserProfileModel.fromJson(value));
  }
}
