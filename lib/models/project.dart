// To parse this JSON data, do
//
//     final project = projectFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_drag_and_drop/constants.dart';

class Project {
  String projectName;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  bool isActive;

  Project({
    this.projectName,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isActive,
  });

  factory Project.fromRawJson(String str) => Project.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        projectName: json[PROJECT_NAME] == null ? null : json[PROJECT_NAME],
        id: json[PROJECT_ID] == null ? null : json[PROJECT_ID],
        createdAt: json[CREATED_AT] == null
            ? DateTime.now()
            : DateTime.fromMillisecondsSinceEpoch(json[CREATED_AT]),
        updatedAt: json[UPDATED_AT] == null
            ? DateTime.now()
            : DateTime.fromMillisecondsSinceEpoch(json[UPDATED_AT]),
        isActive: json[IS_ACTIVE] == null ? true : json[IS_ACTIVE],
      );

  Map<String, dynamic> toJson() => {
        PROJECT_NAME: projectName == null ? null : projectName,
        PROJECT_ID: id == null ? null : id,
        CREATED_AT: createdAt == null
            ? DateTime.now().millisecondsSinceEpoch
            : createdAt.millisecondsSinceEpoch,
        UPDATED_AT: updatedAt == null
            ? DateTime.now().millisecondsSinceEpoch
            : updatedAt.millisecondsSinceEpoch,
        IS_ACTIVE: isActive == null ? true : isActive,
      };
}
