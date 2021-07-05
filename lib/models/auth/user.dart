import 'package:cirilla/constants/assets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'ID')
  String id;

  @JsonKey(name: 'user_login')
  String userLogin;

  @JsonKey(name: 'user_nicename')
  String userNiceName;

  @JsonKey(name: 'user_email')
  String userEmail;

  @JsonKey(name: 'display_name')
  String displayName;

  @JsonKey(name: 'first_name')
  String firstName;

  @JsonKey(name: 'last_name')
  String lastName;

  @JsonKey(defaultValue: Assets.noImageUrl)
  String avatar;

  String socialAvatar;

  @JsonKey(defaultValue: 'email')
  String loginType;

  User({
    this.id,
    this.userLogin,
    this.userNiceName,
    this.userEmail,
    this.displayName,
    this.firstName,
    this.lastName,
    this.avatar,
    this.socialAvatar,
    this.loginType,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
