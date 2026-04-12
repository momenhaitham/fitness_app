import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/app_locale/app_locale.dart';
import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:fitness_app/core/resources/values_manager.dart';
import 'package:fitness_app/core/reusable_widgets/transparent_container.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

// ignore: must_be_immutable
class ChooseHeightWidget extends StatefulWidget{
  ChooseHeightWidget({super.key,required this.registerCubit});
  RegisterCubit registerCubit;
  @override
  State<ChooseHeightWidget> createState() => _ChooseHeightWidgetState();
}

class _ChooseHeightWidgetState extends State<ChooseHeightWidget> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    //var width = MediaQuery.of(context).size.width;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocale.what_is_your_hight.tr(),style: Theme.of(context).textTheme.headlineLarge,),
        Text(AppLocale.this_helps_us_create_your_personalized_plan.tr(),style: Theme.of(context).textTheme.bodyLarge,),
        SizedBox(height: height * AppSize.s0_08,),
        TransparentContainer(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("CM",style: Theme.of(context).textTheme.bodyMedium,),
              SizedBox(height: height * AppSize.s0_02,),
              Center(
                child: NumberPicker(
                  value: int.parse(widget.registerCubit.height??"170"),
                  minValue: 140,
                  maxValue: 250,
                  selectedTextStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(color: AppColors.primaryColor),
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  itemHeight: height * 0.1,
                  step: 1,
                  axis: Axis.horizontal,
                  onChanged: (value) => setState(() {
                    widget.registerCubit.height = value.toString();
                  })
                ),
              ),
              Icon(Icons.arrow_drop_up_sharp,color: AppColors.primaryColor,size: 50,),
              Container(
                  height: height * AppSize.s0_05,
                  width: double.infinity,
                  child: ElevatedButton(onPressed:() {
                    widget.registerCubit.doIntent(RegisterNextStep());
                  }, child: Text(AppLocale.next.tr(),style: Theme.of(context).textTheme.titleLarge,
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