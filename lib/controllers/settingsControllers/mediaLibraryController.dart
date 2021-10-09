import 'dart:convert';
import 'dart:io';

import 'package:strapi_flutter_cms/GlobalConfig.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchMediaLibrarySettings() async {
  try {
    var url = Uri.parse('${GlobalConfig.data.adminURL}/upload/settings');
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: GlobalConfig.data.token});
    var decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var parsedBody = decoded["data"];
      return parsedBody;
    } else {
      print("failed fetch content");
      throw decoded;
    }
  } catch (err) {
    throw err;
  }
}
