import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/features/login/domain/use_cases/login_use_case.dart';
import 'package:fitness_app/features/login/presentation/view/widgets/glass_text_field.dart';
import 'package:fitness_app/features/login/presentation/view/widgets/login_greeting.dart';
import 'package:fitness_app/features/login/presentation/view/widgets/social_button.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_cubit.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_events.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_states.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_temp_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ── Mocks ─────────────────────────────────────────────────────────────────────

class MockLoginUseCase extends Mock implements LoginUseCase {}

/// A hand-rolled mock cubit that does NOT override doIntent with `when()`.
/// Instead it exposes a callback so tests can intercept doIntent calls.
class FakeLoginCubit extends MockCubit<LoginStates> implements LoginCubit {
  @override
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  TextEditingController get emailController => _email;

  @override
  TextEditingController get passwordController => _password;

  final StreamController<LoginTempEvents> _sc =
      StreamController<LoginTempEvents>.broadcast();

  @override
  Stream<LoginTempEvents> get cubitStream => _sc.stream;

  /// Push a temp event directly into the stream.
  void pushTempEvent(LoginTempEvents e) => _sc.add(e);

  /// Track calls to [doIntent].
  final List<LoginEvents> capturedIntents = [];

  @override
  void doIntent(LoginEvents event) {
    capturedIntents.add(event);
  }

  void cleanUp() {
    _sc.close();
    _email.dispose();
    _password.dispose();
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

/// Wraps [child] inside a phone-sized surface, ScreenUtil, and MaterialApp.
// Widget _phoneWrap(Widget child, LoginCubit cubit) {
//   return ScreenUtilInit(
//     designSize: const Size(390, 844),
//     minTextAdapt: true,
//     splitScreenMode: false,
//     builder: (_, _) => MediaQuery(
//       // Enforce exactly 390x844 logical pixels and no text scaling
//       data: const MediaQueryData(
//         size: Size(390, 844),
//         devicePixelRatio: 1.0,
//         textScaler: TextScaler.noScaling,
//       ),
//       child: MaterialApp(
//         home: Scaffold(
//           body: BlocProvider<LoginCubit>.value(
//             value: cubit,
//             child: child,
//           ),
//         ),
//         routes: {
//           'homeScreen': (_) => const Scaffold(body: Text('Home')),
//           'registerScreen': (_) => const Scaffold(body: Text('Register')),
//           'forgetPasswordScreen': (_) =>
//               const Scaffold(body: Text('Forget Password')),
//         },
//       ),
//     ),
//   );
// }

// Future<void> _setPhoneSize(WidgetTester tester) async {
//   // Set physical size so logical pixels = 390x844 (pixelRatio=1.0)
//   tester.view.physicalSize = const Size(390, 844);
//   tester.view.devicePixelRatio = 1.0;
// }

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  late FakeLoginCubit fakeCubit;

  setUp(() {
    fakeCubit = FakeLoginCubit();
    when(() => fakeCubit.state).thenReturn(LoginStates());
  });

  tearDown(() {
    fakeCubit.cleanUp();
  });

  // ── GlassTextField ──────────────────────────────────────────────────────────

  group('GlassTextField widget', () {
    Widget buildField({
      required TextEditingController controller,
      String hintText = 'Email',
      IconData prefixIcon = Icons.email_outlined,
      bool obscureText = false,
      Widget? suffixIcon,
      String? Function(String?)? validator,
      GlobalKey<FormState>? formKey,
    }) {
      Widget field = GlassTextField(
        controller: controller,
        hintText: hintText,
        prefixIcon: prefixIcon,
        obscureText: obscureText,
        suffixIcon: suffixIcon,
        validator: validator,
      );
      if (formKey != null) {
        field = Form(key: formKey, child: field);
      }
      return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, _) =>
            MaterialApp(home: Scaffold(body: field)),
      );
    }

    testWidgets('renders with hint text', (tester) async {
      final ctrl = TextEditingController();
      await tester.pumpWidget(buildField(controller: ctrl, hintText: 'Email'));
      expect(find.text('Email'), findsOneWidget);
      ctrl.dispose();
    });

    testWidgets('renders prefix icon', (tester) async {
      final ctrl = TextEditingController();
      await tester.pumpWidget(
        buildField(
          controller: ctrl,
          prefixIcon: Icons.lock_outline,
          hintText: 'Password',
          obscureText: true,
        ),
      );
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
      ctrl.dispose();
    });

    testWidgets('shows validation error message when validator fails',
        (tester) async {
      final ctrl = TextEditingController();
      final key = GlobalKey<FormState>();
      await tester.pumpWidget(
        buildField(
          controller: ctrl,
          formKey: key,
          validator: (_) => 'Error message',
        ),
      );
      key.currentState!.validate();
      await tester.pump();
      expect(find.text('Error message'), findsOneWidget);
      ctrl.dispose();
    });

    testWidgets('shows no error when validator returns null', (tester) async {
      final ctrl = TextEditingController();
      final key = GlobalKey<FormState>();
      await tester.pumpWidget(
        buildField(
          controller: ctrl,
          formKey: key,
          validator: (_) => null,
        ),
      );
      key.currentState!.validate();
      await tester.pump();
      expect(find.text('Error message'), findsNothing);
      ctrl.dispose();
    });

    testWidgets('renders suffix icon when provided', (tester) async {
      final ctrl = TextEditingController();
      await tester.pumpWidget(
        buildField(
          controller: ctrl,
          suffixIcon: const Icon(Icons.visibility_outlined, key: Key('sfx')),
        ),
      );
      expect(find.byKey(const Key('sfx')), findsOneWidget);
      ctrl.dispose();
    });

    testWidgets('accepts text input into controller', (tester) async {
      final ctrl = TextEditingController();
      await tester.pumpWidget(buildField(controller: ctrl));
      await tester.enterText(find.byType(TextFormField), 'hello@test.com');
      expect(ctrl.text, 'hello@test.com');
      ctrl.dispose();
    });

    testWidgets('EditableText has obscureText=false by default', (tester) async {
      final ctrl = TextEditingController();
      await tester.pumpWidget(buildField(controller: ctrl));
      final et = tester.widget<EditableText>(find.byType(EditableText).first);
      expect(et.obscureText, isFalse);
      ctrl.dispose();
    });

    testWidgets('EditableText has obscureText=true when set', (tester) async {
      final ctrl = TextEditingController();
      await tester.pumpWidget(
          buildField(controller: ctrl, obscureText: true, hintText: 'Pwd'));
      final et = tester.widget<EditableText>(find.byType(EditableText).first);
      expect(et.obscureText, isTrue);
      ctrl.dispose();
    });
  });

  // ── SocialButton ────────────────────────────────────────────────────────────

  group('SocialButton widget', () {
    Widget buildSocial({IconData? icon, String? label, VoidCallback? onTap}) {
      return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, _) => MaterialApp(
          home: Scaffold(
            body: SocialButton(
              icon: icon,
              label: label,
              onTap: onTap ?? () {},
            ),
          ),
        ),
      );
    }

    testWidgets('renders icon when icon is provided', (tester) async {
      await tester.pumpWidget(buildSocial(icon: Icons.facebook));
      expect(find.byIcon(Icons.facebook), findsOneWidget);
    });

    testWidgets('renders label text when label is provided', (tester) async {
      await tester.pumpWidget(buildSocial(label: 'G'));
      expect(find.text('G'), findsOneWidget);
    });

    testWidgets('calls onTap callback when tapped', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
          buildSocial(icon: Icons.apple, onTap: () => tapped = true));
      await tester.tap(find.byType(GestureDetector));
      expect(tapped, isTrue);
    });

    testWidgets('has a circular decoration', (tester) async {
      await tester.pumpWidget(buildSocial(icon: Icons.facebook));
      final container =
          tester.widget<Container>(find.byType(Container).first);
      final dec = container.decoration as BoxDecoration;
      expect(dec.shape, BoxShape.circle);
    });
  });

  // ── LoginGreeting ───────────────────────────────────────────────────────────

  group('LoginGreeting widget', () {
    Widget buildGreeting() {
      return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, _) => const MaterialApp(
          home: Scaffold(body: LoginGreeting()),
        ),
      );
    }

    testWidgets('shows "Hey There" text', (tester) async {
      await tester.pumpWidget(buildGreeting());
      expect(find.text('Hey There'), findsOneWidget);
    });

    testWidgets('shows "Welcome Back!" text', (tester) async {
      await tester.pumpWidget(buildGreeting());
      expect(find.text('Welcome Back!'), findsOneWidget);
    });
  });

  // ── LoginBody ───────────────────────────────────────────────────────────────

  // group('LoginBody widget', () {
  //   // Each test gets a fresh phone-sized surface
  //   setUp(() async {});

  //   testWidgets('renders two text form fields', (tester) async {
  //     await _setPhoneSize(tester);
  //     await tester.pumpWidget(_phoneWrap(const LoginBody(), fakeCubit));
  //     await tester.pump();
  //     expect(find.byType(TextFormField), findsNWidgets(2));
  //     addTearDown(() => tester.binding.setSurfaceSize(null));
  //   });

  //   testWidgets('shows "Login" button when not loading', (tester) async {
  //     await _setPhoneSize(tester);
  //     await tester.pumpWidget(_phoneWrap(const LoginBody(), fakeCubit));
  //     await tester.pump();
  //     expect(find.text('Login'), findsOneWidget);
  //     addTearDown(() => tester.binding.setSurfaceSize(null));
  //   });

  //   testWidgets('shows CircularProgressIndicator when ShowLoadingTempEvent emitted', (
  //     tester,
  //   ) async {
  //     await _setPhoneSize(tester);
  //     await tester.pumpWidget(_phoneWrap(const LoginBody(), fakeCubit));
  //     await tester.pump();

  //     fakeCubit.pushTempEvent(ShowLoadingTempEvent());
  //     await tester.pump();

  //     expect(find.byType(CircularProgressIndicator), findsOneWidget);
  //     addTearDown(() => tester.binding.setSurfaceSize(null));
  //   });

  //   testWidgets('hides CircularProgressIndicator after HideLoadingTempEvent', (
  //     tester,
  //   ) async {
  //     await _setPhoneSize(tester);
  //     await tester.pumpWidget(_phoneWrap(const LoginBody(), fakeCubit));
  //     await tester.pump();

  //     fakeCubit.pushTempEvent(ShowLoadingTempEvent());
  //     await tester.pump();
  //     fakeCubit.pushTempEvent(HideLoadingTempEvent());
  //     await tester.pump();

  //     expect(find.byType(CircularProgressIndicator), findsNothing);
  //     addTearDown(() => tester.binding.setSurfaceSize(null));
  //   });

  //   testWidgets('shows SnackBar with message on ShowMassageTempEvent', (
  //     tester,
  //   ) async {
  //     await _setPhoneSize(tester);
  //     await tester.pumpWidget(_phoneWrap(const LoginBody(), fakeCubit));
  //     await tester.pump();

  //     fakeCubit.pushTempEvent(ShowMassageTempEvent('Login Successful'));
  //     await tester.pump();

  //     expect(find.byType(SnackBar), findsOneWidget);
  //     expect(find.text('Login Successful'), findsOneWidget);
  //     addTearDown(() => tester.binding.setSurfaceSize(null));
  //   });

  //   testWidgets('shows register prompt text', (tester) async {
  //     await _setPhoneSize(tester);
  //     await tester.pumpWidget(_phoneWrap(const LoginBody(), fakeCubit));
  //     await tester.pump();
  //     expect(find.text("Don't Have An Account Yet ? "), findsOneWidget);
  //     addTearDown(() => tester.binding.setSurfaceSize(null));
  //   });

  //   testWidgets('shows "Register" tappable text', (tester) async {
  //     await _setPhoneSize(tester);
  //     await tester.pumpWidget(_phoneWrap(const LoginBody(), fakeCubit));
  //     await tester.pump();
  //     expect(find.text('Register'), findsOneWidget);
  //     addTearDown(() => tester.binding.setSurfaceSize(null));
  //   });

  //   testWidgets('shows "Forgot Password ?" link', (tester) async {
  //     await _setPhoneSize(tester);
  //     await tester.pumpWidget(_phoneWrap(const LoginBody(), fakeCubit));
  //     await tester.pump();
  //     expect(find.text('Forgot Password ?'), findsOneWidget);
  //     addTearDown(() => tester.binding.setSurfaceSize(null));
  //   });

  //   testWidgets('shows "Or" divider text', (tester) async {
  //     await _setPhoneSize(tester);
  //     await tester.pumpWidget(_phoneWrap(const LoginBody(), fakeCubit));
  //     await tester.pump();
  //     expect(find.text('Or'), findsOneWidget);
  //     addTearDown(() => tester.binding.setSurfaceSize(null));
  //   });

  //   testWidgets('renders 3 SocialButton widgets', (tester) async {
  //     await _setPhoneSize(tester);
  //     await tester.pumpWidget(_phoneWrap(const LoginBody(), fakeCubit));
  //     await tester.pump();
  //     expect(find.byType(SocialButton), findsNWidgets(3));
  //     addTearDown(() => tester.binding.setSurfaceSize(null));
  //   });

  //   testWidgets('tapping Register calls doIntent with NavigateToRegisterEvent', (
  //     tester,
  //   ) async {
  //     await _setPhoneSize(tester);
  //     await tester.pumpWidget(_phoneWrap(const LoginBody(), fakeCubit));
  //     await tester.pump();

  //     await tester.tap(find.text('Register'));
  //     await tester.pump();

  //     expect(
  //       fakeCubit.capturedIntents.any((e) => e is NavigateToRegisterEvent),
  //       isTrue,
  //     );
  //     addTearDown(() => tester.binding.setSurfaceSize(null));
  //   });

  //   testWidgets('password visibility icon toggles between off and on', (
  //     tester,
  //   ) async {
  //     await _setPhoneSize(tester);
  //     await tester.pumpWidget(_phoneWrap(const LoginBody(), fakeCubit));
  //     await tester.pump();

  //     // Initially password is obscured → visibility_off icon
  //     expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);

  //     await tester.tap(find.byType(IconButton));
  //     await tester.pump();

  //     // After toggle → visibility icon
  //     expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
  //     addTearDown(() => tester.binding.setSurfaceSize(null));
  //   });
  // });





}
