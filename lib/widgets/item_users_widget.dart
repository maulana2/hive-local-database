import 'package:flutter/material.dart';

import 'package:hive_local_database/models/users/users_models.dart';
import 'package:hive_local_database/shared/theme.dart';

class ItemUserWidget extends StatelessWidget {
  final UsersModels user;

  const ItemUserWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(defaultMargin),
        color: itemColorPrimary,
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              margin: EdgeInsets.only(right: defaultMargin),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('${user.avatar}'))),
            ),
            Expanded(
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.firstName} ${user.lastName}',
                      style: blackTextStyle.copyWith(
                          fontSize: 18, fontWeight: semiBold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${user.email}',
                      style: blackTextStyle,
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
