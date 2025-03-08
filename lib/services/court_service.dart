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
      },
      {
        "id": 5,
        "name": "Mountain View Basketball Court",
        "address": "202 Mountain Rd, Denver, CO",
        "addressSTR": "Vista da Montanha, Denver",
        "description": "Quadra de basquete com vista para as montanhas.",
        "status": "active"
      },
      {
        "id": 6,
        "name": "Riverside Badminton Court",
        "address": "303 River St, Portland, OR",
        "addressSTR": "Margem do Rio, Portland",
        "description": "Quadra de badminton ao lado do rio.",
        "status": "under_maintenance"
      },
      {
        "id": 7,
        "name": "City Center Skate Park",
        "address": "404 Skate Ave, San Francisco, CA",
        "addressSTR": "Centro da Cidade, SF",
        "description": "Parque de skate no centro da cidade.",
        "status": "active"
      },
      {
        "id": 8,
        "name": "Beachside Volleyball Court",
        "address": "505 Ocean Dr, Miami, FL",
        "addressSTR": "Beira-mar, Miami",
        "description": "Quadra de vôlei de praia com areia branca.",
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