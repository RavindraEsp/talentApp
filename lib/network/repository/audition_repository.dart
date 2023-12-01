import 'dart:convert';

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
        .get(Endpoints.baseUrl + Endpoints.apiEndPoints.getCreatedFinishedAuditionList,)
        .then((value) => CastHomeResponseModel.fromJson(value));
  }
}
