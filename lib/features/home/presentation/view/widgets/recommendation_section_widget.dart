import 'package:flutter/material.dart';
import 'package:fitness_app/features/home/domian/entities/recommendation_model.dart';

class RecommendationSectionWidget extends StatelessWidget {
  final List<MuscleModel> muscles;

  const RecommendationSectionWidget({super.key, required this.muscles});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recommendation To Day',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: muscles.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final muscle = muscles[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // Background image or fallback color
                    Container(
                      width: 130,
                      height: 140,
                      color: Colors.grey[850],
                      child: muscle.image != null
                          ? Image.network(
                              muscle.image!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.fitness_center,
                                color: Colors.orange,
                                size: 36,
                              ),
                            )
                          : const Center(
                              child: Icon(
                                Icons.fitness_center,
                                color: Colors.orange,
                                size: 36,
                              ),
                            ),
                    ),
                    // Dark overlay
                    if (muscle.image != null)
                      Container(
                        width: 130,
                        height: 140,
                        color: Colors.black.withValues(alpha: 0.35),
                      ),
                    // Label at bottom
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Text(
                        muscle.name,
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
// import 'package:fitness_app/features/home/domian/entities/recommendation_model.dart';

// class RecommendationSectionWidget extends StatelessWidget {
//   final List<MuscleModel> muscles;

//   const RecommendationSectionWidget({super.key, required this.muscles});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Text(
//             'Recommendation To Day',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 140,
//           child: ListView.separated(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             scrollDirection: Axis.horizontal,
//             itemCount: muscles.length,
//             separatorBuilder: (_, __) => const SizedBox(width: 12),
//             itemBuilder: (context, index) {
//               final muscle = muscles[index];
//               return Container(
//                 width: 130,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   image: muscle.image != null
//                       ? DecorationImage(
//                           image: NetworkImage(muscle.image!),
//                           fit: BoxFit.cover,
//                           colorFilter: ColorFilter.mode(
//                             Colors.black.withOpacity(0.35),
//                             BlendMode.darken,
//                           ),
//                         )
//                       : null,
//                   color: Colors.grey[850],
//                 ),
//                 alignment: Alignment.bottomLeft,
//                 padding: const EdgeInsets.all(10),
//                 child: Text(
//                   muscle.name,
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