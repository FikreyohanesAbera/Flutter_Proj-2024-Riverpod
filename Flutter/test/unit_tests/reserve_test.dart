import 'package:flutter_application_1/application/Providers/reserveProvider.dart';
import 'package:flutter_application_1/application/Providers/signup_provider.dart';
import 'package:flutter_application_1/infrastructure/auth_repository.dart';
import 'package:flutter_application_1/infrastructure/reserve_repository.dart.dart';
import 'package:flutter_application_1/application/states/reserve_state.dart';
import 'package:flutter_application_1/application/states/signup_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
// import 'package:mockito/mockito.dart';
import 'package:mocktail/mocktail.dart';

class MockHTTPClient extends Mock implements Client {}

void main() {
  late ReserveService reserveService;
  late MockHTTPClient mockHTTPClient;

  setUp(() {
    mockHTTPClient = MockHTTPClient();
    reserveService = ReserveService(mockHTTPClient);
  });

  test('Some description', () {
    final container = createContainer(
      overrides: [
        reserveStateProvider.overrideWith((ref) {
          return ReserveState();
        }),
      ],
    );
    expect(
      container.read(reserveStateProvider),
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
                  .post(Uri.parse('http://192.168.1.110:5000/reserve')),
            ).thenAnswer((_) async {
              return Response('''{"success": "successful"}''', 200);
            });

            // Act
            final res = await reserveService.reserve(
                "", "", "", "", "", "", "", true, "", "");
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
          () => mockHTTPClient.post(
            Uri.parse('http://192.168.1.110:5000/reserve'),
          ),
        ).thenAnswer((_) async {
          return Response('''{"error": "error"}''', 200);
        });
        // act
        final user = await reserveService.reserve("", "", "", "", "", "", "",
            true, "", ""); // await the result since it's async
        // assert
        expect(user,
            {'error': 'An error occurred while processing your request.'});
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
