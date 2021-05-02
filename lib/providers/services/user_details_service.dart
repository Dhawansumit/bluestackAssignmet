import 'dart:convert';

import 'package:bluestackassignment/model/login_config_response.dart';
import 'package:bluestackassignment/utils/constants/string_constants.dart';
import 'package:bluestackassignment/utils/custom_exception.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

Future<LoginConfigResponse> getUserDetails(String token) async {
  var dio = Dio();

  final uri =
      Uri.parse(StringConstants.baseURL + StringConstants.getUserDetails);
  final headers = <String, String>{
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ' + token,
  };

  dio.options.headers = {
    "Authorization": 'Bearer ' + token,
    'Content-Type': 'application/json'
  };
  try{
    final response =
    await dio.get(StringConstants.baseURL + StringConstants.getUserDetails);
    print(response.data);
    return LoginConfigResponse.fromJson(response.data);
  } on DioError catch (dioError) {
  throw CustomException.fromDioError(dioError);
  }
  // final response = await http.get(uri, headers: headers);
  // print(jsonDecode(response.body));;
  // if (response.statusCode == 200) {
  //   //return jsonDecode(response.body)["token"];
  //   return LoginConfigResponse.fromJson(jsonDecode(response.body));
  // }
  // else if(response.statusCode == 401){
  //   throw Exception('Invalid Username and password');
  // }
  // else {
  //   //throw Exception('Failed to obtain token');
  // }
}
