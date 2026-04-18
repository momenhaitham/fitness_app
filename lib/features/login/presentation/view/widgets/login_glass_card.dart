import 'dart:ui';
import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:fitness_app/core/validation/app_validators.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_cubit.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'glass_text_field.dart';
import 'social_button.dart';

class LoginGlassCard extends StatelessWidget {
  final LoginCubit cubit;
  final bool isPasswordObscured;
  final VoidCallback onObscureToggle;
  final bool isLoading;
  final VoidCallback onLogin;

  const LoginGlassCard({
    super.key,
    required this.cubit,
    required this.isPasswordObscured,
    required this.onObscureToggle,
    required this.isLoading,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 36.h),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.45),
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(color: Colors.white.withOpacity(0.08), width: 1),
          ),
          child: Column(
            children: [
              // Login title
              Text(
                'Login',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 25.sp,
                    ),
              ),
              SizedBox(height: 28.h),

              // ── Email Field ───────────────────────────────
              GlassTextField(
                controller: cubit.emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Email',
                prefixIcon: Icons.email_outlined,
                validator: (val) => AppValidators.validateEmail(val, context),
              ),
              SizedBox(height: 16.h),

              // ── Password Field ────────────────────────────
              GlassTextField(
                controller: cubit.passwordController,
                hintText: 'Password',
                prefixIcon: Icons.lock_outline,
                obscureText: isPasswordObscured,
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordObscured
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.white54,
                    size: 20.sp,
                  ),
                  onPressed: onObscureToggle,
                ),
                validator: (val) => AppValidators.validatePassword(val, context),
              ),

              // ── Forgot Password ───────────────────────────
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // ── Divider with "Or" ─────────────────────────
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      'Or',
                      style: TextStyle(color: Colors.white54, fontSize: 12.sp),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                ],
              ),
              SizedBox(height: 20.h),

              // ── Social Login Icons ────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialButton(icon: Icons.facebook, onTap: () {}),
                  SizedBox(width: 20.w),
                  SocialButton(label: 'G', onTap: () {}),
                  SizedBox(width: 20.w),
                  SocialButton(icon: Icons.apple, onTap: () {}),
                ],
              ),
              SizedBox(height: 28.h),

              // ── Login Button ──────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 54.h,
                child: ElevatedButton(
                  onPressed: isLoading ? null : onLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        AppColors.primaryColor.withOpacity(0.6),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: isLoading
                      ? SizedBox(
                          height: 22.h,
                          width: 22.h,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 16.h),

              // ── Register Row ──────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't Have An Account Yet ? ",
                    style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                  ),
                  GestureDetector(
                    onTap: () => cubit.doIntent(NavigateToRegisterEvent()),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
