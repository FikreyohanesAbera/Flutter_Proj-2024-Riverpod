import 'package:flutter_application_1/application/states/signup_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/application/Providers/signup_provider.dart';

void main() {
  test('Some description', () {
    final container = createContainer(
      overrides: [
        SignupStateProvider.overrideWith((ref) {
          return SignupState();
        }),
      ],
    );
    expect(
      container.read(SignupStateProvider),
      equals({}),
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
