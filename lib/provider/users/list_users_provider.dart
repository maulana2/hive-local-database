import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_local_database/main.dart';
import 'package:hive_local_database/models/handler/api_return_users.dart';
import 'package:hive_local_database/models/users/list_users_models.dart';
import 'package:hive_local_database/models/users/users_models.dart';
import 'package:hive_local_database/services/list_users_services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ListUsersProvider with ChangeNotifier {
  int currentPage = 1;
  late int totalPage;
  List<UsersModels> userModels = [];
  bool? refresh;
  late Box box;
  List data = [];

  Future listUsers({bool? refresh}) async {
    await openBox();
    refresh == true ? currentPage = 1 : currentPage++;
    ApiReturnUsers<ListUsersModels> result =
        await ListUsersServices().getDataServices(currentPage);
    var stCode = int.tryParse(result.code);

    switch (stCode) {
      case 200:
        print('status 200 ok mulai');
        refresh!
            ? await putData(result.value!.data!)
            : result.value!.data!.forEach((element) {
                box.add(element);
              });
        print('status 200 ok end');
        print('Ini data dari hive : ${box.values.length}');
        notifyListeners();
        break;

      default:
        print('Jalanin ini');
        [];
        notifyListeners();
        break;
    }
  }

  Future onRefresh() async {
    currentPage = 1;
    try {
      ApiReturnUsers<ListUsersModels> result =
          await ListUsersServices().getDataServices(currentPage);
      await putData(result.value!.data!);
    } catch (SocketException) {
      print('No internet connection');
    }
  }

  Future onLoad() async {
    currentPage++;
    try {
      ApiReturnUsers<ListUsersModels> result =
          await ListUsersServices().getDataServices(currentPage);
      await putData(result.value!.data!);
    } catch (e) {
      print('error ${e}');
    }
  }

  Future openBox() async {
    box = await Hive.openBox<UsersModels>('box');
    return;
  }

  Future putData(List<UsersModels> data) async {
    await box.clear();
    /* box.add(data); */
    for (var i in data) {
      box.add(i);
    }
  }

  myMapping() async {
    print('jalanin map');
    var myMap = box.toMap().values.toList();
    if (myMap.isEmpty) {
      box.add('empty');
    } else {
      data = myMap;
    }
  }
}
