import 'package:json_annotation/json_annotation.dart';
part 'forget_password_request_model.g.dart';

@JsonSerializable()
class ForgetPasswordRequestModel {
  factory ForgetPasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordRequestModelFromJson(json);
  @JsonKey(name: 'email')
  final String email;

  ForgetPasswordRequestModel({required this.email});

  Map<String, dynamic> toJson() => _$ForgetPasswordRequestModelToJson(this);
}
