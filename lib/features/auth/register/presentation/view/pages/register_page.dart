import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/app_locale/app_locale.dart';
import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:fitness_app/core/resources/assets_manager.dart';
import 'package:fitness_app/core/resources/values_manager.dart';
import 'package:fitness_app/core/reusable_widgets/app_dialog.dart';
import 'package:fitness_app/core/reusable_widgets/back_arrow_icon.dart';
import 'package:fitness_app/core/reusable_widgets/show_dialog_utils.dart';
import 'package:fitness_app/core/routes/app_route.dart';
import 'package:fitness_app/features/auth/register/presentation/view/widgets/choose_age_widget.dart';
import 'package:fitness_app/features/auth/register/presentation/view/widgets/choose_gender_widget.dart';
import 'package:fitness_app/features/auth/register/presentation/view/widgets/choose_goal_widget.dart';
import 'package:fitness_app/features/auth/register/presentation/view/widgets/choose_height_widget.dart';
import 'package:fitness_app/features/auth/register/presentation/view/widgets/choose_rpal_widget.dart';
import 'package:fitness_app/features/auth/register/presentation/view/widgets/choose_weight_widget.dart';
import 'package:fitness_app/features/auth/register/presentation/view/widgets/register_body.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_events.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_states.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_temp_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}



class _RegisterPageState extends State<RegisterPage> {
  RegisterCubit registerCubit = getIt<RegisterCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (registerCubit.firstTime == true){
      registerCubit.doIntent(RegisterNextStep());
      registerCubit.firstTime = false;
    }
    registerCubit.cubitStream.listen((event) {
      switch(event){
        
        case NavigateToLoginTempEvent():
          if(mounted){
            Navigator.pushReplacementNamed(context, Routes.login);
          }
        case ShowMassageTempEvent():
          if(mounted){
           AppDialog.viewDialog(context,event.message,acceptText: AppLocale.ok.tr());
          }
        case ShowLoadingTempEvent():
          if(mounted){
            ShowDialogUtils.showLoading(context);
          }
        case HideLoadingTempEvent():
          if(mounted){
            ShowDialogUtils.hideLoading(context);
          }
      }
    },);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    registerCubit.streamController.close();
    registerCubit.emailController.dispose();
    registerCubit.firstNameController.dispose();
    registerCubit.lastNameController.dispose();
    registerCubit.passwordController.dispose();
    registerCubit.rpalController.dispose();
    registerCubit.goalController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    //var width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        title:Image.asset(AssetsIcons.fitnessicon,height: AppSize.s90,width: AppSize.s100),
        centerTitle: true,
        leading:InkWell(child: BackArrowIcon(),
          onTap: () {
              registerCubit.doIntent(RegisterPreviousStep());
            },) ,
      ),
      body: BlocProvider<RegisterCubit>(create:(context) => registerCubit,
      child: Stack(
        children: [
          Image.asset(
              AssetsImage.registerBackGround,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,
          ),
          
          
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              child: Column(
                children: [
                  
                  SizedBox(height: height * AppSize.s0_2,),
                  BlocBuilder<RegisterCubit, RegisterStates>(
                    builder: (context, state) {
                      int currentState = state.registerState?.data??0;
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(color: AppColors.primaryColor,value: currentState/6,),
                          Text("$currentState/6")
                        ],
                      );
                    },

                  ),
                  SizedBox(height: height * AppSize.s0_02,),
                  BlocBuilder<RegisterCubit, RegisterStates>(
                    builder: (context, state) {
                      if(state.registerState?.data == 0){
                        return RegisterBody(registerCubit: registerCubit,);
                      }else if(state.registerState?.data == 1){
                        return ChooseGenderWidget(registerCubit: registerCubit,);
                      }else if(state.registerState?.data == 2){
                        return ChooseAgeWidget(registerCubit: registerCubit,);
                      }else if(state.registerState?.data == 3){
                        return ChooseWeightWidget(registerCubit: registerCubit,);
                      }else if(state.registerState?.data == 4){
                        return ChooseHeightWidget(registerCubit: registerCubit,);
                      }else if(state.registerState?.data == 5){
                        return ChooseGoalWidget(registerCubit: registerCubit);
                      }else if(state.registerState?.data == 6){
                        return ChooseRpalWidget(registerCubit: registerCubit);
                      }else{
                        return Container();
                      }
                       
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
      ),
    );
  }
}
