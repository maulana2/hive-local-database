import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hive_local_database/models/users/users_models.dart';
import 'package:hive_local_database/provider/users/list_users_provider.dart';
import 'package:hive_local_database/widgets/item_users_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
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
              } else {
                return Consumer<ListUsersProvider>(
                  builder: (context, data, child) => EasyRefresh(
                    scrollController: scrollController,
                    notLoadFooter: NotLoadFooter(),
                    onRefresh: () => data.onRefresh(context),
                    onLoad: () => data.onLoad(context),
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          var users = data.box;
                          UsersModels user = users.getAt(index);
                          return ItemUserWidget(user: user);
                        },
                        itemCount: data.box.length),
                  ),
                );
              }
            }),
      ),
    );
  }
}
