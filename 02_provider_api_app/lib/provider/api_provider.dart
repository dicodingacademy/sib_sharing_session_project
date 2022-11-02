import 'package:flutter/material.dart';

import '../model/album.dart';
import '../model/load_enum.dart';
import '../service/api_service.dart';

class ApiProvider extends ChangeNotifier {
  final ApiService apiService;

  ApiProvider(this.apiService);

  LoadEnum loadEnum = LoadEnum.init;
  String message = "";
  late Album? album;

  Future<dynamic> loadAlbum() async {
    try {
      message = "";
      album = null;
      loadEnum = LoadEnum.loading;
      notifyListeners();

      final result = await apiService.fetchAlbum();

      album = result;
      loadEnum = LoadEnum.loaded;
      notifyListeners();
    } catch (e) {
      message = e.toString();
      loadEnum = LoadEnum.error;
      notifyListeners();
    }
  }

  Future<dynamic> loadError() async {
     try {
      message = "";
      album = null;
      loadEnum = LoadEnum.loading;
      notifyListeners();

      await apiService.fetchError();

      loadEnum = LoadEnum.loaded;
      notifyListeners();
    } catch (e) {
      message = e.toString();
      loadEnum = LoadEnum.error;
      notifyListeners();
    }
  }
}
