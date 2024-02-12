import 'package:talent_app/modules/talent/education/model/education_list_response_model.dart';
import 'package:talent_app/modules/talent/education/model/fliter_list_response_model.dart';
import 'package:talent_app/network/client/dio_http_service.dart';
import 'package:talent_app/network/end_points.dart';

class EducationRepository {
  DioHttpService dioHttpService = DioHttpService();

  Future<EducationListResponseModel> getEducationList({required  Map<String, dynamic> request}) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.getEducationContent,data: request)
        .then((value) => EducationListResponseModel.fromJson(value));
  }

  Future<FilterListResponseModel> filterList() {
    return dioHttpService
        .get(Endpoints.baseUrl + Endpoints.apiEndPoints.getEducationFilters)
        .then((value) => FilterListResponseModel.fromJson(value));
  }






}
