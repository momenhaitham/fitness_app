import 'package:fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/widgets.dart';
import 'package:mockito/annotations.dart';

import 'app_sections_cubit_test.mocks.dart';

// Manual mock

@GenerateMocks([PageController])
void main() {
  late AppSectionsCubit cubit;
  late MockPageController mockPageController;

  setUp(() {
    mockPageController = MockPageController();
    cubit = AppSectionsCubit(
      pageController: mockPageController,
    ); // Dispose the original controller
  });

  test('setCurrentIndex updates state and jumps page', () {
    const index = 2;

    when(mockPageController.hasClients).thenAnswer((_) => true);

    cubit.setCurrentIndex(index);

    expect(cubit.state.currentIndex, index);
    verify(mockPageController.jumpToPage(index)).called(1);
  });

  test('setCurrentIndex does not jump if no clients', () {
    const index = 1;

    when(mockPageController.hasClients).thenAnswer((_) => false);

    cubit.setCurrentIndex(index);

    expect(cubit.state.currentIndex, index);
    verifyNever(mockPageController.jumpToPage(index));
  });
}
