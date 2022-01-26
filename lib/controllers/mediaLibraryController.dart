import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:strapi_flutter_cms/models/media_library.dart';
import 'package:strapi_flutter_cms/GlobalConfig.dart';

Future<List<Media>> fetchMediaLibarary() async {
  try {
    var baseURL = GlobalConfig.data.adminURL;
    var url = Uri.parse('$baseURL/upload/files?sort=updatedAt:DESC');
    return await http.get(url, headers: {
      HttpHeaders.authorizationHeader: GlobalConfig.data.token
    }).then((response) {
      var parsedBody = jsonDecode(response.body);
      var responseToSend = List.generate(
          parsedBody['results'].length, (index) => Media.fromMap(parsedBody['results'][index]));
      return responseToSend;
    }).catchError((err) {
      throw err;
    });
  } catch (err) {
    throw err;
  }
}

class ParsedMediaDetails {
  String dimension;
  String extension;
  String size;
  String type;
  ParsedMediaDetails({this.dimension, this.extension, this.size, this.type});
}

ParsedMediaDetails parseMediaDetails(Media item) {
  var dimension = '${item.width}x${item.height}';
  var extension = '${item.ext?.substring(1)?.toUpperCase()}';
  var size = '${item.size}KB';
  var type = '${item.mime?.split("/")[0]?.toUpperCase()}';
  return new ParsedMediaDetails(
      dimension: dimension, extension: extension, size: size, type: type);
}
