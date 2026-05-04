import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/core/app_locale/app_locale.dart';
import 'package:fitness_app/core/validation/app_regex.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/request/forget_password_request_model.dart';
import '../../../data/models/request/reset_password_request_model.dart';
import '../../../data/models/request/verify_code_request_model.dart';
import '../../../domain/use_cases/forget_password_use_case.dart';
import '../../../domain/use_cases/reset_password_use_case.dart';
import '../../../domain/use_cases/verify_code_use_case.dart';
import 'forget_password_intents.dart';
import 'forget_password_states.dart';
import 'forget_password_ui_intents.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final VerifyCodeUseCase _verifyCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  ForgetPasswordCubit({
    required ForgetPasswordUseCase forgetPasswordUseCase,
    required VerifyCodeUseCase verifyCodeUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
  }) : _forgetPasswordUseCase = forgetPasswordUseCase,
       _verifyCodeUseCase = verifyCodeUseCase,
       _resetPasswordUseCase = resetPasswordUseCase,
       super(const ForgetPasswordStates());

  final StreamController<ForgetPasswordUiIntents> _streamController =
      StreamController.broadcast();

  Stream<ForgetPasswordUiIntents> get uiIntents => _streamController.stream;

  void doIntent(ForgetPasswordIntents intent) {
    switch (intent) {
      // --- Provide Email ---
      case EmailChangedIntent(email: final email):
        _emailChanged(email);
      case ConfirmEmailIntent():
        _confirmEmail();
      // --- Verify Code ---
      case OtpChangedIntent(code: final code):
        _otpCodeChanged(code);
      case ResendCodeIntent(email: final email):
        _resendCode(email);
      case SubmitCodeIntent():
        _submitCode();
      // --- Reset Password ---
      case NewPasswordChangedIntent():
        _newPasswordChanged(intent.newPassword);
      case ConfirmPasswordChangedIntent():
        _confirmPassword(intent.confirmPassword);
      case ConfirmResetPasswordIntent():
        _resetPassword();
    }
  }

  // Provide Email Logic

  void _emailChanged(String email) {
    emit(
      state.copyWith(email: email, isValidEmail: AppRegex.isEmailValid(email)),
    );
  }

  Future<void> _confirmEmail() async {
    if (!state.isValidEmail) {
      _streamController.add(
        ShowErrorProvideEmailIntent(AppLocale.emailInvalid.tr()),
      );
      return;
    }

    _streamController.add(ShowLoadingProvideEmailIntent());

    final request = ForgetPasswordRequestModel(email: state.email);

    final response = await _forgetPasswordUseCase(request);
    if (response is SuccessResponse<void>) {
      _streamController.add(NavigateToVerifyIntent());
    } else if (response is ErrorResponse<void>) {
      _streamController.add(
        ShowErrorProvideEmailIntent(response.error.toString()),
      );
    }
  }

  // Verify Code Logic

  void _otpCodeChanged(String code) {
    emit(
      state.copyWith(
        code: code,
        isValidOtp: _validOTP(code),
        errorMessage: null,
      ),
    );
  }

  bool _validOTP(String code) {
    return code.length == 6 && int.tryParse(code) != null;
  }

  Future<void> _submitCode() async {
    if (!state.isValidOtp) {
      _streamController.add(
        ShowErrorMsgVerifyIntent(AppLocale.invalidCode.tr()),
      );
      return;
    }
    _streamController.add(ShowLoadingVerifyIntent());

    final request = VerifyCodeRequestModel(state.code);

    final response = await _verifyCodeUseCase(request);

    if (response is SuccessResponse<void>) {
      _streamController.add(NavigateToResetPasswordIntent());
    } else if (response is ErrorResponse<void>) {
      emit(state.copyWith(errorMessage: AppLocale.invalidCode.tr()));
      _streamController.add(
        ShowErrorMsgVerifyIntent(AppLocale.invalidCode.tr()),
      );
    }
  }

  Future<void> _resendCode(String email) async {
    _streamController.add(ShowLoadingVerifyIntent());
    final request = ForgetPasswordRequestModel(email: email);
    final response = await _forgetPasswordUseCase(request);
    if (response is SuccessResponse<void>) {
      _streamController.add(
        ShowSuccessMsgVerifyIntent(AppLocale.messageSentSuccessfully.tr()),
      );
    } else if (response is ErrorResponse<void>) {
      _streamController.add(
        ShowErrorMsgVerifyIntent(response.error.toString()),
      );
    }
  }

  // Reset Password Logic

  void _newPasswordChanged(String newPassword) {
    emit(
      state.copyWith(
        newPassword: newPassword,
        isValidForm: _validateFields(
          newPassword: newPassword,
          confirmPassword: state.confirmPassword,
        ),
      ),
    );
  }

  bool _validateFields({
    required String newPassword,
    required String confirmPassword,
  }) {
    return newPassword.isNotEmpty && confirmPassword.isNotEmpty;
  }

  void _confirmPassword(String confirmPassword) {
    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        isValidForm: _validateFields(
          newPassword: state.newPassword,
          confirmPassword: confirmPassword,
        ),
      ),
    );
  }

  Future<void> _resetPassword() async {
    if (state.confirmPassword.isEmpty || state.newPassword.isEmpty) {
      _streamController.add(
        ShowErrorMsgResetPasswordIntent(AppLocale.completeFields.tr()),
      );
      return;
    }

    if (state.newPassword != state.confirmPassword) {
      _streamController.add(
        ShowErrorMsgResetPasswordIntent(AppLocale.passwordNotMatch.tr()),
      );
      return;
    }

    _streamController.add(ShowLoadingResetPasswordIntent());
    final request = ResetPasswordRequestModel(
      email: state.email,
      newPassword: state.newPassword,
    );

    final response = await _resetPasswordUseCase(request);

    if (response is SuccessResponse<void>) {
      _streamController.add(
        NavigateToLoginIntent(AppLocale.passwordUpdatedSuccessfully.tr()),
      );
    } else if (response is ErrorResponse<void>) {
      _streamController.add(
        ShowErrorMsgResetPasswordIntent(response.error.toString()),
      );
    }
  }

  @override
  Future<void> close() {
    _streamController.close();
    return super.close();
  }
}
