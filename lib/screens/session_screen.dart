// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '/utils/appcolors.dart';
import '/widgets/apptext.dart';
import '../services/session_service.dart';
import '/models/court.dart';
import '/models/session.dart';

class SessionScreen extends StatefulWidget {
  //const SessionScreen({super.key});
  final Court court;
  final Session session;
  const SessionScreen({
    super.key,
    required this.court,
    required this.session,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SessionScreen createState() => _SessionScreen();
}

class _SessionScreen extends State<SessionScreen> {
  final SessionApiService apiService = SessionApiService();
  late Future<List<Session>> futureObjects;

  @override
  void initState() {
    super.initState();
    futureObjects = apiService.fetchObjects();
  }

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(widget.session.name),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: widget.session.name,
              //style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            AppText(
              text: 'Tipo: ${widget.session.type}',
              fontSize: 18,
            ),
            SizedBox(height: 8),
            Text(
              'Data de Início: ${formatDateTime(widget.session.startDate)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            if (widget.session.endDate != null)
              Text(
                'Data de Término: ${formatDateTime(widget.session.endDate!)}',
                style: TextStyle(fontSize: 18),
              )
            else
              Text(
                'Data de Término: Não definida',
                style: TextStyle(fontSize: 18),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Action when button is pressed (for example, RSVP or more details)
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Confirmar Participação'),
                    content: Text('Você confirma sua participação neste evento?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Action for confirmation
                        },
                        child: Text('Confirmar'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Confirmar Participação'),
            ),
          ],
        ),
      ),
    );
  }
}
    /*return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ObjectControlScreen()),
                );
              },
              child: Text('Manage Objects'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
              child: Text('Settings'),
            ),
          ],
        ),
      ),
    );*/