import 'package:flutter/services.dart';

import '../model/dog_breed.dart';
import '../model/dog_breed_detail.dart';
import '../model/failure_exception.dart';
import 'dart:convert';

class AssetService {
  Future<DogBreed> listDogBreed() async {
    try {
      final response = await rootBundle.loadString("assets/all_dog.json");
      return DogBreed.fromJson(json.decode(response));
    } catch (e) {
      throw FailureException('Failed to load list of dog breeds');
    }
  }

  Future<DogBreedDetail> dogBreed(String breed) async {
    try {
      final response = await rootBundle.loadString("assets/akita_dog.json");
      return DogBreedDetail.fromJson(json.decode(response));
    } catch (e) {
      throw FailureException('Failed to load image of dog $breed');
    }
  }
}
