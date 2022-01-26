
import 'dart:convert';
import 'dart:io';

import 'package:strapi_flutter_cms/GlobalConfig.dart';
import 'package:http/http.dart' as http;
import 'package:strapi_flutter_cms/models/apiToken.dart';

Future<List<ApiToken>> fetchApiTokens() async {
  try {
    var url =
        Uri.parse('${GlobalConfig.data.adminURL}/admin/api-tokens');
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: GlobalConfig.data.token});
    var decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return List.generate(decoded['data'].length, (index) => ApiToken.fromMap(decoded['data'][index]));
    } else {
      throw decoded;
    }
  } catch (err) {
    throw err;
  }
}

Future<ApiToken> fetchApiTokenDetails(int id) async {
  try {
    var url =
        Uri.parse('${GlobalConfig.data.adminURL}/admin/api-tokens/$id');
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: GlobalConfig.data.token});
    var decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return ApiToken.fromMap(decoded['data']);
    } else {
      throw decoded;
    }
  } catch (err) {
    throw err;
  }
}