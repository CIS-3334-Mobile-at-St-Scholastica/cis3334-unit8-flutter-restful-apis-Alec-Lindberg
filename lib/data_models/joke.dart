// lib/data_models/joke.dart
import 'dart:convert';

Joke jokeFromJson(String str) =>
    Joke.fromJson(json.decode(str) as Map<String, dynamic>);

class Joke {
  final String type;          // "single" or "twopart"
  final String category;      // e.g., "Programming", "Misc"
  final int id;
  final bool safe;
  final String? joke;         // present when type == "single"
  final String? setup;        // present when type == "twopart"
  final String? delivery;     // present when type == "twopart"

  const Joke({
    required this.type,
    required this.category,
    required this.id,
    required this.safe,
    this.joke,
    this.setup,
    this.delivery,
  });

  factory Joke.fromJson(Map<String, dynamic> json) => Joke(
    type: json['type'] as String,
    category: json['category'] as String,
    id: (json['id'] as num).toInt(),
    safe: (json['safe'] as bool?) ?? true,
    joke: json['joke'] as String?,
    setup: json['setup'] as String?,
    delivery: json['delivery'] as String?,
  );
}
