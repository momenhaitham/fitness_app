import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class ExerciseItem extends StatelessWidget {
  String? videoId;
  String? exerciseName;
  String? exerciseDefficultyLevel;
  ExerciseItem({this.videoId, this.exerciseName, this.exerciseDefficultyLevel});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: 80,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.01),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
              clipBehavior: Clip.antiAlias,
              child: Image.network('https://img.youtube.com/vi/$videoId/0.jpg', fit: BoxFit.cover,),
            ),
          ),
          SizedBox(width: width * 0.02,),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exerciseName ?? '', style: Theme.of(context).textTheme.bodyLarge,overflow: TextOverflow.ellipsis,),
                Text(exerciseDefficultyLevel ?? '', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
          Spacer(),
          Expanded(child: Icon(Icons.play_circle, color: AppColors.primaryColor)),
        ],
      ),
    );
  }
}
