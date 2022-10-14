import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_local_database/main.dart';
import 'package:hive_local_database/models/monster.dart';
import 'package:hive_local_database/provider/list_users_provider.dart';
import 'package:hive_local_database/widgets/item_users_widget.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    /* var load = Provider.of<ListUsersProvider>(context, listen: false)
        .listUsers(refresh: false); */
    /* var refresh = Provider.of<ListUsersProvider>(context, listen: false)
        .listUsers(refresh: true); */
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
        appBar: AppBar(
          title: Text('Hive Database'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: Provider.of<ListUsersProvider>(context).listUsers(false),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.hasError}'),
              );
            } else {
              return Consumer<ListUsersProvider>(
                builder: (context, value, child) {
                  return EasyRefresh(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            print('jalanin builder');
                            return ItemUserWidget(
                                user: value.userModels[index]);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 16,
                              ),
                          itemCount: value.userModels.length));
                },
              );
            }
          },
        ),
      ),
    );
  }
}
