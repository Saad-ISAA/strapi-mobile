import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:strapi_flutter_cms/GlobalConfig.dart';
import 'dart:convert';

import 'package:strapi_flutter_cms/models/content_type.dart';

Future<List<ContentType>> fetchContentTypes() async {
  try {
    var url = Uri.parse(
        '${GlobalConfig.data.adminURL}/content-manager/content-types');
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: GlobalConfig.data.token});
    var decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var parsedBody = decoded["data"];
      var responseToSend = List.generate(
          parsedBody.length, (index) => ContentType.fromMap(parsedBody[index]));
      return responseToSend;
    } else {
      print("failed fetch content");
      throw decoded;
    }
  } catch (err) {
    throw err;
  }
}

Future<List<dynamic>> fetchCollectionType(String uid) async {
  try {
    var url = Uri.parse(
        '${GlobalConfig.data.adminURL}/content-manager/collection-types/$uid');
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: GlobalConfig.data.token});
    Map<String, dynamic> decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<dynamic> parsedBody = decoded["results"];
      return parsedBody;
    } else {
      throw decoded;
    }
  } catch (err) {
    throw err;
  }
}
