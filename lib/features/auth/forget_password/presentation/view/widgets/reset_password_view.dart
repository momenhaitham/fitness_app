import 'dart:async';
import 'package:fitness_app/core/app_locale/app_locale.dart';
import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:fitness_app/core/routes/app_route.dart';
import 'package:fitness_app/core/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/forget_password_cubit/forget_password_cubit.dart';
import '../../view_model/forget_password_cubit/forget_password_intents.dart';
import '../../view_model/forget_password_cubit/forget_password_states.dart';
import '../../view_model/forget_password_cubit/forget_password_ui_intents.dart';

class ResetPasswordView extends StatefulWidget {
  final VoidCallback onSuccess;
  const ResetPasswordView({super.key, required this.onSuccess});

  @override
  State<ResetPasswordView> createState() => ResetPasswordViewState();
}

class ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  StreamSubscription? _subscription;

  bool _isNewPassObscured = true;
  bool _isConfirmPassObscured = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _subscription = context.read<ForgetPasswordCubit>().uiIntents.listen((
        event,
      ) {
        if (!mounted) return;
        switch (event) {
          case ShowLoadingResetPasswordIntent():
            _showLoading();
          case ShowErrorMsgResetPasswordIntent(:final errorMessage):
            _hideLoading();
            _showError(errorMessage);
          case NavigateToLoginIntent(:final message):
            _hideLoading();
            _showSuccess(message);
            _goToLogin();
          default:
            break;
        }
      });
    });
  }

  void _goToLogin() {
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  void _showLoading() {
    UIUtils.showEasyLoading();
  }

  void _showSuccess(String message) {
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.successColor,
      textColor: AppColors.baseWhiteColor,
    );
  }

  void _hideLoading() {
    UIUtils.hideLoading(context);
  }

  void _showError(String errorMessage) {
    UIUtils.showMessage(
      errorMessage,
      backGroundColor: AppColors.errorColor,
      textColor: AppColors.baseWhiteColor,
    );
  }

  @override
  void dispose() {
    _newPassController.dispose();
    _confirmPassController.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Text(
                  AppLocale.resetPasswordTitle, // "Make sure it's 8 chars..."
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.baseWhiteColor,
                  ),
                ),

                const SizedBox(height: 6),

                /// TITLE
                Text(
                  AppLocale.resetPasswordHeader, // "Create New Password"
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.baseWhiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                /// CARD
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlack.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      /// NEW PASSWORD FIELD
                      TextField(
                        controller: _newPassController,
                        obscureText: _isNewPassObscured,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) => context
                            .read<ForgetPasswordCubit>()
                            .doIntent(NewPasswordChangedIntent(value)),
                        decoration: InputDecoration(
                          hintText: AppLocale.enterPassword,
                          hintStyle: TextStyle(
                            color: AppColors.baseWhiteColor.withOpacity(0.5),
                          ),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: AppColors.baseWhiteColor.withOpacity(0.5),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isNewPassObscured
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.baseWhiteColor.withOpacity(0.5),
                            ),
                            onPressed: () {
                              setState(() {
                                _isNewPassObscured = !_isNewPassObscured;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: AppColors.baseWhiteColor.withOpacity(0.5),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// CONFIRM PASSWORD FIELD
                      TextField(
                        controller: _confirmPassController,
                        obscureText: _isConfirmPassObscured,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) => context
                            .read<ForgetPasswordCubit>()
                            .doIntent(ConfirmPasswordChangedIntent(value)),
                        decoration: InputDecoration(
                          hintText: AppLocale.confirmPassword,
                          hintStyle: const TextStyle(color: Colors.white54),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Colors.white70,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPassObscured
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.white70,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPassObscured =
                                    !_isConfirmPassObscured;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.white24),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          errorText:
                              (state.confirmPassword.isNotEmpty &&
                                  state.newPassword != state.confirmPassword)
                              ? AppLocale.passwordsDoNotMatch
                              : null,
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// DONE BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<ForgetPasswordCubit>().doIntent(
                              ConfirmResetPasswordIntent(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            AppLocale.confirm, // "Done"
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
