import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_local_database/models/users/list_users_models.dart';
import 'package:hive_local_database/ui/pages/scan_pdf.dart';
import 'package:hive_local_database/ui/widgets/scroll_unscrollable.dart';
import 'package:hive_local_database/ui/widgets/search_widget.dart';
import 'package:provider/provider.dart';

import 'package:hive_local_database/models/users/users_models.dart';
import 'package:hive_local_database/provider/users/list_users_provider.dart';
import 'package:hive_local_database/ui/widgets/item_users_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var query = '';
  @override
  Widget build(BuildContext context) {
    Widget search() {
      return SearchWidget(
        text: query,
        onChanged: (query) {
          Provider.of<ListUsersProvider>(context, listen: false)
              .changeFilterString(query);
        },
      );
    }

    ScrollController scrollController = ScrollController();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.photo_camera_outlined),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ScanPdfPage(),
            ));
          },
        ),
        appBar: AppBar(
          title: const Text('Hive Database'),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: Provider.of<ListUsersProvider>(context, listen: false)
                .listUsers(refresh: false),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ValueListenableBuilder(
                  valueListenable: Hive.box<UsersModels>('box').listenable(),
                  builder: (context, data, child) => Flex(
                    direction: Axis.vertical,
                    children: [
                      
                      search(),
                      Expanded(
                        child: Consumer<ListUsersProvider>(
                          builder: (context, provider, child) => EasyRefresh(
                            scrollController: scrollController,
                            onRefresh: () => provider.onRefresh(context),
                            onLoad: () => provider.onLoad(context),
                            child: ListView.builder(
                                itemBuilder: (context, index) {
                                  var users = provider.boxx;

                                  return ItemUserWidget(user: users[index]);
                                },
                                itemCount: provider.boxx.length),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
                
              }
            }),
      ),
    );
  }
}
