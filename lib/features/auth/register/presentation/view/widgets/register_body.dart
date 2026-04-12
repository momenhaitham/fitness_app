// TODO: presentation RegisterBody
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/app_locale/app_locale.dart';
import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:fitness_app/core/resources/values_manager.dart';
import 'package:fitness_app/core/reusable_widgets/transparent_container.dart';
import 'package:fitness_app/core/validation/app_validators.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RegisterBody extends StatefulWidget {
  RegisterBody({super.key,required this.registerCubit});
  RegisterCubit registerCubit;

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    //var width = MediaQuery.of(context).size.width;
     return Form(
      key: widget.registerCubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocale.hey_there.tr(),style: Theme.of(context).textTheme.bodyLarge,),
          Text(AppLocale.create_an_account.tr(),style: Theme.of(context).textTheme.headlineLarge,),
          SizedBox(height: height * AppSize.s0_02,),
          TransparentContainer(
            width: double.infinity,
            child: Column(
              children: [
                Text(AppLocale.register.tr(),style: Theme.of(context).textTheme.headlineLarge,),
                SizedBox(height: height * AppSize.s0_02,),
                TextFormField(
                  validator: (value) =>  AppValidators.validateFirstName(value,context),
                  controller: widget.registerCubit.firstNameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline,color: AppColors.baseWhiteColor,),
                    hintText: AppLocale.first_name.tr(),
                  ),
                ),
                SizedBox(height: height * AppSize.s0_02,),
                TextFormField(
                  controller: widget.registerCubit.lastNameController,
                  validator: (value) =>  AppValidators.validateLastName(value,context),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline,color: AppColors.baseWhiteColor,),
                    hintText: AppLocale.last_name.tr(),
                  ),
                ),
                SizedBox(height: height * AppSize.s0_02,),
                TextFormField(
                  controller: widget.registerCubit.emailController,
                  validator: (value) =>  AppValidators.validateEmail(value,context),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined,color: AppColors.baseWhiteColor,),
                    hintText: AppLocale.email.tr(),
                  ),
                ),
                SizedBox(height: height * AppSize.s0_02,),
                TextFormField(
                  
                  validator: (value) =>  AppValidators.validatePassword(value,context),
                  controller: widget.registerCubit.passwordController,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility,color: AppColors.primaryColor,),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    prefixIcon: Icon(Icons.lock_outline_rounded,color: AppColors.baseWhiteColor,),
                    hintText: AppLocale.password.tr(),
                  ),
                ),
                SizedBox(height: height * AppSize.s0_04,),
                Container(
                  height: height * AppSize.s0_05,
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {
                    print(widget.registerCubit.lastNameController.text);
                    if(widget.registerCubit.formKey.currentState!.validate()){
                      widget.registerCubit.doIntent(RegisterNextStep());
                    }
                  }, child: Text(AppLocale.register.tr(),style: Theme.of(context).textTheme.titleLarge,)),
                ),
                SizedBox(height: height * AppSize.s0_05,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}