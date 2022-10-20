import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:hive_local_database/models/handler/api_return_users.dart';
import 'package:hive_local_database/models/users/list_users_models.dart';
import 'package:hive_local_database/models/users/users_models.dart';
import 'package:hive_local_database/services/list_users_services.dart';
import 'package:hive_local_database/ui/widgets/snackbar.dart';

class ListUsersProvider with ChangeNotifier {
  int _currentPage = 1;
  int get currentPage => _currentPage;

  late int _totalPage;
  int get totalPage => _totalPage;

  List<UsersModels> _userModels = [];
  List<UsersModels> get userModels => _userModels;

  bool? _refresh;
  bool? get refresh => _refresh;

  late Box _box;
  Box get box => _box;

  List _data = [];
  List get data => _data;

//Get data users
  Future listUsers({bool? refresh}) async {
    await openBox();
    refresh == true ? _currentPage = 1 : _currentPage++;

    ApiReturnUsers<ListUsersModels> result =
        await ListUsersServices().getDataServices(currentPage);
    var stCode = int.tryParse(result.code);

    switch (stCode) {
      case 200:

        //memasuki data dari API ke Local DB
        refresh!
            ? await putData(result.value!.data!)
            : result.value!.data!.forEach((element) {
                box.add(element);
              });
        notifyListeners();
        break;

      default:
        print('Jalanin ini');
        [];
        notifyListeners();
        break;
    }
  }

//On refresh
  Future onRefresh(context) async {
    await openBox();
    _currentPage = 1;
    try {
      ApiReturnUsers<ListUsersModels> _result =
          await ListUsersServices().getDataServices(currentPage);
      var stCode = int.tryParse(_result.code);
      print(stCode);
      switch (stCode) {
        case 200:
          //memasuki data dari API ke Local DB
          await putData(_result.value!.data!);
          notifyListeners();
          break;

        default:
          print('Jalanin ini');
          ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.snackBar(
              title: 'Terjadi Kesalahan ${_result.code} ${_result.message}',
              color: Colors.red));
          [];
          notifyListeners();
          break;
      }
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.snackBar(
          title: 'Tidak Ada Koneksi Internet', color: Colors.red));
    } catch (e) {
      print('ini');
      ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.snackBar(
          title: 'Terjadi Kesalahan ${e.toString()}', color: Colors.red));
    }
  }

  Future onLoad(context) async {
    _currentPage++;
    await openBox();
    try {
      ApiReturnUsers<ListUsersModels> _result =
          await ListUsersServices().getDataServices(currentPage);
      var stCode = int.tryParse(_result.code);
      print(stCode);
      switch (stCode) {
        case 200:
          //memasuki data dari API ke Local DB
          _result.value!.data!.forEach((element) {
            box.add(element);
          });
          notifyListeners();
          break;

        default:
          print('Jalanin ini');
          ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.snackBar(
              title: 'Terjadi Kesalahan ${_result.code} ${_result.message}',
              color: Colors.red));
          [];
          notifyListeners();
          break;
      }
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.snackBar(
          title: 'Tidak Ada Koneksi Internet', color: Colors.red));
    } catch (e) {
      print('ini');
      ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.snackBar(
          title: 'Terjadi Kesalahan ${e.toString()}', color: Colors.red));
    }
  }

//Open Box
  Future openBox() async {
    _box = await Hive.openBox<UsersModels>('box');
    return;
  }

//Untuk memasukan data
  Future putData(List<UsersModels> data) async {
    await _box.clear();
    /* box.add(data); */
    for (var i in data) {
      _box.add(i);
    }
  }
}
