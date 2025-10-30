// lib/services/joke_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data_models/joke.dart';

class JokeService {
  // safe-mode filters out NSFW etc.
  static const _endpoint = 'https://v2.jokeapi.dev/joke/Any?safe-mode';

  static Future<Joke> fetchRandomJoke() async {
    final res = await http.get(Uri.parse(_endpoint));
    if (res.statusCode == 200) {
      return Joke.fromJson(json.decode(res.body) as Map<String, dynamic>);
    }
    throw Exception('Failed to load joke (status ${res.statusCode})');
  }
}
