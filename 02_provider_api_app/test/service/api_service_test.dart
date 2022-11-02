import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:sib_sharing_session_project/model/album.dart';
import 'package:sib_sharing_session_project/service/api_service.dart';

import '../json_reader.dart';
import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late String url;
  late MockClient mockClient;
  late ApiService apiService;

  setUp(() {
    url = "https://jsonplaceholder.typicode.com/albums/1";
    mockClient = MockClient();
    apiService = ApiService(
      mockClient,
    );
  });
  //
  group("fetch album", () {
    test("should return object when the response code is 200", () async {
      final album =
          Album.fromJson(jsonDecode(readJson("dummy_data/api_result.json")));

      // arrange
      when(mockClient.get(
        Uri.parse(url),
      )).thenAnswer((_) async =>
          http.Response(readJson("dummy_data/api_result.json"), 200));

      // act
      final result = await apiService.fetchAlbum();

      // assert
      expect(result, equals(album));
    });

    test("should return error when the response code is other than 200",
        () async {
      // arrange
      when(mockClient.get(
        Uri.parse(url),
      )).thenAnswer((_) async => http.Response('Failed to load album', 400));

      // act
      final result = apiService.fetchAlbum();

      // assert
      expect(result, throwsA(isA<String>()));
    });

    test("should return error when there is no connection", () async {
      // arrange
      when(mockClient.get(
        Uri.parse(url),
      )).thenThrow((_) async => "No Internet");

      // act
      final result = apiService.fetchAlbum();

      // assert
      expect(result, throwsA(isA<String>()));
    });
  });

  group("fetch error", () {
    test("should return error ", () async {
      // arrange
      when(mockClient.get(
        Uri.parse(url),
      )).thenThrow((_) async => "Error load");

      // act
      final result = apiService.fetchAlbum();

      // assert
      expect(result, throwsA(isA<String>()));
    });
  });
}
