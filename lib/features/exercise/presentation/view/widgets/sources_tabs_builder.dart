import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SourcesTabsBuilder extends StatelessWidget {
  String txt;
  bool isSelected;
  

  SourcesTabsBuilder({
    required this.txt,
    required this.isSelected,
    
  });


  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color:isSelected?AppColors.primaryColor: AppColors.transparentColor,
    ),
    child: Center(child: Text(txt,style: Theme.of(context).textTheme.headlineLarge,),),
    );
  }
}
