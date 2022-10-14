import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_local_database/models/monster.dart';
import 'package:hive_local_database/pages/main_page.dart';
import 'package:hive_local_database/provider/list_users_provider.dart';
import 'package:provider/provider.dart';

late Box<dynamic> data;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MonsterAdapter());
  data = await Hive.openBox('testBox');
  data.put(
    'monster',
    Monster(
      name: 'Cat',
      level: 11,
    ),
  );
  data.put('name', 'maulana');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ListUsersProvider(),
        ),
      ],
      child: MaterialApp(
        title: '',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
