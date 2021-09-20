import 'dart:convert';
import 'dart:io';
import 'package:strapi_flutter_cms/GlobalConfig.dart';
import 'package:http/http.dart' as http;
import 'package:strapi_flutter_cms/models/role.dart';

Future<List<Role>> fetchRoles() async {
  try {
    var url =
        Uri.parse('${GlobalConfig.data.adminURL}/users-permissions/roles');
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: GlobalConfig.data.token});
    var decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var parsedBody = decoded["roles"];
      var responseToSend = List.generate(
          parsedBody.length, (index) => Role.fromMap(parsedBody[index]));
      return responseToSend;
    } else {
      print("failed fetch content");
      throw decoded;
    }
  } catch (err) {
    throw err;
  }
}
