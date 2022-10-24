import 'package:flutter/material.dart';
import 'package:hive_local_database/models/users/users_models.dart';
import 'package:hive_local_database/ui/widgets/detail_user.widget.dart';

class DetailUserPage extends StatelessWidget {
  final UsersModels user;
  const DetailUserPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    appBarItem() {
      return AppBar(
        centerTitle: true,
        title: Text('Detail user'),
      );
    }

    return Scaffold(
      appBar: appBarItem(),
      body: DetailUserWidget(user: user),
    );
  }
}
