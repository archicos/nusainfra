import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiService extends GetxService {
  final String baseUrl = 'https://msib-6-test-7uaujedvyq-et.a.run.app/api';

  Future<http.Response> postData(String endpoint, Map<String, dynamic> data,
      {String? token}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
    print('POST $url');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response;
  }


  Future<http.Response> getData(String endpoint,
      {String? token, Map<String, dynamic>? queryParams}) async {
    final url =
        Uri.parse('$baseUrl/$endpoint').replace(queryParameters: queryParams);
    return await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> putData(String endpoint, Map<String, dynamic> data,
      {required String token}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode(data);
    final response = await http.put(url, headers: headers, body: body);
    return response;
  }

  Future<http.Response> deleteData(String endpoint,
      {required String token}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.delete(url, headers: headers);
    return response;
  }
}
