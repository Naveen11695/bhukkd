import 'package:http/http.dart' as http;
// import 'config.json';
import 'dart:convert';
import 'dart:async';

String url = "https://developers.zomato.com/api/v2.1/categories";
void getjsonResponse() async {
  var response = await http
      .get(Uri.encodeFull(url), headers: {"Accept": "application/json", "user-key":"0bc8d74fdefd3601d84a0d52ffa01901"});
  final Map<String, dynamic> convertToJson = json.decode(response.body);
  print(convertToJson);
}

