import 'package:talent_app/network/client/dio_http_service.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/network/model/response/audition/talent_data_response_model.dart';

class AuditionRepository {
  DioHttpService dioHttpService = DioHttpService();

  Future<TalentDataResponseModel> getTalentData({Map<String, dynamic>? queryParameters}) {
    return dioHttpService
        .get(Endpoints.baseUrl + Endpoints.apiEndPoints.getTalentData)
        .then((value) => TalentDataResponseModel.fromJson(value));
  }


}
