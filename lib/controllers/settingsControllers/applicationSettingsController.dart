import 'dart:convert';
import 'dart:io';

import 'package:strapi_flutter_cms/GlobalConfig.dart';
import 'package:http/http.dart' as http;
import 'package:strapi_flutter_cms/models/admin_information_model.dart';

Future<AdminInformation> fetchApplicationSettings() async {
  try {
    var url = Uri.parse('${GlobalConfig.data.adminURL}/admin/information');
    var response = await http.get(url,
        headers: {
          HttpHeaders.authorizationHeader: GlobalConfig.data.token
          });
    var decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var responseToSend = AdminInformation.fromMap(decoded["data"]);
      return responseToSend;
    } else {
      throw decoded;
    }
  } catch (err) {
    throw err;
  }
}
