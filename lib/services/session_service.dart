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
        "endDate": "2025-03-10T10:00:00Z",
        "description": "Treinamento intensivo para iniciantes.",
        "image": null
      },
      {
        "id": 2,
        "courtId": 102,
        "name": "Sessão de Jogo Amistoso",
        "type": "Amistoso",
        "startDate": "2025-03-11T15:00:00Z",
        "endDate": "2025-03-11T17:00:00Z",
        "description": "Jogo amistoso entre equipes locais.",
        "image": null
      },
      {
        "id": 3,
        "courtId": 103,
        "name": "Sessão Livre - Noite",
        "type": "Livre",
        "startDate": "2025-03-12T20:00:00Z",
        "endDate": "2025-03-12T22:00:00Z",
        "description": "Sessão livre para todos os níveis.",
        "image": null
      },
      {
        "id": 4,
        "courtId": 104,
        "name": "Treinamento Avançado",
        "type": "Treinamento",
        "startDate": "2025-03-13T09:00:00Z",
        "endDate": "2025-03-13T12:00:00Z",
        "description": "Treinamento avançado para jogadores experientes.",
        "image": null
      },
      {
        "id": 5,
        "courtId": 105,
        "name": "Sessão de Yoga",
        "type": "Yoga",
        "startDate": "2025-03-14T07:00:00Z",
        "endDate": "2025-03-14T08:30:00Z",
        "description": "Sessão de yoga para relaxamento e alongamento.",
        "image": "https://picsum.photos/200/300?random=5"
      },
      {
        "id": 6,
        "courtId": 106,
        "name": "Aula de Zumba",
        "type": "Zumba",
        "startDate": "2025-03-15T18:00:00Z",
        "endDate": "2025-03-15T19:00:00Z",
        "description": "Aula de zumba para todos os níveis.",
        "image": "https://picsum.photos/200/300?random=6"
      },
      {
        "id": 7,
        "courtId": 107,
        "name": "Treinamento de Força",
        "type": "Treinamento",
        "startDate": "2025-03-16T10:00:00Z",
        "endDate": "2025-03-16T11:30:00Z",
        "description": "Treinamento de força para aumento de massa muscular.",
        "image": "https://picsum.photos/200/300?random=7"
      },
      {
        "id": 8,
        "courtId": 108,
        "name": "Sessão de Meditação",
        "type": "Meditação",
        "startDate": "2025-03-17T06:00:00Z",
        "endDate": "2025-03-17T07:00:00Z",
        "description": "Sessão de meditação guiada para iniciantes.",
        "image": "https://picsum.photos/200/300?random=8"
      }
    ]
    ''';

    final response = await http.get(Uri.parse('https://catfact.ninja/facts'));

    if (response.statusCode == 200) {
      var body = jsonDecode(fakeJson); // response.body);
      List<dynamic> data = jsonDecode(fakeJson); // body["data"];
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

  addSession(Session newSession) {}
}