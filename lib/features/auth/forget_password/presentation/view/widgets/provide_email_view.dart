import 'dart:async';
import 'package:fitness_app/core/app_locale/app_locale.dart';
import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:fitness_app/core/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/forget_password_cubit/forget_password_cubit.dart';
import '../../view_model/forget_password_cubit/forget_password_intents.dart';
import '../../view_model/forget_password_cubit/forget_password_states.dart';
import '../../view_model/forget_password_cubit/forget_password_ui_intents.dart';

class ProvideEmailView extends StatefulWidget {
  final Function(String) onSuccess;

  const ProvideEmailView({super.key, required this.onSuccess});

  @override
  State<ProvideEmailView> createState() => ProvideEmailViewState();
}

class ProvideEmailViewState extends State<ProvideEmailView> {
  final TextEditingController _emailController = TextEditingController();
  StreamSubscription? _subscription;

  @override
  void dispose() {
    _emailController.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _subscription = context.read<ForgetPasswordCubit>().uiIntents.listen((
        event,
      ) {
        if (!mounted) return;
        switch (event) {
          case ShowLoadingProvideEmailIntent():
            _showLoading();
          case ShowErrorProvideEmailIntent(:final errorMessage):
            _hideLoading();
            _handleError(errorMessage);
          case NavigateToVerifyIntent():
            _hideLoading();
            _handleNavigateToVerify();
          default:
            break;
        }
      });
    });
  }

  void _showLoading() {
    UIUtils.showEasyLoading();
  }

  void _handleError(String errorMessage) {
    UIUtils.showMessage(
      errorMessage,
      backGroundColor: AppColors.errorColor,
      textColor: AppColors.baseWhiteColor,
    );
  }

  void _hideLoading() {
    UIUtils.hideLoading(context);
  }

  void _handleNavigateToVerify() {
    widget.onSuccess(_emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                AppLocale.enterYourEmail,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.baseWhiteColor,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                AppLocale.forgetPassword,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.baseWhiteColor,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: AppColors.lightBlack.withOpacity(0.85),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    onChanged: (value) => context
                        .read<ForgetPasswordCubit>()
                        .doIntent(EmailChangedIntent(value)),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 15,
                      ),
                      labelText: AppLocale.email,
                      labelStyle: const TextStyle(
                        color: AppColors.baseWhiteColor,
                        fontSize: 13,
                      ),
                      floatingLabelStyle: const TextStyle(
                        color: AppColors.baseWhiteColor,
                        fontSize: 13,
                      ),
                      hintText: AppLocale.enterYourEmail,
                      hintStyle: const TextStyle(
                        color: AppColors.baseWhiteColor,
                        fontSize: 13,
                      ),
                      hoverColor: AppColors.baseWhiteColor,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: AppColors.baseWhiteColor,
                        size: 18,
                      ),
                    ),
                    style: const TextStyle(
                      color: AppColors.baseWhiteColor,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: size.height * 0.055,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () {
                        context.read<ForgetPasswordCubit>().doIntent(
                          ConfirmEmailIntent(),
                        );
                      },
                      child: Text(
                        AppLocale.sentOTP,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.baseWhiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
