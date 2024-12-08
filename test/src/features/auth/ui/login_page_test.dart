import 'package:asuka/asuka.dart';
import 'package:ca_flutter_test/src/features/auth/ui/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ModularNavigateMock extends Mock implements IModularNavigator {}

void main() {
  final modular = ModularNavigateMock();

  setUp(() {
    Modular.navigatorDelegate = modular;
  });

  tearDown(
    () {
      reset(modular);
    },
  );

  group(
    'LoginPage |',
    () {
      testWidgets('Should render LoginPage and find texts', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            builder: Asuka.builder,
            theme: ThemeData(colorSchemeSeed: const Color(0xff54a1ee)),
            home: LoginPage(),
          ),
        );

        await tester.pump();

        expect(find.text('SIGN IN'), findsOneWidget);
        expect(find.text('Username'), findsOneWidget);
        expect(find.text('Password'), findsOneWidget);
        expect(find.text('LOGIN'), findsOneWidget);
      });
    },
  );
}
