import 'dart:async';

import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/auth/register/presentation/view/widgets/choose_age_widget.dart';
import 'package:fitness_app/features/auth/register/presentation/view/widgets/choose_gender_widget.dart';
import 'package:fitness_app/features/auth/register/presentation/view/widgets/choose_goal_widget.dart';
import 'package:fitness_app/features/auth/register/presentation/view/widgets/choose_height_widget.dart';
import 'package:fitness_app/features/auth/register/presentation/view/widgets/choose_rpal_widget.dart';
import 'package:fitness_app/features/auth/register/presentation/view/widgets/choose_weight_widget.dart';
import 'package:fitness_app/features/auth/register/presentation/view/widgets/register_body.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_events.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_states.dart';
import 'package:fitness_app/features/auth/register/presentation/view_model/cubit/register_temp_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:group_button/group_button.dart';
import 'package:numberpicker/numberpicker.dart';

// ---------------------------------------------------------------------------
// Fake cubit — replaces real one so no use-case / DI setup needed
// ---------------------------------------------------------------------------

class FakeRegisterCubit extends Cubit<RegisterStates> implements RegisterCubit {
  FakeRegisterCubit()
      : super(RegisterStates(registerState: BaseState(data: 0)));

  // ---- temp-event stream --------------------------------------------------
  final StreamController<RegisterTempEvents> _streamController =
      StreamController<RegisterTempEvents>.broadcast();

  @override
  StreamController<RegisterTempEvents> get streamController => _streamController;

  @override
  Stream<RegisterTempEvents> get cubitStream => _streamController.stream;

  // ---- flags / controllers ------------------------------------------------
  @override
  bool firstTime = false;

  @override
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  final GroupButtonController goalController = GroupButtonController();

  @override
  final GroupButtonController rpalController = GroupButtonController();

  @override
  final TextEditingController firstNameController = TextEditingController();

  @override
  final TextEditingController lastNameController = TextEditingController();

  @override
  final TextEditingController emailController = TextEditingController();

  @override
  final TextEditingController passwordController = TextEditingController();

  // ---- user data fields ---------------------------------------------------
  @override
  String? gender;

  @override
  String? age = '20';

  @override
  String? weight = '70';

  @override
  String? height = '170';

  @override
  String? goal;

  @override
  String? physicalActivityLevel;

  // ---- intent handler -----------------------------------------------------
  @override
  void doIntent(RegisterEvents event) {
    switch (event) {
      case RegisterNextStep():
        final current = state.registerState?.data ?? 0;
        emit(state.copyWith(newRegisterState: BaseState(data: current + 1)));

      case RegisterPreviousStep():
        final current = state.registerState?.data ?? 0;
        if (current == 0) {
          _streamController.add(NavigateToLoginTempEvent());
        } else {
          emit(
            state.copyWith(newRegisterState: BaseState(data: current - 1)),
          );
        }

      case NavigateToLoginEvent():
        _streamController.add(NavigateToLoginTempEvent());

      case ShowMassageEvent():
        _streamController.add(ShowMassageTempEvent(event.massage));

      case ShowLoadingEvent():
        _streamController.add(ShowLoadingTempEvent());

      case HideLoadingEvent():
        _streamController.add(HideLoadingTempEvent());

      case Register():
        _streamController.add(ShowLoadingTempEvent());
    }
  }

  @override
  Future<void> close() {
    _streamController.close();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
  
  @override
  set emailController(TextEditingController value) {
    // TODO: implement emailController
  }
  
  @override
  set firstNameController(TextEditingController value) {
    // TODO: implement firstNameController
  }
  
  @override
  set goalController(GroupButtonController value) {
    // TODO: implement goalController
  }
  
  @override
  set lastNameController(TextEditingController value) {
    // TODO: implement lastNameController
  }
  
  @override
  set passwordController(TextEditingController value) {
    // TODO: implement passwordController
  }
  
  @override
  set rpalController(GroupButtonController value) {
    // TODO: implement rpalController
  }
  
  @override
  set streamController(StreamController<RegisterTempEvents> value) {
    // TODO: implement streamController
  }
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// Wraps a widget with the minimum scaffold needed for widget tests:
/// MaterialApp (for theming + navigation) and BlocProvider.
Widget buildTestWidget(Widget child, FakeRegisterCubit cubit) {
  return MaterialApp(
    home: BlocProvider<RegisterCubit>.value(
      value: cubit,
      child: Scaffold(body: SingleChildScrollView(child: child)),
    ),
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  late FakeRegisterCubit cubit;

  setUp(() {
    cubit = FakeRegisterCubit();
  });

  tearDown(() {
    cubit.close();
  });

  // =========================================================================
  // Cubit — Step navigation logic
  // =========================================================================

  group('RegisterCubit – step navigation', () {
    test('initial state is step 0', () {
      expect(cubit.state.registerState?.data, 0);
    });

    test('RegisterNextStep increments step by 1', () {
      cubit.doIntent(RegisterNextStep());
      expect(cubit.state.registerState?.data, 1);
    });

    test('calling RegisterNextStep multiple times reaches step 6', () {
      for (int i = 0; i < 6; i++) {
        cubit.doIntent(RegisterNextStep());
      }
      expect(cubit.state.registerState?.data, 6);
    });

    test('RegisterPreviousStep decrements step by 1', () {
      cubit.doIntent(RegisterNextStep()); // → step 1
      cubit.doIntent(RegisterPreviousStep()); // → step 0
      expect(cubit.state.registerState?.data, 0);
    });

    test('RegisterPreviousStep at step 0 emits NavigateToLoginTempEvent', () async {
      expect(
        cubit.cubitStream,
        emits(isA<NavigateToLoginTempEvent>()),
      );
      cubit.doIntent(RegisterPreviousStep());
    });

    test('NavigateToLoginEvent adds NavigateToLoginTempEvent to stream', () async {
      expect(
        cubit.cubitStream,
        emits(isA<NavigateToLoginTempEvent>()),
      );
      cubit.doIntent(NavigateToLoginEvent());
    });

    test('ShowLoadingEvent adds ShowLoadingTempEvent to stream', () async {
      expect(
        cubit.cubitStream,
        emits(isA<ShowLoadingTempEvent>()),
      );
      cubit.doIntent(ShowLoadingEvent());
    });

    test('HideLoadingEvent adds HideLoadingTempEvent to stream', () async {
      expect(
        cubit.cubitStream,
        emits(isA<HideLoadingTempEvent>()),
      );
      cubit.doIntent(HideLoadingEvent());
    });

    test('ShowMassageEvent adds ShowMassageTempEvent with correct message', () async {
      const message = 'Test message';
      expect(
        cubit.cubitStream,
        emits(
          isA<ShowMassageTempEvent>()
              .having((e) => e.message, 'message', message),
        ),
      );
      cubit.doIntent(ShowMassageEvent(message));
    });
  });

  // =========================================================================
  // Step 0 — RegisterBody
  // =========================================================================

  group('Step 0 – RegisterBody', () {
    testWidgets('renders all four text fields', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(RegisterBody(registerCubit: cubit), cubit),
      );

      // Four TextFormField widgets must be present
      expect(find.byType(TextFormField), findsNWidgets(4));
    });

    testWidgets('renders a submit ElevatedButton', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(RegisterBody(registerCubit: cubit), cubit),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('does NOT advance to step 1 when form is empty and button tapped',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(RegisterBody(registerCubit: cubit), cubit),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // State must still be step 0
      expect(cubit.state.registerState?.data, 0);
    });

    testWidgets('advances to step 1 when all fields are valid', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(RegisterBody(registerCubit: cubit), cubit),
      );

      await tester.enterText(
          find.byType(TextFormField).at(0), 'John'); // first name
      await tester.enterText(
          find.byType(TextFormField).at(1), 'Doe'); // last name
      await tester.enterText(
          find.byType(TextFormField).at(2), 'john@email.com'); // email
      await tester.enterText(
          find.byType(TextFormField).at(3), 'Password@123'); // password

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(cubit.state.registerState?.data, 1);
    });

    testWidgets('saves entered text into cubit controllers', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(RegisterBody(registerCubit: cubit), cubit),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'Jane');
      await tester.enterText(find.byType(TextFormField).at(1), 'Smith');
      await tester.enterText(
          find.byType(TextFormField).at(2), 'jane@test.com');
      await tester.enterText(find.byType(TextFormField).at(3), 'Pass@9999');

      expect(cubit.firstNameController.text, 'Jane');
      expect(cubit.lastNameController.text, 'Smith');
      expect(cubit.emailController.text, 'jane@test.com');
      expect(cubit.passwordController.text, 'Pass@9999');
    });
  });

  // =========================================================================
  // Step 1 — ChooseGenderWidget
  // =========================================================================

  group('Step 1 – ChooseGenderWidget', () {
    testWidgets('renders male and female icons', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(ChooseGenderWidget(registerCubit: cubit), cubit),
      );

      expect(find.byIcon(Icons.male_outlined), findsOneWidget);
      expect(find.byIcon(Icons.female_outlined), findsOneWidget);
    });

    testWidgets('next button is hidden before any gender is selected',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(ChooseGenderWidget(registerCubit: cubit), cubit),
      );

      // The Visibility wrapping ElevatedButton should be invisible
      
      expect(find.byWidgetPredicate((widget) { 
      return widget is Visibility && widget.visible == false && widget.child is ElevatedButton;
      },),findsNWidgets(1));

    });

    testWidgets('selecting male sets cubit.gender and shows next button',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(ChooseGenderWidget(registerCubit: cubit), cubit),
      );

      // Tap the male InkWell (first one)
      await tester.tap(find.byType(InkWell).first);
      await tester.pump();

      expect(cubit.gender, 'male');

      final visibility = tester.widget<Visibility>(
        find.ancestor(
          of: find.byType(ElevatedButton),
          matching: find.byType(Visibility),
        ),
      );
      expect(visibility.visible, isTrue);
    });

    testWidgets('selecting female sets cubit.gender correctly', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(ChooseGenderWidget(registerCubit: cubit), cubit),
      );

      await tester.tap(find.byType(InkWell).last);
      await tester.pump();

      expect(cubit.gender, 'female');
    });

    testWidgets('tapping next after gender selection advances to step 2',
        (tester) async {
      cubit.gender = 'male';
      await tester.pumpWidget(
        buildTestWidget(ChooseGenderWidget(registerCubit: cubit), cubit),
      );

      await tester.tap(find.byType(InkWell).first);
      await tester.pump();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(cubit.state.registerState?.data, 1);
    });
  });

  // =========================================================================
  // Step 2 — ChooseAgeWidget
  // =========================================================================

  group('Step 2 – ChooseAgeWidget', () {
    testWidgets('renders a NumberPicker and a Next button', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(ChooseAgeWidget(registerCubit: cubit), cubit),
      );

      expect(find.byType(NumberPicker), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('next button is always visible (age has a default)', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(ChooseAgeWidget(registerCubit: cubit), cubit),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('tapping next advances step by 1', (tester) async {
      final initialStep = cubit.state.registerState?.data ?? 0;
      await tester.pumpWidget(
        buildTestWidget(ChooseAgeWidget(registerCubit: cubit), cubit),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(cubit.state.registerState?.data, initialStep + 1);
    });

    testWidgets('cubit.age defaults to 20 when not set', (tester) async {
      cubit.age = null;
      await tester.pumpWidget(
        buildTestWidget(ChooseAgeWidget(registerCubit: cubit), cubit),
      );
      // Widget should build without throwing (fallback "20" is used)
      expect(find.byType(NumberPicker), findsOneWidget);
    });
  });

  // =========================================================================
  // Step 3 — ChooseWeightWidget
  // =========================================================================

  group('Step 3 – ChooseWeightWidget', () {
    testWidgets('renders a NumberPicker and Kg label', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(ChooseWeightWidget(registerCubit: cubit), cubit),
      );

      expect(find.byType(NumberPicker), findsOneWidget);
      expect(find.text('Kg'), findsOneWidget);
    });

    testWidgets('next button is always visible (weight has a default)',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(ChooseWeightWidget(registerCubit: cubit), cubit),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('tapping next advances step by 1', (tester) async {
      final initialStep = cubit.state.registerState?.data ?? 0;
      await tester.pumpWidget(
        buildTestWidget(ChooseWeightWidget(registerCubit: cubit), cubit),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(cubit.state.registerState?.data, initialStep + 1);
    });

    testWidgets('cubit.weight defaults to 70 when not set', (tester) async {
      cubit.weight = null;
      await tester.pumpWidget(
        buildTestWidget(ChooseWeightWidget(registerCubit: cubit), cubit),
      );
      expect(find.byType(NumberPicker), findsOneWidget);
    });
  });

  // =========================================================================
  // Step 4 — ChooseHeightWidget
  // =========================================================================

  group('Step 4 – ChooseHeightWidget', () {
    testWidgets('renders a NumberPicker and CM label', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(ChooseHeightWidget(registerCubit: cubit), cubit),
      );

      expect(find.byType(NumberPicker), findsOneWidget);
      expect(find.text('CM'), findsOneWidget);
    });

    testWidgets('next button is always visible (height has a default)',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(ChooseHeightWidget(registerCubit: cubit), cubit),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('tapping next advances step by 1', (tester) async {
      final initialStep = cubit.state.registerState?.data ?? 0;
      await tester.pumpWidget(
        buildTestWidget(ChooseHeightWidget(registerCubit: cubit), cubit),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(cubit.state.registerState?.data, initialStep + 1);
    });

    testWidgets('cubit.height defaults to 170 when not set', (tester) async {
      cubit.height = null;
      await tester.pumpWidget(
        buildTestWidget(ChooseHeightWidget(registerCubit: cubit), cubit),
      );
      expect(find.byType(NumberPicker), findsOneWidget);
    });
  });

  // =========================================================================
  // Step 5 — ChooseGoalWidget
  // =========================================================================

  group('Step 5 – ChooseGoalWidget', () {
    testWidgets('renders GroupButton with 5 goal options', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(ChooseGoalWidget(registerCubit: cubit), cubit),
      );

      expect(find.byWidgetPredicate((widget) {
        return widget is GroupButton;
      },), findsOneWidget);
    });

    testWidgets('next button is hidden before any goal is selected',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(ChooseGoalWidget(registerCubit: cubit), cubit),
      );

      expect(find.byWidgetPredicate((widget) { 
      return widget is Visibility && widget.visible == false && widget.child is ElevatedButton;
      },),findsNWidgets(1));
    });

    testWidgets('next button appears after a goal is set on the cubit',
        (tester) async {
      cubit.goal = 'Lose Weight';
      await tester.pumpWidget(
        buildTestWidget(ChooseGoalWidget(registerCubit: cubit), cubit),
      );

      final visibility = tester.widget<Visibility>(
        find.ancestor(
          of: find.byType(ElevatedButton),
          matching: find.byType(Visibility),
        ),
      );
      expect(visibility.visible, isTrue);
    });

    testWidgets('tapping next when goal is set advances step', (tester) async {
      cubit.goal = 'Get Fitter';
      final initialStep = cubit.state.registerState?.data ?? 0;
      await tester.pumpWidget(
        buildTestWidget(ChooseGoalWidget(registerCubit: cubit), cubit),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(cubit.state.registerState?.data, initialStep + 1);
    });
  });

  // =========================================================================
  // Step 6 — ChooseRpalWidget (Physical Activity Level)
  // =========================================================================

  group('Step 6 – ChooseRpalWidget', () {
    testWidgets('renders GroupButton for activity levels', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(ChooseRpalWidget(registerCubit: cubit), cubit),
      );

      expect(find.byWidgetPredicate((widget) {
        return widget is GroupButton;
      },), findsOneWidget);
    });

    testWidgets('next button is hidden before any level is selected',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(ChooseRpalWidget(registerCubit: cubit), cubit),
      );

      expect(find.byWidgetPredicate((widget) { 
      return widget is Visibility && widget.visible == false && widget.child is ElevatedButton;
      },),findsNWidgets(1));
    });

    testWidgets('next button appears after physicalActivityLevel is set',
        (tester) async {
      cubit.physicalActivityLevel = 'level1';
      await tester.pumpWidget(
        buildTestWidget(ChooseRpalWidget(registerCubit: cubit), cubit),
      );

      final visibility = tester.widget<Visibility>(
        find.ancestor(
          of: find.byType(ElevatedButton),
          matching: find.byType(Visibility),
        ),
      );
      expect(visibility.visible, isTrue);
    });

    testWidgets('tapping next emits ShowLoadingTempEvent (triggers Register)',
        (tester) async {
      cubit.physicalActivityLevel = 'level3';
      await tester.pumpWidget(
        buildTestWidget(ChooseRpalWidget(registerCubit: cubit), cubit),
      );

      expectLater(
        cubit.cubitStream,
        emits(isA<ShowLoadingTempEvent>()),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
    });
  });

  // =========================================================================
  // Full flow — state machine integration
  // =========================================================================

  group('Full registration flow – step machine', () {
    test('goes from step 0 all the way to step 6 via RegisterNextStep', () {
      for (int step = 0; step < 6; step++) {
        cubit.doIntent(RegisterNextStep());
        expect(cubit.state.registerState?.data, step + 1);
      }
    });

    test('can navigate forward then backward correctly', () {
      cubit.doIntent(RegisterNextStep()); // → 1
      cubit.doIntent(RegisterNextStep()); // → 2
      cubit.doIntent(RegisterNextStep()); // → 3
      cubit.doIntent(RegisterPreviousStep()); // → 2
      cubit.doIntent(RegisterPreviousStep()); // → 1

      expect(cubit.state.registerState?.data, 1);
    });

    test('back from step 0 fires NavigateToLoginTempEvent', () async {
      expect(
        cubit.cubitStream,
        emits(isA<NavigateToLoginTempEvent>()),
      );
      cubit.doIntent(RegisterPreviousStep());
    });
  });
}
