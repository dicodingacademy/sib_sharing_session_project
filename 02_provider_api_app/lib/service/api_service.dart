import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/album.dart';

class ApiService {
  final http.Client client;

  ApiService(this.client);

  Future<Album> fetchAlbum() async {
    try {
      const url = "https://jsonplaceholder.typicode.com/albums/1";

      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return Album.fromJson(jsonDecode(response.body));
      } else {
        throw 'Failed to load album';
      }
    } catch (e) {
      throw 'No Internet';
    }
  }

  Future<Album> fetchError() async {
    const duration = Duration(seconds: 2);
    await Future.delayed(duration);
    throw "Error load";
  }
}
