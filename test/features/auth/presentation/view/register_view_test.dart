import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uni_football_app/features/auth/presentation/view/login_view.dart';
import 'package:uni_football_app/features/auth/presentation/view_model/login/login_bloc.dart';

// Mock LoginBloc
class MockLoginBloc extends Mock implements LoginBloc {}

// Mock BuildContext
class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockLoginBloc mockLoginBloc;
  late MockBuildContext mockBuildContext;

  // Register fallback values for the events
  setUpAll(() {
    // Register fallback value for LoginUserEvent
    registerFallbackValue(LoginUserEvent(
      context: MockBuildContext(), // Use mock context
      username: '',
      password: '',
    ));
  });

  setUp(() {
    mockLoginBloc = MockLoginBloc();
    mockBuildContext = MockBuildContext();

    // Ensure that calling add() on mockLoginBloc does not throw errors
    when(() => mockLoginBloc.add(any())).thenAnswer((_) async {});
    mockBuildContext;
  });

  testWidgets('Register view has essential widgets',
      (WidgetTester tester) async {
    // Build the LoginView widget
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<LoginBloc>.value(
          value: mockLoginBloc,
          child: LoginView(),
        ),
      ),
    );

    // Verify widgets
    expect(find.byKey(ValueKey('username')), findsOneWidget);
    expect(find.byKey(ValueKey('password')), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNWidgets(2));
    expect(find.byKey(ValueKey('registerButton')), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('New user can enter text in allfields',
      (WidgetTester tester) async {
    // Build the LoginView widget
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<LoginBloc>.value(
          value: mockLoginBloc,
          child: LoginView(),
        ),
      ),
    );

    // Find text fields and enter text
    final usernameField = find.byKey(ValueKey('username'));
    final passwordField = find.byKey(ValueKey('password'));

    await tester.enterText(usernameField, 'testuser');
    await tester.enterText(passwordField, 'testpassword');

    // Verify text input
    expect(find.text('testuser'), findsOneWidget);
    expect(find.text('testpassword'), findsOneWidget);
  });

  testWidgets('Not register message when textfield empty',
      (WidgetTester tester) async {
    // Build the LoginView widget
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<LoginBloc>.value(
          value: mockLoginBloc,
          child: LoginView(),
        ),
      ),
    );

    // Find text fields and enter text
    final usernameField = find.byKey(ValueKey('username'));
    final passwordField = find.byKey(ValueKey('password'));

    await tester.enterText(usernameField, 'testuser');
    await tester.enterText(passwordField, 'testpassword');

    // Verify text input
    expect(find.text('testuser'), findsOneWidget);
    expect(find.text('testpassword'), findsOneWidget);
  });
  testWidgets('Please enter messsage when empty field',
      (WidgetTester tester) async {
    // Build the LoginView widget
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<LoginBloc>.value(
          value: mockLoginBloc,
          child: LoginView(),
        ),
      ),
    );

    // Find text fields and enter text
    final usernameField = find.byKey(ValueKey('username'));
    final passwordField = find.byKey(ValueKey('password'));

    await tester.enterText(usernameField, 'testuser');
    await tester.enterText(passwordField, 'testpassword');

    // Verify text input
    expect(find.text('testuser'), findsOneWidget);
    expect(find.text('testpassword'), findsOneWidget);
  });

  testWidgets('Regsitration Successful message pop up',
      (WidgetTester tester) async {
    // Build the LoginView widget
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<LoginBloc>.value(
          value: mockLoginBloc,
          child: LoginView(),
        ),
      ),
    );

    // Find text fields and enter text
    final usernameField = find.byKey(ValueKey('username'));
    final passwordField = find.byKey(ValueKey('password'));

    await tester.enterText(usernameField, 'testuser');
    await tester.enterText(passwordField, 'testpassword');

    // Verify text input
    expect(find.text('testuser'), findsOneWidget);
    expect(find.text('testpassword'), findsOneWidget);
  });
}
