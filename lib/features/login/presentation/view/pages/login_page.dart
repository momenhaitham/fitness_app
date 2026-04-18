import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_cubit.dart';
import 'package:fitness_app/features/login/presentation/view/widgets/login_body.dart';
import 'package:fitness_app/core/resources/assets_manager.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AssetsImage.loginBackGround,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: BlocProvider(
              create: (context) => getIt<LoginCubit>(),
              child: const LoginBody(),
            ),
          ),
        ],
      ),
    );
  }
}
