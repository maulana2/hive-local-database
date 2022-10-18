import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_local_database/models/monster.dart';
import 'package:hive_local_database/models/users/users_models.dart';
import 'package:hive_local_database/pages/main_page.dart';
import 'package:hive_local_database/provider/users/list_users_provider.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

late Box<dynamic> data;
late Box userData;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.initFlutter();
  Hive.registerAdapter(MonsterAdapter());
  Hive.registerAdapter(UsersModelsAdapter());
  
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
