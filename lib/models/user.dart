// To parse this JSON data, do
//
//     final chatUser = chatUserFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_drag_and_drop/constants.dart';

class User {
    String name;
    String uid;
    String email;
    DateTime createdAt;
    DateTime updatedAt;
    bool isActive;

    User({
        this.name,
        this.uid,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.isActive,
    });

    // factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    // String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json,uid) => User(
        name: json[USER_NAME] == null ? null :json[USER_NAME],
        uid: json[USER_ID] == null ? uid : json[USER_ID],
        email: json[USER_EMAIL] == null ? null : json[USER_EMAIL],
        createdAt: json[CREATED_AT] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(json[CREATED_AT]),
        updatedAt: json[UPDATED_AT] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(json[UPDATED_AT]),
        isActive: json[IS_ACTIVE] == null ? true : json[IS_ACTIVE],
    );

    Map<String, dynamic> toJson() => {
        USER_NAME: name == null ? null : name,
        USER_ID: uid == null ? null : uid,
        USER_EMAIL: email == null ? null : email,
        CREATED_AT: createdAt == null ? DateTime.now().millisecondsSinceEpoch : createdAt.millisecondsSinceEpoch,
        UPDATED_AT: updatedAt == null ? DateTime.now().millisecondsSinceEpoch : updatedAt.millisecondsSinceEpoch,
        IS_ACTIVE: isActive == null ? true : isActive,
    };
}
