import 'package:flutter/material.dart';
import 'package:hive_local_database/models/users/users_models.dart';

class DetailUserWidget extends StatelessWidget {
  final UsersModels? user;
  DetailUserWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network('${user?.avatar}'),
          Text('id : ${user?.id}'),
          Text('Nama : ${user?.firstName} ${user?.lastName}'),
          Text('Email : ${user?.email}'),
        ],
      ),
    );
  }
}
