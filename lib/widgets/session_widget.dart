import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/appcolors.dart'; // Importando a cor secundária
import '../utils/apptext.dart'; // Importando AppText
import '/models/session.dart';
import '/models/court.dart';
import '/screens/session_screen.dart';

class SessionWidget extends StatelessWidget {
  final Session session;
  final Court court;

  const SessionWidget({
    Key? key,
    required this.session,
    required this.court,
  }) : super(key: key);

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SessionScreen(
                session: session,
                court: court,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), // Borda secundária
            image: DecorationImage(
              image: NetworkImage('https://picsum.photos/200/300?random=' + court.id.toString()),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              // Degradê de baixo para cima
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Conteúdo dos textos
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: session.name,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    SizedBox(height: 4),
                    AppText(
                      text: 'Quadra: ${court.name}',
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    SizedBox(height: 4),
                    AppText(
                      text: 'Tipo: ${session.type}',
                      fontSize: 14,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ],
                ),
              ),
              // Datas alinhadas à direita
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      text: 'Início:',
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                    AppText(
                      text: formatDate(session.startDate),
                      fontSize: 12,
                      color: Colors.white,
                    ),
                    if (session.endDate != null) ...[
                      SizedBox(height: 4),
                      AppText(
                        text: 'Término:',
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                      AppText(
                        text: formatDate(session.endDate!),
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}