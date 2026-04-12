import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/app_locale/app_locale.dart';
import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:fitness_app/core/resources/values_manager.dart';
import 'package:fitness_app/core/reusable_widgets/transparent_container.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChooseGenderWidget extends StatefulWidget{

  ChooseGenderWidget({super.key,required this.registerCubit});
  RegisterCubit registerCubit;

  @override
  State<ChooseGenderWidget> createState() => _ChooseGenderWidgetState();
}

class _ChooseGenderWidgetState extends State<ChooseGenderWidget> {
  bool? male = false;

  bool? feMale = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    
    if(widget.registerCubit.gender == 'male'){
      male = true;
      feMale = false;
    }else if(widget.registerCubit.gender == 'female'){
      male = false;
      feMale = true;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocale.tell_us_about_yourself.tr(),style: Theme.of(context).textTheme.headlineLarge,),
        Text(AppLocale.we_need_to_know_your_gender.tr(),style: Theme.of(context).textTheme.bodyLarge,),
        SizedBox(height: height * AppSize.s0_02,),
        TransparentContainer(
          width: double.infinity,
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  feMale = false;
                  male = true;
                  widget.registerCubit.gender = 'male';
                  setState(() {
                    
                  });
                },
                child: Container(
                  //height: height * 0.2,
                  //width: width * 0.45,
                  padding: EdgeInsets.symmetric(horizontal: 50,vertical: 35),
                  decoration: BoxDecoration(
                    color: male == true ? AppColors.primaryColor : null,
                    border: Border.all(color: Colors.white,width: 2),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.male_outlined,color: Colors.white,size: 100, ),
                      Text(AppLocale.male.tr(),style: Theme.of(context).textTheme.headlineLarge,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * AppSize.s0_02,),
              InkWell(
                onTap: (){
                  feMale = true;
                  male = false;
                  widget.registerCubit.gender = 'female';
                  setState(() {
                    
                  });
                },
                child: Container(
                  //height: height * 0.2,
                  //width: width * 0.45,
                  padding: EdgeInsets.symmetric(horizontal: 50,vertical: 35),
                  decoration: BoxDecoration(
                    color: feMale == true ? AppColors.primaryColor : null,
                    border: Border.all(color: Colors.white,width: 2),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.female_outlined,color: Colors.white,size: 100, ),
                      Text(AppLocale.female.tr(),style: Theme.of(context).textTheme.headlineLarge,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * AppSize.s0_02,),
              Container(
                  height: height * AppSize.s0_05,
                  width: double.infinity,
                  child: Visibility(
                    visible:  male==false && feMale==false? false:true ,
                    child: ElevatedButton(onPressed:() {
                      
                      widget.registerCubit.doIntent(RegisterNextStep());
                    }, child: Text(AppLocale.next.tr(),style: Theme.of(context).textTheme.titleLarge,
                    ),
                    
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