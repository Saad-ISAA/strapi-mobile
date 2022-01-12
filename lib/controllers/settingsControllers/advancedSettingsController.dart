import 'dart:convert';
import 'dart:io';

import 'package:strapi_flutter_cms/models/advanced_settings.dart';

import 'package:strapi_flutter_cms/GlobalConfig.dart';
import 'package:strapi_flutter_cms/models/locale.dart';
import 'package:http/http.dart' as http;

Future<AdvancedSettings> fetchAdvancedSettings() async {
  try {
    var url =
        Uri.parse('${GlobalConfig.data.adminURL}/users-permissions/advanced');
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: GlobalConfig.data.token});
    var decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var responseToSend = AdvancedSettings.fromMap(decoded);
      return responseToSend;
    } else {
      print("failed fetch content");
      throw decoded;
    }
  } catch (err) {
    throw err;
  }
}
