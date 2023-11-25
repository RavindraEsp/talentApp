import 'package:talent_app/network/client/dio_http_service.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/network/model/response/menu/web_content_response_model.dart';

class MenuRepository {
  DioHttpService dioHttpService = DioHttpService();

  Future<WebContentResponseModel> getWebContent() {
    return dioHttpService
        .get(Endpoints.baseUrl + Endpoints.auth.getWebContent)
        .then((value) => WebContentResponseModel.fromJson(value));
  }
}
