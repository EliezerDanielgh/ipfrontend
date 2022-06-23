import 'package:dio/dio.dart';
import 'package:ipfrontend/src/app/utils/apidio.dart';

class ClientProvider extends APIDio {
  static String url = '/core/client';

  Future<List<Map<String, dynamic>>> getClients(
      Map<String, dynamic> params) async {
    Response resp = await get('$url/', params: params);
    if (resp.statusCode == 200) {
      return List<Map<String, dynamic>>.from(resp.data);
    } else {
      errorHandler(resp);
    }
    return [];
  }

  updateClient(String code, Map<String, dynamic> data) async {
    /*
    [{"string": {}}]
    */
    // final response = await patch('$url/$code/', data);
    // return Map<String, dynamic>.from(response.body);
  }
}
