import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_local_database/main.dart';
import 'package:hive_local_database/models/monster.dart';
import 'package:hive_local_database/models/users/users_models.dart';
import 'package:hive_local_database/provider/users/list_users_provider.dart';
import 'package:hive_local_database/widgets/item_users_widget.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  @override
  Widget build(BuildContext context) {
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
            future: Provider.of<ListUsersProvider>(context, listen: false)
                .listUsers(refresh: false),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
                print('Ini hasData');
              } else if (snapshot.hasError) {
                return Consumer<ListUsersProvider>(
                  builder: (context, data, child) => EasyRefresh(
                    onRefresh: () => data.listUsers(refresh: true),
                    onLoad: () => data.listUsers(refresh: false),
                    child: ListView(
                      children: [
                        Container(
                          color: Colors.red,
                          child: Text(
                              "Error ${snapshot.error} Silahkan Coba Lagi"),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var users = data.box;
                              print(users.length);
                              UsersModels user = users.getAt(index);
                              return ItemUserWidget(user: user);
                            },
                            itemCount: data.box.length),
                      ],
                    ),
                  ),
                );
              } else {
                return Consumer<ListUsersProvider>(
                  builder: (context, data, child) => EasyRefresh(
                    onRefresh: () => data.listUsers(refresh: true),
                    onLoad: () => data.listUsers(refresh: false),
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          var users = data.box;
                          print(users.length);
                          UsersModels user = users.getAt(index);
                          return ItemUserWidget(user: user);
                        },
                        itemCount: data.box.length),
                  ),
                );
              }
            }
            /* if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (SocketException == true) {
                print('Tidak ada sinyal');
                return Center(
        
                  child: Text('Tidak ada sinyal'),
                );
              } else if (snapshot.hasError) {
                print("ini snap ${snapshot.error}");
                return Center(child: Text('Terjadi Kesalahan ${snapshot.error}'));
              } else {
                /* var userModels = Provider.of<ListUsersProvider>(context).box; */
                return Consumer<ListUsersProvider>(
                  builder: (context, value, child) => EasyRefresh(
                    onRefresh: () => value.listUsers(refresh: true),
                    onLoad: () => value.listUsers(refresh: false),
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          var data = value.box;
                          print(data.length);
                          UsersModels user = data.getAt(index);
                          return ItemUserWidget(user: user);
                        },
                        itemCount: value.box.length),
                  ),
                );
              } */

            ),
      ),
    );
  }
}
