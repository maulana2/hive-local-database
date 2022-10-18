import 'dart:convert';
import 'dart:io';

import 'package:hive_local_database/models/handler/api_return_users.dart';
import 'package:hive_local_database/models/users/list_users_models.dart';
import 'package:hive_local_database/models/users/users_models.dart';
import 'package:hive_local_database/shared/const_api.dart';
import 'package:http/http.dart' as http;

class ListUsersServices {
  late int totalPage;
  Future<ApiReturnUsers<ListUsersModels>> getDataServices(currentPage) async {
    /* String url = '$urlApi$pageUser$page=${currentPage.toString()}'; */
    String url = '${urlApi}${pageUser}${page}${currentPage}';
    print(url);
    var response = await http.get(Uri.parse(url));

    try {
      print('Mulai try');
      switch (response.statusCode) {
        case 200:
          var bodyResponse = jsonDecode(response.body);
          ListUsersModels users = ListUsersModels.fromJson(bodyResponse);
          print('Ini length ListUsersModels : ${users.data!.length}');
          return ApiReturnUsers(
            code: response.statusCode.toString(),
            message: response.body,
            value: users,
          );
        case 404:
          return ApiReturnUsers(
            code: response.statusCode.toString(),
            message: response.body,
          );
        default:
          return ApiReturnUsers(
            code: response.statusCode.toString(),
            message: response.body,
          );
      }
    } on SocketException {
      print('jalaninn ini');
      return ApiReturnUsers(
        code: '',
        message: 'Terjadi Kesalahan : Tidak ada koneksi internet',
      );
    } on HttpException {
      return ApiReturnUsers(
        code: '',
        message: 'Terjadi Kesalahan : Tidak dapat menemukan data',
      );
    } on FormatException {
      return ApiReturnUsers(
        code: '',
        message: 'Terjadi Kesalahan : Bad Response Format',
      );
    } catch (e) {
      return ApiReturnUsers(
        code: '',
        message: 'Terjadi Kesalahan : Kesalahan ${e.toString()}',
      );
    }
  }
}
