// import 'package:flutter/material.dart';
// import 'package:fitness_app/features/home/domian/entities/work_out_model.dart';

// class CategorySectionWidget extends StatefulWidget {
//   final List<MuscleGroupModel> musclesGroup;

//   const CategorySectionWidget({super.key, required this.musclesGroup});

//   @override
//   State<CategorySectionWidget> createState() => _CategorySectionWidgetState();
// }

// class _CategorySectionWidgetState extends State<CategorySectionWidget> {
//   int _selectedIndex = 0;

//   // Map اسم الـ category لصورة 3D
//   // لو عندك assets محلية استبدل الـ URLs بمسارات Assets
//   static const Map<String, String> _categoryImages = {
//     'gym':
//         'https://cdn3d.iconscout.com/3d/premium/thumb/gym-3d-icon-download-in-png-blend-fbx-gltf-file-formats--fitness-exercise-workout-sport-pack-sports-icons-5796448.png',
//     'fitness':
//         'https://cdn3d.iconscout.com/3d/premium/thumb/fitness-3d-icon-download-in-png-blend-fbx-gltf-file-formats--sport-exercise-workout-pack-sports-icons-5796449.png',
//     'yoga':
//         'https://cdn3d.iconscout.com/3d/premium/thumb/yoga-3d-icon-download-in-png-blend-fbx-gltf-file-formats--meditation-exercise-fitness-pack-sports-icons-5796450.png',
//     'aerobics':
//         'https://cdn3d.iconscout.com/3d/premium/thumb/aerobics-3d-icon-download-in-png-blend-fbx-gltf-file-formats--exercise-fitness-sport-pack-sports-icons-5796451.png',
//     'trainer':
//         'https://cdn3d.iconscout.com/3d/premium/thumb/personal-trainer-3d-icon-download-in-png-blend-fbx-gltf-file-formats--fitness-coach-sport-pack-sports-icons-5796452.png',
//     'chest':
//         'https://cdn3d.iconscout.com/3d/premium/thumb/chest-exercise-3d-icon-download-in-png-blend-fbx-gltf-file-formats--fitness-workout-sport-pack-sports-icons-5796453.png',
//     'arm':
//         'https://cdn3d.iconscout.com/3d/premium/thumb/arm-exercise-3d-icon-download-in-png-blend-fbx-gltf-file-formats--fitness-workout-sport-pack-sports-icons-5796454.png',
//     'leg':
//         'https://cdn3d.iconscout.com/3d/premium/thumb/leg-exercise-3d-icon-download-in-png-blend-fbx-gltf-file-formats--fitness-workout-sport-pack-sports-icons-5796455.png',
//     'back':
//         'https://cdn3d.iconscout.com/3d/premium/thumb/back-exercise-3d-icon-download-in-png-blend-fbx-gltf-file-formats--fitness-workout-sport-pack-sports-icons-5796456.png',
//     'shoulder':
//         'https://cdn3d.iconscout.com/3d/premium/thumb/shoulder-exercise-3d-icon-download-in-png-blend-fbx-gltf-file-formats--fitness-workout-sport-pack-sports-icons-5796457.png',
//   };

//   // Fallback بـ index لو الاسم مش موجود في الـ map
//   static const List<String> _fallbackImages = [
//     'https://cdn3d.iconscout.com/3d/premium/thumb/gym-3d-icon-download-in-png-blend-fbx-gltf-file-formats--fitness-exercise-workout-sport-pack-sports-icons-5796448.png',
//     'https://cdn3d.iconscout.com/3d/premium/thumb/fitness-3d-icon-download-in-png-blend-fbx-gltf-file-formats--sport-exercise-workout-pack-sports-icons-5796449.png',
//     'https://cdn3d.iconscout.com/3d/premium/thumb/yoga-3d-icon-download-in-png-blend-fbx-gltf-file-formats--meditation-exercise-fitness-pack-sports-icons-5796450.png',
//     'https://cdn3d.iconscout.com/3d/premium/thumb/aerobics-3d-icon-download-in-png-blend-fbx-gltf-file-formats--exercise-fitness-sport-pack-sports-icons-5796451.png',
//     'https://cdn3d.iconscout.com/3d/premium/thumb/personal-trainer-3d-icon-download-in-png-blend-fbx-gltf-file-formats--fitness-coach-sport-pack-sports-icons-5796452.png',
//   ];

//   String _imageFor(String name, int index) {
//     final key = name.toLowerCase().trim();
//     for (final entry in _categoryImages.entries) {
//       if (key.contains(entry.key)) return entry.value;
//     }
//     return _fallbackImages[index % _fallbackImages.length];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Category',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 110,
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             itemCount: widget.musclesGroup.length,
//             separatorBuilder: (_, __) => const SizedBox(width: 10),
//             itemBuilder: (context, index) {
//               final item = widget.musclesGroup[index];
//               final isSelected = index == _selectedIndex;

//               return GestureDetector(
//                 onTap: () => setState(() => _selectedIndex = index),
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//                   width: 82,
//                   decoration: BoxDecoration(
//                     color: isSelected
//                         ? const Color(0xFF2A2A2A)
//                         : const Color(0xFF1C1C1C),
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(
//                       color: isSelected
//                           ? Colors.orange.withValues(alpha: 0.6)
//                           : Colors.white.withValues(alpha: 0.08),
//                       width: isSelected ? 1.5 : 0.8,
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: 56,
//                         height: 56,
//                         child: Image.network(
//                           _imageFor(item.name, index),
//                           fit: BoxFit.contain,
//                           loadingBuilder: (context, child, loadingProgress) {
//                             if (loadingProgress == null) return child;
//                             return Center(
//                               child: SizedBox(
//                                 width: 20,
//                                 height: 20,
//                                 child: CircularProgressIndicator(
//                                   color: Colors.orange.withValues(alpha: 0.5),
//                                   strokeWidth: 2,
//                                 ),
//                               ),
//                             );
//                           },
//                           errorBuilder: (_, __, ___) => Icon(
//                             Icons.fitness_center,
//                             color: isSelected ? Colors.orange : Colors.white38,
//                             size: 28,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 4),
//                         child: Text(
//                           item.name,
//                           style: TextStyle(
//                             color: isSelected ? Colors.white : Colors.white60,
//                             fontSize: 11,
//                             fontWeight: isSelected
//                                 ? FontWeight.w600
//                                 : FontWeight.normal,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                           textAlign: TextAlign.center,
//                           maxLines: 1,
//                         ),
//                       ),
//                     ],
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

import 'package:flutter/material.dart';
import 'package:fitness_app/features/home/domian/entities/work_out_model.dart';

class CategorySectionWidget extends StatelessWidget {
  final List<MuscleGroupModel> musclesGroup;

  const CategorySectionWidget({super.key, required this.musclesGroup});

  // Static icon mapping per category name
  static IconData _iconFor(String name) {
    final n = name.toLowerCase();
    if (n.contains('gym')) return Icons.fitness_center;
    if (n.contains('yoga')) return Icons.self_improvement;
    if (n.contains('run') || n.contains('cardio')) return Icons.directions_run;
    if (n.contains('swim')) return Icons.pool;
    if (n.contains('bike') || n.contains('cycling'))
      return Icons.directions_bike;
    return Icons.sports_gymnastics;
  }

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
        // SizedBox(
        //   height: 90,
        //   child: ListView.separated(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: musclesGroup.length,
        //     separatorBuilder: (_, _) => const SizedBox(width: 16),
        //     itemBuilder: (context, index) {
        //       final item = musclesGroup[index];
        //       return Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           Container(
        //             width: 60,
        //             height: 60,
        //             decoration: BoxDecoration(
        //               color: Colors.grey[850],
        //               borderRadius: BorderRadius.circular(16),
        //             ),
        //             child: Image.asset("assets/images/GymCategory.png")
        //           ),
        //           const SizedBox(height: 6),
        //           Text(
        //             item.name,
        //             style: const TextStyle(
        //               color: Colors.white,
        //               fontSize: 11,
        //             ),
        //             overflow: TextOverflow.ellipsis,
        //           ),
        //         ],
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
