import 'package:flutter_application_1/application/Providers/login_provider.dart';
import 'package:flutter_application_1/infrastructure/auth_repository.dart';
import 'package:flutter_application_1/application/states/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
// import 'package:mockito/mockito.dart';
import 'package:mocktail/mocktail.dart';

class MockHTTPClient extends Mock implements Client {}

void main() {
  late AuthService authService;
  late MockHTTPClient mockHTTPClient;

  setUp(() {
    mockHTTPClient = MockHTTPClient();
    authService = AuthService(mockHTTPClient);
  });

  test('Login ', () {
    final container = createContainer(
      overrides: [
        loginStateProvider.overrideWith((ref) {
          return LoginState();
        }),
      ],
    );
    expect(
      container.read(loginStateProvider),
      equals({}),
    );
  });

  group('authService - ', () {
    group(
      'getUser function',
      () {
        test(
          'given authService class when getUser function is called and status code is 200 then a usermodel should be returned',
          () async {
            // Arrange
            when(
              () => mockHTTPClient
                  .get(Uri.parse('http://192.168.1.110:5000/auth/login')),
            ).thenAnswer((_) async {
              return Response('''{"success": "successful"}''', 200);
            });

            // Act
            final res = await authService.register("", "", "");
            // Assert
            expect(res, isA<Map>());
          },
        );
      },
    );

    test(
      'given authService class when register function is called and status code is not 200 then an exception should be thrown',
      () async {
        // arrange
        when(
          () => mockHTTPClient.get(
            Uri.parse('http://192.168.1.110:5000/auth/login'),
          ),
        ).thenAnswer((_) async {
          return Response('''{
            "error":"error",
            "message": "error"
            }''', 500);
        });
        // act
        final res = await authService.login(
            "", "", "", ""); // await the result since it's async
        // assert
        expect(
            res, {'error': 'An error occurred while processing your request.'});
      },
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
