// ...existing code...

import 'package:flutter/material.dart';
import '/utils/appcolors.dart';
import '../utils/apptext.dart';
import '../services/session_service.dart';
import '/models/court.dart';
import '/models/session.dart';
import '../widgets/expanded_button_widget.dart';

class SessionScreen extends StatefulWidget {
  final Court court;
  final Session session;

  const SessionScreen({
    super.key,
    required this.court,
    required this.session,
  });

  @override
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
        title: AppText(
          text: widget.session.name,
          fontSize: 20,
          color: AppColors.blackColor, // Changed to black color
        ),
        backgroundColor: AppColors.secondaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.whiteColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.backgroundColor,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    text: widget.court.name,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whiteColor, // Changed to white color
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.category, color: AppColors.primaryColor),
                                      SizedBox(width: 8),
                                      AppText(
                                        text: 'Tipo: ${widget.session.type}',
                                        fontSize: 18,
                                        color: AppColors.whiteColor, // Changed to white color
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today, color: AppColors.primaryColor),
                                      SizedBox(width: 8),
                                      AppText(
                                        text: 'Data de Início: ${formatDateTime(widget.session.startDate)}',
                                        fontSize: 18,
                                        color: AppColors.whiteColor, // Changed to white color
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  if (widget.session.endDate != null)
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_today, color: AppColors.primaryColor),
                                        SizedBox(width: 8),
                                        AppText(
                                          text: 'Data de Término: ${formatDateTime(widget.session.endDate!)}',
                                          fontSize: 18,
                                          color: AppColors.whiteColor, // Changed to white color
                                        ),
                                      ],
                                    )
                                  else
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_today, color: AppColors.primaryColor),
                                        SizedBox(width: 8),
                                        AppText(
                                          text: 'Data de Término: Não definida',
                                          fontSize: 18,
                                          color: AppColors.whiteColor, // Changed to white color
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Divider(),
                        SizedBox(height: 16),
                        AppText(
                          text: 'Descrição:',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor, // Changed to white color
                        ),
                        SizedBox(height: 8),
                        AppText(
                          text: widget.session.description,
                          fontSize: 16,
                          color: AppColors.whiteColor, // Changed to white color
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 80), // Espaço para o botão fixo
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ExpandedButton(
                buttonColor: AppColors.primaryColor,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: AppText(text: 'Confirmar Participação', color: AppColors.blackColor), // Changed to black color
                      content: AppText(text: 'Você confirma sua participação neste evento?', color: AppColors.blackColor), // Changed to black color
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: AppText(text: 'Cancelar', color: AppColors.blackColor), // Changed to black color
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            // Action for confirmation
                          },
                          child: AppText(text: 'Confirmar', color: AppColors.blackColor), // Changed to black color
                        ),
                      ],
                    ),
                  );
                },
                child: AppText(
                  text: 'Confirmar Participação',
                  fontSize: 18,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}