import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<dynamic> getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<dynamic> postData(Map<String, dynamic> data) async {
    http.Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode ==201) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      throw Exception('Failed to post data');
    }
  }
}
