import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TransparentContainer extends StatelessWidget{
  Widget child;
  Color? color;
  double? height;
  double? width;
  
  TransparentContainer({super.key,required this.child,this.color = AppColors.baseWhiteColor,this.height,this.width});
  @override
  Widget build(BuildContext context) {
    return         Container(
              height: height,
              width: width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black26.withOpacity(0.250),
                borderRadius: BorderRadius.circular(25),

                gradient: LinearGradient(
                  colors: [
                    color!.withOpacity(0.70),
                    color!.withOpacity(0.50),
                    color!.withOpacity(0.50),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 60,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: child
            );
  }
}