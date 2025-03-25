import 'package:flutter/material.dart';
import '../utils/appcolors.dart';
import '../utils/apptext.dart';
import '../services/session_service.dart';
import '../models/court.dart';
import '../models/session.dart';
import '../widgets/session_widget.dart';
import 'add_session_screen.dart';

class CourtScreen extends StatefulWidget {
  final Court court;

  const CourtScreen({
    Key? key,
    required this.court
  }) : super(key: key);

  @override
  _CourtScreen createState() => _CourtScreen();
}

class _CourtScreen extends State<CourtScreen> {
  final SessionApiService apiService = SessionApiService();
  late Future<List<Session>> futureObjects;

  @override
  void initState() {
    super.initState();
    futureObjects = apiService.fetchObjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: AppText(
          text: widget.court.name,
          fontSize: 18.0,
          color: AppColors.blackColor,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: FutureBuilder<List<Session>>(
        future: futureObjects,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final sessions = snapshot.data ?? [];

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: sessions.length + 1, // Adiciona 1 para o texto e botão no topo
            itemBuilder: (context, index) {
              if (index == 0) {
                // Primeira posição: Texto e botão de adicionar
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: 'Sessões aquecendo',
                          fontSize: 24.0, // Ajuste para o mesmo tamanho da HomeScreen
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: AppColors.primaryColor),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddSessionScreen(courtId: widget.court.id),
                              ),
                            );
                            if (result == true) {
                              setState(() {
                                futureObjects = apiService.fetchObjects(); // Recarrega a lista de sessões
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16), // Espaçamento abaixo do texto
                  ],
                );
              }

              // Demais posições: Lista de sessões
              final session = sessions[index - 1]; // Ajusta o índice para ignorar o primeiro item
              return SessionWidget(
                session: session,
                court: widget.court,
              );
            },
          );
        },
      ),
    );
  }
}