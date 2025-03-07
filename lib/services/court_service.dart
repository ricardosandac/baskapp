import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/court.dart';

class CourtApiService {
  static const String baseUrl = 'https://catfact.ninja';

  Future<List<Court>> fetchObjects() async {
    final String fakeJson = '''
    [
      {
        "id": 1,
        "name": "Central Park Court",
        "address": "123 Main St, New York, NY",
        "addressSTR": "Central Park, NYC",
        "description": "Quadra de basquete ao ar livre com iluminação noturna.",
        "status": "active"
      },
      {
        "id": 2,
        "name": "Lakeside Tennis Court",
        "address": "456 Lakeview Dr, Miami, FL",
        "addressSTR": "Lago Azul, Miami",
        "description": "Quadra de tênis profissional com arquibancada.",
        "status": "under_maintenance"
      },
      {
        "id": 3,
        "name": "Downtown Soccer Field",
        "address": "789 Soccer Ave, Los Angeles, CA",
        "addressSTR": "Centro de LA",
        "description": "Campo de futebol com grama sintética e vestiários.",
        "status": "active"
      },
      {
        "id": 4,
        "name": "Sunset Volleyball Court",
        "address": "101 Beach Rd, San Diego, CA",
        "addressSTR": "Praia do Pôr do Sol",
        "description": "Quadra de vôlei de praia com vista para o mar.",
        "status": "closed"
      }
    ]''';

    final response = await http.get(Uri.parse('https://catfact.ninja/facts'));

    if (response.statusCode == 200) {
      // ignore: unused_local_variable
      var body = jsonDecode(fakeJson);//response.body);
      List<dynamic> data = jsonDecode(fakeJson);//body["data"];
      return data.map((json) => Court.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load objects');
    }
  }

  Future<void> toggleObjectStatus(int id, bool newStatus) async {
    final response = await http.put(
      Uri.parse('$baseUrl/objects/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': newStatus}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update object');
    }
  }
}