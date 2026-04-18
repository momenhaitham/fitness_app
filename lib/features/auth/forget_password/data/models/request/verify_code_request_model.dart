import 'package:json_annotation/json_annotation.dart';
part 'verify_code_request_model.g.dart';

@JsonSerializable()
class VerifyCodeRequestModel {
  factory VerifyCodeRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeRequestModelFromJson(json);
  @JsonKey(name: 'resetCode')
  final String resetCode;

  VerifyCodeRequestModel(this.resetCode);

  Map<String, dynamic> toJson() => _$VerifyCodeRequestModelToJson(this);
}
