import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sib_sharing_session_project/model/album.dart';
import 'package:sib_sharing_session_project/model/load_enum.dart';
import 'package:sib_sharing_session_project/provider/api_provider.dart';
import 'package:sib_sharing_session_project/service/api_service.dart';

import '../json_reader.dart';
import 'api_provider_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  late MockApiService mockApiService;
  late ApiProvider apiProvider;

  setUp(() {
    mockApiService = MockApiService();
    apiProvider = ApiProvider(
      mockApiService,
    );
  });

  group("load album", () {
    test("state load is loaded when the call is successful", () async {
      final album =
          Album.fromJson(jsonDecode(readJson("dummy_data/api_result.json")));
      when(mockApiService.fetchAlbum()).thenAnswer((_) async => album);

      await apiProvider.loadAlbum();

      expect(apiProvider.loadEnum, LoadEnum.loaded);
    });

    test("state load is error when the call is unsuccessful", () async {
      when(mockApiService.fetchAlbum()).thenThrow((_) async => "No Connection");

      apiProvider.loadAlbum();

      expect(apiProvider.loadEnum, LoadEnum.error);
    });
  });

  group("load error", () {
    test("state load is loaded when the call is successful", () async {
      when(mockApiService.fetchError()).thenThrow((_) async => "Error load");

      await apiProvider.loadError();

      expect(apiProvider.loadEnum, LoadEnum.error);
    });

    test("state load is error when the call is unsuccessful", () async {
      when(mockApiService.fetchError()).thenThrow((_) async => "Error load");

      apiProvider.loadAlbum();

      expect(apiProvider.loadEnum, LoadEnum.error);
    });
  });
}
