import 'package:flutter_application_1/application/Providers/login_provider.dart';
import 'package:flutter_application_1/application/Providers/tableProvider.dart';
import 'package:flutter_application_1/application/states/table_state.dart';

import 'package:flutter_application_1/infrastructure/table_repository.dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
// import 'package:mockito/mockito.dart';
import 'package:mocktail/mocktail.dart';

class MockHTTPClient extends Mock implements Client {}

void main() {
  late TableService tableService;
  late MockHTTPClient mockHTTPClient;

  setUp(() {
    mockHTTPClient = MockHTTPClient();
    tableService = TableService(mockHTTPClient);
  });

  test('Login ', () {
    final container = createContainer(
      overrides: [
        tableStateProvider.overrideWith((ref) {
          return TableState();
        }),
      ],
    );
    expect(
      container.read(loginStateProvider),
      equals({}),
    );
  });

  group('table - ', () {
    group(
      'table function',
      () {
        test(
          'table',
          () async {
            // Arrange
            when(() => mockHTTPClient
                    .get(Uri.parse('http://192.168.1.110:5000/table')))
                .thenAnswer((_) async {
              return Response('''{"success": "successful"}''', 200);
            });

            // Act
            final res = await tableService.table("", "", "", "", "", "");
            // Assert
            expect(res, isA<Map>());
          },
        );
      },
    );

    test(
      'table',
      () async {
        // arrange
        when(
          () => mockHTTPClient.post(
            Uri.parse('http://192.168.1.110:5000/tables'),
          ),
        ).thenAnswer((_) async {
          return Response('''{
            "error":"error",
            "message": "error"
            }''', 500);
        });
        // act
        final res = await tableService.table(
            "", "", "", "", "", ""); // await the result since it's async
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
