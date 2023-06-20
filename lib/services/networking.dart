import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

 Future<dynamic> getData({String? token}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = token;
    }

    http.Response response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      throw Exception('Failed to get data');
    }
  }

 Future<dynamic> postData(Map<String, dynamic> data, {String? token}) async {
    try {
      Map<String, String> headers = {'Content-Type': 'application/json'};
      if (token != null) {
        headers['Authorization'] = token;
      }

      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseData = response.body;
        return jsonDecode(responseData);
      } else if (response.statusCode == 500 || response.statusCode == 400 || response.statusCode == 404) {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        String errorMessage = errorResponse['message'];
        print('Server Error: $errorMessage');
        return {'error': errorMessage};
      } else {
        return {'error': 'Failed to post data'};
      }
    } catch (e) {
      String errorMessage = e.toString();
      print('Error: $errorMessage');
      return {'error': errorMessage};
    }
  }
}