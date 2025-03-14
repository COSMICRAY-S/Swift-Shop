import 'dart:convert';
import 'package:http/http.dart' as http;

class GeoapifyService {
  static const String apiKey =
      "936e886820964ff1a605457be936f052"; // Replace with your API key

  /// Fetch address suggestions based on user input
  static Future<List<String>> getPlaceSuggestions(String input) async {
    final url = Uri.parse(
        'https://api.geoapify.com/v1/geocode/autocomplete?text=$input&apiKey=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<String> suggestions = [];

      for (var feature in data['features']) {
        suggestions.add(feature['properties']['formatted']);
      }
      return suggestions;
    } else {
      throw Exception('Failed to load address suggestions');
    }
  }
}
