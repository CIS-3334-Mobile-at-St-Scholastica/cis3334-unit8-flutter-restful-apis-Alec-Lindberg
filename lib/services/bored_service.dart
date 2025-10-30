import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data_models/bored_activity.dart';

class BoredService {
  static const _endpoint = 'https://www.boredapi.com/api/activity';

  static Future<BoredActivity> fetchRandomActivity() async {
    final res = await http.get(Uri.parse(_endpoint));
    if (res.statusCode == 200) {
      return BoredActivity.fromJson(json.decode(res.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load activity (status ${res.statusCode})');
    }
  }
}
