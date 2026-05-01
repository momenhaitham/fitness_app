import 'package:flutter/material.dart';
import 'package:fitness_app/features/home/domian/entities/work_out_model.dart';

class CategorySectionWidget extends StatelessWidget {
  final List<MuscleGroupModel> musclesGroup;

  const CategorySectionWidget({super.key, required this.musclesGroup});


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Image.asset("assets/images/GymCategory.png"),
                    Text("Gym"),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 1,
                child: Container(color: Colors.blueGrey),
              ),
              Expanded(
                child: Column(
                  children: [
                    Image.asset("assets/images/fitnessCategory.png"),
                    Text("Fitness"),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 1,
                child: Container(color: Colors.blueGrey),
              ),
              Expanded(
                child: Column(
                  children: [
                    Image.asset("assets/images/YogaCategory.png"),
                    Text("Yoga"),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 1,
                child: Container(color: Colors.blueGrey),
              ),
              Expanded(
                child: Column(
                  children: [
                    Image.asset("assets/images/AerobicsCategory.png"),
                    Text("Airobics"),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 1,
                child: Container(color: Colors.blueGrey),
              ),
              Expanded(
                child: Column(
                  children: [
                    Image.asset("assets/images/TrainerCategory.png"),
                    Text("Trainner"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
