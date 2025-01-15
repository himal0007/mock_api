import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  ApiServices._();
  static Future<bool> makeApiCall(
      {required String endpoint,
      required String method,
      required Map<String, dynamic> headers,
      required Map<String, dynamic>? requestBody,
      required Map<String, dynamic> responseBody}) async {
    final url =
        Uri.parse("https://paranoid007.pythonanywhere.com/generate_api");

    // Define the request payload
    final Map<String, dynamic> requestBody = {
      "endpoint": endpoint,
      "method": method,
      "headers": headers,
      "response_body": responseBody
    };

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(requestBody),
      );

      // Check the response status
      if (response.statusCode == 200) {
        print("API call successful: ${response.body}");
        return true;
      } else {
        print("Failed with status code: ${response.statusCode}");
        print("Error: ${response.body}");
        return false;
      }
    } catch (e) {
      print("An error occurred: $e");
      return false;
    }
  }
}
