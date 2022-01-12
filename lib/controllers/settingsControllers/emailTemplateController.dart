import 'dart:convert';
import 'dart:io';

import 'package:strapi_flutter_cms/GlobalConfig.dart';
import 'package:http/http.dart' as http;
import 'package:strapi_flutter_cms/models/email_template.dart';

Future<List<EmailTemplate>> fetchEmailTemplateSettings() async {
  try {
    var url = Uri.parse(
        '${GlobalConfig.data.adminURL}/users-permissions/email-templates');
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: GlobalConfig.data.token});
    var decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<EmailTemplate> emailTemplates = [];
      decoded.forEach((key, value) {
        emailTemplates.add(EmailTemplate.fromMap(value));
      });
      return emailTemplates;
    } else {
      print("failed fetch content");
      throw decoded;
    }
  } catch (err) {
    throw err;
  }
}
