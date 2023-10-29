import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'api_get_test.mocks.dart';
import 'package:mockito/mockito.dart';
import '../../lib/main.dart';

@GenerateMocks([http.Client])
void main() {
  group('GetNewsData', () {
    // Mock 객체를 이용해 getNewsData 함수 테스트(Api get test)
    test('Test HTTP GET request with mock response', () async {
      // Mock HTTP 객체 생성
      final client = MockClient();

      // Mock 객체가 특정 Url로 GET 요청을 수행할 때, 요청이 성공했을 경우의 응답을 설정
      when( client
          .get(Uri.parse("http://10.0.2.2:8000/api/vi/external/test")))
          .thenAnswer((_) async =>
          http.Response(
              '{"title": "Gun hae is idiot!!", "body": "Reseach which proved Gun hae is idiot has been reported"}',
              200));

      // getData 함수를 호출, 반환된 결과를 검증
      expect( await getNewsData(client), isA<NewsData>() );
    });

    // 위의 getNewsData 함수 테스트가 HTTP 오류로 끝난 경우, 예외처리가 되는지 테스트
    test('throws an exception if the http call completes with an error', () async {
      // Mock HTTP 객체 생성
      final client = MockClient();

      // Mock 객체가 특정 Url로 GET 요청을 수행할 때, 404(Not Found)응답을 반환하도록 설정
      when(client
          .get(Uri.parse("http://10.0.2.2:8000/api/vi/external/test")))
          .thenAnswer((_) async =>
          http.Response('Not Found', 404));

      expect(await getNewsData(client), throwsException);
    });
  });
}