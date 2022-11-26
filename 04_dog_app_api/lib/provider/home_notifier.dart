import 'package:flutter/material.dart';
import '../model/failure_exception.dart';
import '../model/loading_state.dart';
import '../service/api_service.dart';

class HomeNotifier extends ChangeNotifier {
  final ApiService apiService;
  HomeNotifier(this.apiService);

  LoadingState _state = LoadingState.initial;
  List<String>? _listDogBreed;
  String _message = "";

  LoadingState get state => _state;
  List<String> get listDogBreed => _listDogBreed ?? [];
  String get message => _message;

  Future<dynamic> loadListDogBreed() async {
    try {
      _state = LoadingState.loading;
      notifyListeners();

      final result = await apiService.listDogBreed();

      if (result.status == "success") {
        _state = LoadingState.loaded;
        _message = result.status;
        _listDogBreed = result.message;

        notifyListeners();
        return _message;
      } else {
        _state = LoadingState.noData;
        _message = result.status;
        notifyListeners();
        return _message;
      }
    } on FailureException catch (e) {
      _state = LoadingState.error;
      _message = e.message;
      notifyListeners();
      return _message;
    }
  }
}
