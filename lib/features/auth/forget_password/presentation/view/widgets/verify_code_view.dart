import 'dart:async';
import 'package:fitness_app/core/app_locale/app_locale.dart';
import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:fitness_app/core/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../view_model/forget_password_cubit/forget_password_cubit.dart';
import '../../view_model/forget_password_cubit/forget_password_intents.dart';
import '../../view_model/forget_password_cubit/forget_password_states.dart';
import '../../view_model/forget_password_cubit/forget_password_ui_intents.dart';

class VerifyCodeView extends StatefulWidget {
  final VoidCallback onSuccess;

  const VerifyCodeView({super.key, required this.onSuccess});

  @override
  State<VerifyCodeView> createState() => VerifyCodeViewState();
}

class VerifyCodeViewState extends State<VerifyCodeView> {
  StreamSubscription? _subscription;
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _subscription = context.read<ForgetPasswordCubit>().uiIntents.listen((
        event,
      ) {
        if (!mounted) return;
        switch (event) {
          case ShowLoadingVerifyIntent():
            _showLoading();
          case ShowErrorMsgVerifyIntent():
            _hideLoading();
          case ShowSuccessMsgVerifyIntent(:final message):
            _hideLoading();
            _showSuccess(message);
          case NavigateToResetPasswordIntent():
            _hideLoading();
            widget.onSuccess();
          default:
            break;
        }
      });
    });
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

  void _showLoading() {
    UIUtils.showEasyLoading();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 55,
      textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.baseWhiteColor, width: 2),
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: const Border(
        bottom: BorderSide(color: AppColors.primaryColor, width: 2),
      ),
    );

    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocale.otpCode,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.baseWhiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                /// SUBTITLE
                Text(
                  AppLocale.enterOTP,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.baseWhiteColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
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
                      /// OTP INPUT
                      Pinput(
                        controller: _otpController,
                        length: 6, // 👈 match UI (4 digits)
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        showCursor: false,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        onChanged: (value) {
                          context.read<ForgetPasswordCubit>().doIntent(
                            OtpChangedIntent(value),
                          );
                        },
                      ),

                      const SizedBox(height: 30),

                      /// CONFIRM BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<ForgetPasswordCubit>().doIntent(
                              SubmitCodeIntent(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(
                            AppLocale.confirm,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// RESEND
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocale.didntRecieveVerificationCode,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.baseWhiteColor),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              context.read<ForgetPasswordCubit>().doIntent(
                                ResendCodeIntent(state.email),
                              );
                            },
                            child: Text(
                              AppLocale.resendCode,

                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.primaryColor,
                                  ),
                            ),
                          ),
                        ],
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
