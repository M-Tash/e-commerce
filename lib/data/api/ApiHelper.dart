import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/entities/failures.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper._();

  static ApiHelper? _instance;

  static ApiHelper getInstance() {
    _instance ??= ApiHelper._();
    return _instance!;
  }

  Future<Either<Failures, dynamic>> post(
      Uri url, dynamic body, String errorMessage) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        var response = await http.post(url, body: body);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return Right(jsonDecode(response.body));
        } else {
          return Left(ServerError(errorMessage: errorMessage));
        }
      } else {
        return Left(
            NetworkError(errorMessage: 'Please check internet connection'));
      }
    } on SocketException catch (e) {
      if (e.osError?.errorCode == 7) {
        return Left(
            NetworkError(errorMessage: 'Please check internet connection'));
      } else {
        return Left(NetworkError(errorMessage: 'Failed to connect to server.'));
      }
    } catch (e) {
      return Left(NetworkError(errorMessage: 'An unexpected error occurred.'));
    }
  }

  Future<Either<Failures, dynamic>> get(Uri url, String errorMessage) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        var response = await http.get(url);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          print(response.contentLength);
          return Right(jsonDecode(response.body));
        } else {
          return Left(ServerError(errorMessage: errorMessage));
        }
      } else {
        return Left(
            NetworkError(errorMessage: 'Please check internet connection'));
      }
    } on SocketException catch (e) {
      if (e.osError?.errorCode == 7) {
        return Left(
            NetworkError(errorMessage: 'Please check internet connection'));
      } else {
        return Left(NetworkError(errorMessage: 'Failed to connect to server.'));
      }
    } catch (e) {
      return Left(NetworkError(errorMessage: 'An unexpected error occurred.'));
    }
  }
//
}
