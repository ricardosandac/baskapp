import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/session.dart';

class SessionApiService {
  static const String baseUrl = 'https://catfact.ninja';

  Future<List<Session>> fetchObjects() async {
      final String fakeJson = '''
      [
        {
          "id": 1,
          "courtId": 101,
          "name": "Sessão de Treinamento A",
          "type": "Treinamento",
          "startDate": "2025-03-10T08:00:00Z",
          "endDate": "2025-03-10T10:00:00Z"
        },
        {
          "id": 2,
          "courtId": 102,
          "name": "Sessão de Jogo Amistoso",
          "type": "Amistoso",
          "startDate": "2025-03-11T15:00:00Z",
          "endDate": "2025-03-11T17:00:00Z"
        },
        {
          "id": 3,
          "courtId": 103,
          "name": "Sessão Livre - Noite",
          "type": "Livre",
          "startDate": "2025-03-12T20:00:00Z",
          "endDate": "2025-03-12T20:00:00Z"
        },
        {
          "id": 4,
          "courtId": 104,
          "name": "Treinamento Avançado",
          "type": "Treinamento",
          "startDate": "2025-03-13T09:00:00Z",
          "endDate": "2025-03-13T12:00:00Z"
        }
    ]
    ''';

    final response = await http.get(Uri.parse('https://catfact.ninja/facts'));

    if (response.statusCode == 200) {
      // ignore: unused_local_variable
      var body = jsonDecode(fakeJson);//response.body);
      List<dynamic> data = jsonDecode(fakeJson);//body["data"];
      return data.map((json) => Session.fromJson(json)).toList();
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