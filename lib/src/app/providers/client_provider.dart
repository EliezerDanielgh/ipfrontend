import 'package:ipfrontend/src/app/utils/api.dart';

class ClientProvider extends API {
  static String url = '/core/client';

  Future<List<Map<String, dynamic>>> getClients() async {
    /*
    [{"string": {}}]
    */
    final response = await get('$url/', query: {"not_paginator": true});
    return List<Map<String, dynamic>>.from(response.body);
  }

  updateClient(String code, Map<String, dynamic> data) async {
    /*
    [{"string": {}}]
    */
    final response = await patch('$url/$code/', data);
    return Map<String, dynamic>.from(response.body);
  }
}
