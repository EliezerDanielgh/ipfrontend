import 'package:dio/dio.dart';
import 'package:ipfrontend/src/app/utils/apidio.dart';

class OrderProvider extends APIDio {
  static String url = '/checkout/order/';

  Future<List<Map<String, dynamic>>> getOrders(
      Map<String, dynamic> params) async {
    Response resp = await get('$url/', params: params);
    if (resp.statusCode == 200) {
      return List<Map<String, dynamic>>.from(resp.data);
    } else {
      errorHandler(resp);
    }
    return [];
  }
}
