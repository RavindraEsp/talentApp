import 'dart:convert';
import 'package:talent_app/modules/casting/createAudition/models/talentdata_response_model_new.dart';
import 'package:talent_app/modules/casting/editAudition/model/adition_details_model.dart';
import 'package:talent_app/modules/casting/editAudition/model/edit_audition_detail_model.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/model/manage_audition_created_screen_model.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/model/telent_user_profile_model.dart';
import 'package:talent_app/modules/casting/manageAudition/managefinishedAudition/model/manage_finish_data_response_model.dart';
import 'package:talent_app/modules/talent/auditionDetails/model/audition_detail_response_model.dart';
import 'package:talent_app/modules/talent/menu/model/denied_audition_response_model.dart';
import 'package:talent_app/network/client/dio_http_service.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/network/model/response/basic_response.dart';
import 'package:talent_app/network/model/response/casterAudition/CasterHomeResponseModel.dart';
import 'package:talent_app/network/model/response/talent/talent_home/boost_plan_response_model.dart';
import 'package:talent_app/network/model/response/talent/talent_home/talent_home_response_model.dart';
import '../model/response/casterAudition/talent_data_response_model.dart';

class BoostRepository {
  DioHttpService dioHttpService = DioHttpService();

  Future<BoostPlanResponseModel> getBoostPlan(
      {Map<String, dynamic>? queryParameters}) {
    return dioHttpService
        .get(Endpoints.baseUrl + Endpoints.apiEndPoints.getBoostPlanData)
        .then((value) => BoostPlanResponseModel.fromJson(value));
  }

  Future<BasicResponse> purchasePlan(
      {Map? request}) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.purchaseBoostPlan,data: request)
        .then((value) => BasicResponse.fromJson(value));
  }
  Future<BasicResponse> boostProfile(
      {Map? request}) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.boostProfile,data: request)
        .then((value) => BasicResponse.fromJson(value));
  }




}
