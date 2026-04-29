import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/config/base_state/custom_cubit.dart';
import 'package:fitness_app/features/auth/register/domain/entities/register_model.dart';
import 'package:fitness_app/features/auth/register/domain/use_cases/register_usecase.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_events.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_states.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_temp_events.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends CustomCubit<RegisterTempEvents, RegisterStates>{
    RegisterCubit(this._registerUsecase) : super(RegisterStates());
    bool firstTime = true;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    RegisterUsecase _registerUsecase;
    GroupButtonController goalController = GroupButtonController();
    GroupButtonController rpalController = GroupButtonController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    String? gender;
    String? age;
    String? weight;
    String? height;
    String? goal;
    String? physicalActivityLevel;

    void doIntent(RegisterEvents event){
        switch(event){

          case Register():
            _register();
          case RegisterNextStep():
            _nextStep();
          case RegisterPreviousStep():
            _previousStep();
          case NavigateToLoginEvent():
            _navigateToLogin();
          case ShowMassageEvent():
            _showMassage(event.massage);
          case ShowLoadingEvent():
            _ShowLoading();
          case HideLoadingEvent():
            _HideLoading();
        }
    }

    void _register()async{
        doIntent(ShowLoadingEvent());
        var response = await _registerUsecase.invoke({
            "firstName":firstNameController.text,
            "lastName":lastNameController.text,
            "email":emailController.text,
            "password":passwordController.text,
            "rePassword":passwordController.text,
            "gender":gender,
            "height":height,
            "weight":weight,
            "age":age,
            "goal":goal,
            "activityLevel":physicalActivityLevel
        });
        switch(response){

          case SuccessResponse<RegisterModel>():
            doIntent(HideLoadingEvent());
            doIntent(ShowMassageEvent(response.data.massage??''));
            Future.delayed(const Duration(seconds: 2),() => streamController.add(NavigateToLoginTempEvent()));
            emit(state);
          case ErrorResponse<RegisterModel>():
            doIntent(HideLoadingEvent());
            doIntent(ShowMassageEvent(response.error.toString()));
            emit(state);
        }
    }
    
    void _nextStep(){
        if(state.registerState?.data == null){
          state.registerState = BaseState(data: 0);
          emit(state);
          return;
        }
        int? currentStep = state.registerState!.data;
        currentStep = currentStep! + 1;
        emit(state.copyWith(newRegisterState: BaseState(data: currentStep)));
    
    }

    void _previousStep(){
        if(state.registerState?.data == 0){
            streamController.add(NavigateToLoginTempEvent());
            emit(state);
            return;
        }
        int? currentStep = state.registerState!.data;
        currentStep = currentStep! - 1;
        emit(state.copyWith(newRegisterState: BaseState(data: currentStep)));
    }

    void _navigateToLogin(){
        streamController.add(NavigateToLoginTempEvent());
        emit(state);
    }

    void _showMassage(String massage){
        streamController.add(ShowMassageTempEvent(massage));
        emit(state);
    }

    void _ShowLoading(){
      streamController.add(ShowLoadingTempEvent());
    }

    void _HideLoading(){
      streamController.add(HideLoadingTempEvent());
    }
}