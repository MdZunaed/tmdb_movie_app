import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:movie_app/models/response_data.dart';
import 'package:movie_app/utility/api_key.dart';

class NetworkCaller {
  Future<ResponseData> getRequest(String url) async {
    final Response response = await get(Uri.parse(url),
        headers: {'Content-type': 'application/json', 'Authorization': 'Bearer $apiToken'});
    log(url);
    log(response.statusCode.toString());
    log(response.headers.toString());
    log(response.body.toString());
    if (response.statusCode == 200) {
      return ResponseData(
          isSuccess: true, statusCode: response.statusCode, responseData: jsonDecode(response.body));
    } else {
      return ResponseData(isSuccess: false, statusCode: response.statusCode, responseData: 'ResponseData');
    }
  }

  Future<ResponseData> postRequest(String url, Map<String, dynamic> body) async {
    final Response response = await post(Uri.parse(url),
        headers: {'Content-type': 'application/json', 'Authorization': 'Bearer $apiKey'},
        body: jsonEncode(body));
    log(response.statusCode.toString());
    log(response.headers.toString());
    log(response.body.toString());
    if (response.statusCode == 200) {
      return ResponseData(
          isSuccess: true, statusCode: response.statusCode, responseData: jsonDecode(response.body));
    } else {
      return ResponseData(isSuccess: false, statusCode: response.statusCode, responseData: 'ResponseData');
    }
  }
}
