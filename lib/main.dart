import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_local_database/provider/scan_pdf/scan_pdf_provider.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'package:hive_local_database/models/users/users_models.dart';
import 'package:hive_local_database/ui/pages/main_page.dart';
import 'package:hive_local_database/provider/users/list_users_provider.dart';




late Box userData;
void main() async {
  //Karna Hive.init dipanggil sebelum runApp
  WidgetsFlutterBinding.ensureInitialized();
  
  //untuk mendapatkan directory penyimpanan
  var dir = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.initFlutter();


  //Registrasion adapter
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
        ChangeNotifierProvider(
          create: (context) => ScanPdfProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
