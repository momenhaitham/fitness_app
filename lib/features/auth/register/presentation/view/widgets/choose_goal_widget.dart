import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/app_locale/app_locale.dart';
import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:fitness_app/core/resources/values_manager.dart';
import 'package:fitness_app/core/reusable_widgets/transparent_container.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

// ignore: must_be_immutable
class ChooseGoalWidget extends StatefulWidget {
  ChooseGoalWidget({super.key,required this.registerCubit});
  RegisterCubit registerCubit;
  @override
  State<ChooseGoalWidget> createState() => _ChooseGoalWidgetState();
}

class _ChooseGoalWidgetState extends State<ChooseGoalWidget> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * AppSize.s0_05,),
        Text(AppLocale.what_is_your_goal.tr(),style: Theme.of(context).textTheme.headlineLarge,),
        Text(AppLocale.this_helps_us_create_your_personalized_plan.tr(),style: Theme.of(context).textTheme.bodyLarge,),
        SizedBox(height: height * AppSize.s0_05,),
        TransparentContainer(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GroupButton( 
                options: GroupButtonOptions(),
                isRadio: true,
                controller: widget.registerCubit.goalController,
                buttonBuilder: (selected, value, context) {
                  return TransparentContainer(

                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                      child: Row(
                        children: [
                          Text(value.toString(),style: Theme.of(context).textTheme.titleLarge),
                          Spacer(),
                          Container(
                            height: height * AppSize.s0_03,
                            width: width * AppSize.s0_07,
                            decoration: BoxDecoration(
                              
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white,width: 2),
                              color: selected ? AppColors.primaryColor : null
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                onSelected: (value, index, isSelected) 
                {
                  
                  if(index == 0){
                    widget.registerCubit.goal = 'Gain Weight';
                    widget.registerCubit.goalController.selectIndex(0);
                  }else if(index == 1){
                    widget.registerCubit.goal = 'Lose Weight';
                    widget.registerCubit.goalController.selectIndex(1);
                  }else if(index == 2){
                    widget.registerCubit.goal = 'Get Fitter';
                    widget.registerCubit.goalController.selectIndex(2);
                  }else if(index == 3){
                    widget.registerCubit.goal = 'Gain More Flexible';
                    widget.registerCubit.goalController.selectIndex(3);
                  }else if(index == 4){
                    widget.registerCubit.goal = 'Learn The Basic';
                    widget.registerCubit.goalController.selectIndex(4);
                  }
                  setState(() {
                    
                  });
                },

                buttons: [
                  AppLocale.gain_weight.tr(),
                  AppLocale.lose_weight.tr(),
                  AppLocale.get_fitter.tr(),
                  AppLocale.gain_more_flexible.tr(),
                  AppLocale.learn_the_basic.tr()
                ],
              ),
              SizedBox(height: height * AppSize.s0_05,),
              Container(
                  height: height * AppSize.s0_05,
                  width: double.infinity,
                  child: Visibility(
                    visible: widget.registerCubit.goal == null? false:true ,
                    child: ElevatedButton(onPressed:() {
                      widget.registerCubit.doIntent(RegisterNextStep());
                    }, child: Text(AppLocale.next.tr(),style: Theme.of(context).textTheme.titleLarge,),
                    
                    ),
                  ),
              ),
              
            ],
          ),
        ),
      ],
    );
  }
}