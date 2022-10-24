// To parse this JSON data, do
//
//     final listUsersModels = listUsersModelsFromJson(jsonString);

import 'dart:convert';

import 'package:hive_local_database/models/users/users_models.dart';

ListUsersModels listUsersModelsFromJson(String str) =>
    ListUsersModels.fromJson(json.decode(str));

String listUsersModelsToJson(ListUsersModels data) =>
    json.encode(data.toJson());

class ListUsersModels {
  ListUsersModels({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
  });

  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<UsersModels>? data;

  factory ListUsersModels.fromJson(Map<String, dynamic> json) =>
      ListUsersModels(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<UsersModels>.from(
            json["data"].map((x) => UsersModels.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
