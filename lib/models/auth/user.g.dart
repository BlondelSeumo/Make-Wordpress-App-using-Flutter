// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['ID'] as String,
    userLogin: json['user_login'] as String,
    userNiceName: json['user_nicename'] as String,
    userEmail: json['user_email'] as String,
    displayName: json['display_name'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    avatar: json['avatar'] as String ?? 'https://cdn.rnlab.io/placeholder-416x416.png',
    socialAvatar: json['socialAvatar'] as String,
    loginType: json['loginType'] as String ?? 'email',
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'ID': instance.id,
      'user_login': instance.userLogin,
      'user_nicename': instance.userNiceName,
      'user_email': instance.userEmail,
      'display_name': instance.displayName,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'avatar': instance.avatar,
      'socialAvatar': instance.socialAvatar,
      'loginType': instance.loginType,
    };
