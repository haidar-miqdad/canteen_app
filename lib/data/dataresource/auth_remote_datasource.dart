import 'dart:convert';

import 'package:canteen_app/data/dataresource/auth_local_datasource.dart';
import 'package:canteen_app/data/model/response/auth_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource{
  Future<Either<String, AuthResponseModel>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.90.67:8000/api/login'),
      headers:{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password
      }),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }


  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('http://192.168.90.67:8000/api/logout'),
      headers:{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}'
      },
    );

    if (response.statusCode == 200) {
      return Right(response.body);
    } else {
      return Left(response.body);
    }
  }


}