import 'package:hive/hive.dart';

part 'users_models.g.dart';

@HiveType(typeId: 2)
class UsersModels {
  UsersModels({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? email;
  @HiveField(2)
  String? firstName;
  @HiveField(3)
  String? lastName;
  @HiveField(4)
  String? avatar;

  factory UsersModels.fromJson(Map<String, dynamic> json) => UsersModels(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}
