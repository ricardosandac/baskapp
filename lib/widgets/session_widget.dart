import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/appcolors.dart'; // Importando a cor secundária
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
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), // Borda secundária
            image: DecorationImage(
              image: NetworkImage('https://picsum.photos/200/300?random='+court.id.toString()),
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
                bottom: 16,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Informações principais à esquerda
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          session.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Quadra: ${court.name}',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Tipo: ${session.type}',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    // Datas alinhadas à direita
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Início:',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        Text(
                          formatDate(session.startDate),
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        if (session.endDate != null) ...[
                          SizedBox(height: 4),
                          Text(
                            'Término:',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                          Text(
                            formatDate(session.endDate!),
                            style:
                                TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ],
                    ),
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
