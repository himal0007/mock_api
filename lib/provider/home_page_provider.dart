import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mock_api/api/api_services.dart';

class HomePageProvider extends ChangeNotifier {
  final headers = [
    'GET',
    'POST',
    'PUT',
    'DELETE',
  ];
  String? _dropdownvalue;
  String get dropdownvalue => _dropdownvalue ?? 'GET';
  setDropDownValue(String value) {
    _dropdownvalue = value;
    notifyListeners();
  }

  TextEditingController endpointController = TextEditingController();
  TextEditingController headerController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController responseController = TextEditingController();

  bool? _isHeaderVisible;
  bool get isHeaderVisible => _isHeaderVisible ?? true;
  bool? _isRequestVisible;
  bool get isRequestVisible => _isRequestVisible ?? false;
  bool? _isResponseVisible;
  bool get isResponseVisible => _isResponseVisible ?? false;
  setIsFieldVisible(
      bool isHeaderVisible, bool isRequestVisible, bool isResponseVisible) {
    _isHeaderVisible = isHeaderVisible;
    _isRequestVisible = isRequestVisible;
    _isResponseVisible = isResponseVisible;
    notifyListeners();
  }

  validateAndConvertJson(String inputText) {
    if (inputText.isEmpty) {
      return {"Content-Type": "application/json"};
    }
    try {
      // Attempt to decode the JSON string
      final data = json.decode(inputText);

      // Check if the decoded value is a Map
      if (data is Map<String, dynamic>) {
        return data;
      } else {
        return {"Content-Type": "application/json"};
      }
    } catch (e) {
      // Handle invalid JSON format
      return {"Content-Type": "application/json"};
    }
  }

  validateInput() {
    final endpoint = endpointController.text;
    final header = validateAndConvertJson(headerController.text);
    final body = bodyController.text;
    final method = dropdownvalue;
    final response = responseController.text;
    final requestBody = validateAndConvertJson(body);
    final responseBody = validateAndConvertJson(response);
    if (method == "POST" && requestBody == null) {
      return false;
    }

    if (endpoint.isNotEmpty && responseBody != null) {
      return (
        endpoint: endpoint,
        header: header,
        body: requestBody,
        method: method,
        responseBody: responseBody
      );
    } else {
      return false;
    }
  }

  Future<bool> makeApiCall(
      {required String endpoint,
      required String method,
      required Map<String, dynamic> headers,
      required Map<String, dynamic> responseBody,
      required Map<String, dynamic>? requestBody}) async {
    final response = await ApiServices.makeApiCall(
        endpoint: "/$endpoint",
        method: method,
        headers: headers,
        requestBody: requestBody,
        responseBody: responseBody);
    return response;
  }

  String code = "";
  String response = "";
  bool showCode = false;

  /// Create Code
  createCode(
      {required String endpoint,
      required String method,
      required Map<String, dynamic> headers,
      required Map<String, dynamic> responseBody,
      required Map<String, dynamic>? requestBody}) {
    final url = Uri.parse("https://paranoid007.pythonanywhere.com/$endpoint");
    code = """
try {
      final response = await http.$method(
        $url,
        headers: $headers,
       ${requestBody == null || requestBody.isEmpty ? "" : "body: json.encode($requestBody),"} 
      );
      // Check the response status
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }

""";
    response = """
$responseBody
""";
    showCode = true;
    notifyListeners();
  }
}
