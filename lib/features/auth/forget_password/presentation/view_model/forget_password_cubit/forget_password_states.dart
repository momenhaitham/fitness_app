import 'package:equatable/equatable.dart';

class ForgetPasswordStates extends Equatable {
  // Provide Email fields
  final String email;
  final bool isValidEmail;

  // Verify Code fields
  final String code;
  final bool isValidOtp;

  // Reset Password fields
  final String newPassword;
  final String confirmPassword;
  final bool isValidForm;

  final String? errorMessage;
  final bool? isEmpty;

  const ForgetPasswordStates({
    this.errorMessage,
    this.isEmpty,
    this.email = '',
    this.isValidEmail = false,
    this.code = '',
    this.isValidOtp = false,
    this.newPassword = '',
    this.confirmPassword = '',
    this.isValidForm = false,
  });

  ForgetPasswordStates copyWith({
    dynamic data,
    String? errorMessage,
    bool? isEmpty,
    String? email,
    bool? isValidEmail,
    String? code,
    bool? isValidOtp,
    String? newPassword,
    String? confirmPassword,
    bool? isValidForm,
  }) {
    return ForgetPasswordStates(
      errorMessage: errorMessage ?? this.errorMessage,
      isEmpty: isEmpty ?? this.isEmpty,
      email: email ?? this.email,
      isValidEmail: isValidEmail ?? this.isValidEmail,
      code: code ?? this.code,
      isValidOtp: isValidOtp ?? this.isValidOtp,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isValidForm: isValidForm ?? this.isValidForm,
    );
  }

  @override
  List<Object?> get props => [
    isEmpty,
    email,
    isValidEmail,
    code,
    isValidOtp,
    newPassword,
    confirmPassword,
    isValidForm,
    errorMessage,
  ];
}
