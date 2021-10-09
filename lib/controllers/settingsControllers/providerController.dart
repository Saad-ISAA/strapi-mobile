import 'dart:convert';
import 'dart:io';

import 'package:strapi_flutter_cms/GlobalConfig.dart';
import 'package:strapi_flutter_cms/models/provider.dart';
import 'package:http/http.dart' as http;

Future<List<Map<String, ProviderDetail>>> fetchProviders() async {
  try {
    var url =
        Uri.parse('${GlobalConfig.data.adminURL}/users-permissions/providers');
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: GlobalConfig.data.token});
    Map decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<Map<String, ProviderDetail>> providers = [];
      decoded.forEach((key, value) {
        providers.add({key: ProviderDetail.fromMap(value)});
      });
      // var responseToSend = Provider.fromMap(decoded);
      return providers;
    } else {
      print("failed fetch content");
      throw decoded;
    }
  } catch (err) {
    throw err;
  }
}
