import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/features/home/domian/entities/food_for_you_model.dart';

class FoodSectionWidget extends StatelessWidget {
  final List<CategoryModel> categories;

  const FoodSectionWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recommendation For You',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
         Text(
  'See All',
  style: TextStyle(
    color: AppColors.primaryColor,
    fontSize: 14,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.primaryColor,
    decorationThickness: 2,
  ),
),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final category = categories[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    SizedBox(
                      width: 130,
                      height: 140,
                      child: Image.network(
                        category.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey[850],
                          child: const Icon(Icons.restaurant,
                              color: Colors.orange, size: 32),
                        ),
                      ),
                    ),
                    Container(
                      width: 130,
                      height: 140,
                      color: Colors.black.withValues(alpha: 0.35),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Text(
                        category.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}














// import 'package:flutter/material.dart';
// import 'package:fitness_app/features/home/domian/entities/food_for_you_model.dart';

// class FoodSectionWidget extends StatelessWidget {
//   final List<CategoryModel> categories;

//   const FoodSectionWidget({super.key, required this.categories});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Food For You',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 'See All',
//                 style: TextStyle(
//                   color: Colors.orange[400],
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 140,
//           child: ListView.separated(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             scrollDirection: Axis.horizontal,
//             itemCount: categories.length,
//             separatorBuilder: (_, __) => const SizedBox(width: 12),
//             itemBuilder: (context, index) {
//               final category = categories[index];
//               return Container(
//                 width: 130,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   image: DecorationImage(
//                     image: NetworkImage(category.imageUrl),
//                     fit: BoxFit.cover,
//                     colorFilter: ColorFilter.mode(
//                       Colors.black.withOpacity(0.35),
//                       BlendMode.darken,
//                     ),
//                   ),
//                 ),
//                 alignment: Alignment.bottomLeft,
//                 padding: const EdgeInsets.all(10),
//                 child: Text(
//                   category.name,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }