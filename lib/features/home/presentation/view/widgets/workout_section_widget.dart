import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/features/home/domian/entities/work_out_model.dart';

class WorkoutSectionWidget extends StatefulWidget {
  final List<MuscleGroupModel> musclesGroup;

  const WorkoutSectionWidget({super.key, required this.musclesGroup});

  @override
  State<WorkoutSectionWidget> createState() => _WorkoutSectionWidgetState();
}

class _WorkoutSectionWidgetState extends State<WorkoutSectionWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selected = widget.musclesGroup.isNotEmpty
        ? widget.musclesGroup[_selectedIndex]
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title + See All
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Upcoming Workouts',
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

        // Filter chips (horizontal scroll)
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.musclesGroup.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final isSelected = index == _selectedIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedIndex = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ?AppColors.primaryColor : Colors.grey[850],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.musclesGroup[index].name,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 14),

        // Workout cards (horizontal scroll)
        SizedBox(
          height: 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4, // static placeholders
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return _WorkoutCard(
                name: selected?.name ?? '',
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  final String name;
  final int index;

  const _WorkoutCard({required this.name, required this.index});

  static const List<String> _placeholderImages = [
    'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
    'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
    'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=400',
    'https://images.unsplash.com/photo-1549060279-7e168fcee0c2?w=400',
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          // Image
          SizedBox(
            width: 120,
            height: 130,
            child: Image.network(
              _placeholderImages[index % _placeholderImages.length],
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey[850],
                child: const Icon(Icons.fitness_center,
                    color: Colors.orange, size: 32),
              ),
            ),
          ),
          // Overlay
          Container(
            width: 120,
            height: 130,
            color: Colors.black.withValues(alpha: 0.4),
          ),
          // Label
          Positioned(
            bottom: 10,
            left: 8,
            right: 8,
            child: Text(
              name.isNotEmpty ? name : 'Workout',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


















// import 'package:flutter/material.dart';
// import 'package:fitness_app/features/home/domian/entities/work_out_model.dart';

// class WorkoutSectionWidget extends StatelessWidget {
//   final List<MuscleGroupModel> musclesGroup;

//   const WorkoutSectionWidget({super.key, required this.musclesGroup});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Text(
//             'Upcoming Workouts',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         const SizedBox(height: 12),
//         ListView.separated(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           scrollDirection: Axis.horizontal,
//           itemCount: musclesGroup.length,
//           separatorBuilder: (_, _) => const SizedBox(width: 16),
//           itemBuilder: (context, index) {
//             final item = musclesGroup[index];
//             return Column(
//               children: [
//                 Container(
//                   width: 56,
//                   height: 56,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[850],
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: const Icon(
//                     Icons.fitness_center,
//                     color: Colors.orange,
//                     size: 28,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   item.name,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }
// }