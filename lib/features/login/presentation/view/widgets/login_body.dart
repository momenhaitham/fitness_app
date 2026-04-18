import 'dart:async';
import 'package:fitness_app/features/login/presentation/view/widgets/login_glass_card.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_cubit.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_events.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_states.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_temp_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_greeting.dart';
import 'login_logo.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool _isPasswordObscured = true;
  bool _isLoading = false;
  late StreamSubscription<LoginTempEvents> _tempSubscription;
  late LoginCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<LoginCubit>();
    _tempSubscription = _cubit.cubitStream.listen((event) {
      if (event is ShowMassageTempEvent) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(event.massage)));
      } else if (event is NavigateToHomeTempEvent) {
        // TODO: Navigate to Home
      } else if (event is NavigateToRegisterTempEvent) {
        // TODO: Navigate to Register
      } else if (event is ShowLoadingTempEvent) {
        setState(() => _isLoading = true);
      } else if (event is HideLoadingTempEvent) {
        setState(() => _isLoading = false);
      }
    });
  }

  @override
  void dispose() {
    _tempSubscription.cancel();
    super.dispose();
  }

  void _login() {
    if (_cubit.formKey.currentState!.validate()) {
      _cubit.doIntent(Login());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: Form(
            key: _cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoginLogo(),
                SizedBox(height: 20.h),

                const LoginGreeting(),
                SizedBox(height: 20.h),

                LoginGlassCard(
                  cubit: _cubit,
                  isLoading: _isLoading,
                  isPasswordObscured: _isPasswordObscured,
                  onObscureToggle: () {
                    setState(() {
                      _isPasswordObscured = !_isPasswordObscured;
                    });
                  },
                  onLogin: _login,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
