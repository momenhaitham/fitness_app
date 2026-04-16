import 'package:json_annotation/json_annotation.dart';
part 'reset_password_request_model.g.dart';

@JsonSerializable()
class ResetPasswordRequestModel {
  factory ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestModelFromJson(json);
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'newPassword')
  final String newPassword;

  const ResetPasswordRequestModel({
    required this.email,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => _$ResetPasswordRequestModelToJson(this);
}
