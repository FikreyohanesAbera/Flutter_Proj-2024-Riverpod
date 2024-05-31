import 'package:flutter/material.dart';
import 'package:flutter_application_1/Presentation/screens/profie_page.dart';
import 'package:flutter_application_1/application/Providers/userDataProvider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('Provider for profile page', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ProfilePage(),
        ),
      ),
    );
    final container = createContainer(
      overrides: [
        userDataProvider.overrideWith((ref) {
          return ["abebe", "abebe@gmail.com", ""];
        }),
      ],
    );
    expect(
      container.read(userDataProvider)[0],
      equals("abebe"),
    );
  });
}

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  addTearDown(container.dispose);

  return container;
}
