import 'dart:convert';
import 'dart:io';

import 'package:strapi_flutter_cms/GlobalConfig.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getAdminInfo() async {
  try {
    var url = Uri.parse(
        '${GlobalConfig.data.adminURL}/content-manager/admin/information');
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: GlobalConfig.data.token});

    print(response);
    Map<String, dynamic> decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return decoded["data"];
    } else {
      throw decoded;
    }
  } catch (err) {
    throw err;
  }
}

Future<void> logoutUser() async {
  await GlobalConfig.prefs.remove("token");
  await GlobalConfig.prefs.remove("adminURL");
  await GlobalConfig.prefs.remove("user");
  await GlobalConfig.prefs.remove("baseURL");
  await GlobalConfig.prefs.remove("isRememberMe");
  await GlobalConfig.prefs.remove('email');
  await GlobalConfig.prefs.remove('password');
}
