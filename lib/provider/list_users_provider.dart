import 'package:flutter/foundation.dart';
import 'package:hive_local_database/models/handler/api_return_users.dart';
import 'package:hive_local_database/models/users/list_users_models.dart';
import 'package:hive_local_database/models/users/users_models.dart';
import 'package:hive_local_database/services/list_users_services.dart';

class ListUsersProvider with ChangeNotifier {
  int currentPage = 1;
  late int totalPage;
  late List<UsersModels> userModels = [];
  bool? refresh;
  listUsers(bool refresh) async {
    print('List User Provider Print');
    refresh == true ? currentPage = 1 : currentPage++;

    ApiReturnUsers<ListUsersModels> result =
        await ListUsersServices().getDataServices(currentPage);
    var stCode = int.tryParse(result.code);
    print(stCode);
    switch (stCode) {
      case 200:
        print('provider 200');
        refresh
            ? userModels = result.value!.data!
            : userModels = userModels + result.value!.data!;
        print(userModels.length);
        break;

      default:
        print('jalanin ini');
        [];
    }
  }
}
