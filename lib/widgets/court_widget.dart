import 'package:flutter/material.dart';
import '/models/court.dart';
import '/screens/court_screen.dart';
import '../utils/appcolors.dart';// Certifique-se de que o caminho está correto

class CourtWidget extends StatelessWidget {
  final Court court;

  const CourtWidget({
    required this.court
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Mantém o fundo original do Container
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourtScreen(court: court),
            ),
          );
        },
        borderRadius: BorderRadius.circular(2),
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primaryColor, // Cor primária do AppColors
              width: 3, // Espessura da borda
            ),
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
              // Textos
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      court.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      court.addressSTR,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
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