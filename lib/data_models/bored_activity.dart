// lib/data_models/bored_activity.dart
import 'dart:convert';

BoredActivity boredActivityFromJson(String str) =>
    BoredActivity.fromJson(json.decode(str) as Map<String, dynamic>);

class BoredActivity {
  final String activity;
  final String type;            // e.g., "education", "recreational"
  final int participants;       // number of people
  final double price;           // 0.0 - 1.0
  final String? link;           // optional URL
  final String key;             // unique activity key
  final double accessibility;   // 0.0 - 1.0

  const BoredActivity({
    required this.activity,
    required this.type,
    required this.participants,
    required this.price,
    required this.link,
    required this.key,
    required this.accessibility,
  });

  factory BoredActivity.fromJson(Map<String, dynamic> json) {
    double _toDouble(dynamic n) =>
        n is int ? n.toDouble() : (n as num).toDouble();

    return BoredActivity(
      activity: json['activity'] as String,
      type: json['type'] as String,
      participants: (json['participants'] as num).toInt(),
      price: _toDouble(json['price']),
      link: (json['link'] as String).isEmpty ? null : json['link'] as String,
      key: json['key'] as String,
      accessibility: _toDouble(json['accessibility']),
    );
  }
}
