import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/login/domain/entities/user_entity.dart';
import 'package:fitness_app/features/login/domain/use_cases/login_use_case.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_cubit.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_events.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_states.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_temp_events.dart';
import 'package:fitness_app/config/base_error/custom_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ── Mocks ─────────────────────────────────────────────────────────────────────

class MockLoginUseCase extends Mock implements LoginUseCase {}

// ── Helpers ───────────────────────────────────────────────────────────────────

UserEntity _fakeUser() => UserEntity(
      id: 'u1',
      firstName: 'Ahmed',
      lastName: 'Ali',
      email: 'ahmed@test.com',
    );

void main() {
  late MockLoginUseCase mockUseCase;
  late LoginCubit cubit;

  setUp(() {
    mockUseCase = MockLoginUseCase();
    cubit = LoginCubit(mockUseCase);
  });

  tearDown(() => cubit.close());

  // ── Initial state ─────────────────────────────────────────────────────────

  group('LoginCubit - initial state', () {
    test('has correct initial state', () {
      expect(cubit.state, isA<LoginStates>());
      // loginState is non-null but data is null (initial empty state)
      expect(cubit.state.loginState?.data, isNull);
      expect(cubit.state.loginState?.error, isNull);
    });

    test('emailController is initially empty', () {
      expect(cubit.emailController.text, isEmpty);
    });

    test('passwordController is initially empty', () {
      expect(cubit.passwordController.text, isEmpty);
    });
  });

  // ── Login success ─────────────────────────────────────────────────────────

  group('LoginCubit - doIntent(Login) success', () {
    setUp(() {
      cubit.emailController.text = 'ahmed@test.com';
      cubit.passwordController.text = 'Pass@1234';
      when(() => mockUseCase(any(), any())).thenAnswer(
        (_) async => SuccessResponse(data: _fakeUser()),
      );
    });

    blocTest<LoginCubit, LoginStates>(
      'emits state with user data on successful login',
      build: () {
        final uc = MockLoginUseCase();
        when(() => uc(any(), any())).thenAnswer(
          (_) async => SuccessResponse(data: _fakeUser()),
        );
        final c = LoginCubit(uc);
        c.emailController.text = 'ahmed@test.com';
        c.passwordController.text = 'Pass@1234';
        return c;
      },
      act: (c) => c.doIntent(Login()),
      wait: const Duration(milliseconds: 200),
      // The cubit emits twice: once via emit(state) during loading events,
      // and once at the end with the user data.
      expect: () => [
        isA<LoginStates>(), // intermediate emit
        isA<LoginStates>().having(
          (s) => s.loginState?.data,
          'data',
          isA<UserEntity>(),
        ),
      ],
    );

    test('sends ShowLoadingTempEvent before the API call', () async {
      final events = <LoginTempEvents>[];
      final sub = cubit.cubitStream.listen(events.add);

      cubit.doIntent(Login());
      await Future.delayed(const Duration(milliseconds: 200));

      expect(events.any((e) => e is ShowLoadingTempEvent), isTrue);
      await sub.cancel();
    });

    test('sends HideLoadingTempEvent after the API call', () async {
      final events = <LoginTempEvents>[];
      final sub = cubit.cubitStream.listen(events.add);

      cubit.doIntent(Login());
      await Future.delayed(const Duration(milliseconds: 200));

      expect(events.any((e) => e is HideLoadingTempEvent), isTrue);
      await sub.cancel();
    });

    test('sends ShowMassageTempEvent("Login Successful") after success', () async {
      final events = <LoginTempEvents>[];
      final sub = cubit.cubitStream.listen(events.add);

      cubit.doIntent(Login());
      await Future.delayed(const Duration(milliseconds: 200));

      final massageEvents = events.whereType<ShowMassageTempEvent>().toList();
      expect(massageEvents.any((e) => e.massage == 'Login Successful'), isTrue);
      await sub.cancel();
    });
  });

  // ── Login failure ─────────────────────────────────────────────────────────

  group('LoginCubit - doIntent(Login) failure', () {
    setUp(() {
      cubit.emailController.text = 'ahmed@test.com';
      cubit.passwordController.text = 'wrongpass';
      when(() => mockUseCase(any(), any())).thenAnswer(
        (_) async => ErrorResponse<UserEntity>(error: ServerError(message: 'Unauthorized')),
      );
    });

    test('sends ShowMassageTempEvent with error on failure', () async {
      final events = <LoginTempEvents>[];
      final sub = cubit.cubitStream.listen(events.add);

      cubit.doIntent(Login());
      await Future.delayed(const Duration(milliseconds: 200));

      final massageEvents = events.whereType<ShowMassageTempEvent>().toList();
      expect(massageEvents, isNotEmpty);
      await sub.cancel();
    });

    test('sends HideLoadingTempEvent after failure', () async {
      final events = <LoginTempEvents>[];
      final sub = cubit.cubitStream.listen(events.add);

      cubit.doIntent(Login());
      await Future.delayed(const Duration(milliseconds: 200));

      expect(events.any((e) => e is HideLoadingTempEvent), isTrue);
      await sub.cancel();
    });
  });

  // ── NavigateToRegisterEvent ───────────────────────────────────────────────

  group('LoginCubit - doIntent(NavigateToRegisterEvent)', () {
    test('sends NavigateToRegisterTempEvent to stream', () async {
      final events = <LoginTempEvents>[];
      final sub = cubit.cubitStream.listen(events.add);

      cubit.doIntent(NavigateToRegisterEvent());
      await Future.delayed(const Duration(milliseconds: 50));

      expect(events.any((e) => e is NavigateToRegisterTempEvent), isTrue);
      await sub.cancel();
    });
  });

  // ── ShowMassageEvent ──────────────────────────────────────────────────────

  group('LoginCubit - doIntent(ShowMassageEvent)', () {
    test('sends ShowMassageTempEvent with correct message', () async {
      final events = <LoginTempEvents>[];
      final sub = cubit.cubitStream.listen(events.add);

      cubit.doIntent(ShowMassageEvent('Hello'));
      await Future.delayed(const Duration(milliseconds: 50));

      final msg = events.whereType<ShowMassageTempEvent>().first;
      expect(msg.massage, equals('Hello'));
      await sub.cancel();
    });
  });

  // ── ShowLoadingEvent / HideLoadingEvent ───────────────────────────────────

  group('LoginCubit - loading events', () {
    test('doIntent(ShowLoadingEvent) sends ShowLoadingTempEvent', () async {
      final events = <LoginTempEvents>[];
      final sub = cubit.cubitStream.listen(events.add);

      cubit.doIntent(ShowLoadingEvent());
      await Future.delayed(const Duration(milliseconds: 50));

      expect(events.any((e) => e is ShowLoadingTempEvent), isTrue);
      await sub.cancel();
    });

    test('doIntent(HideLoadingEvent) sends HideLoadingTempEvent', () async {
      final events = <LoginTempEvents>[];
      final sub = cubit.cubitStream.listen(events.add);

      cubit.doIntent(HideLoadingEvent());
      await Future.delayed(const Duration(milliseconds: 50));

      expect(events.any((e) => e is HideLoadingTempEvent), isTrue);
      await sub.cancel();
    });
  });
}
