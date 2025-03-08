// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../utils/appcolors.dart';
import '../utils/apptext.dart';
import '../services/session_service.dart';
import '../models/court.dart';
import '../models/session.dart';
import '../widgets/session_widget.dart';

class CourtScreen extends StatefulWidget {
  //const CourtScreen({super.key});
  final Court court;
  CourtScreen({
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
          icon: const Icon(Icons.chevron_left), onPressed: () {
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
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No objects found'));
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final object = snapshot.data![index];
              return SessionWidget(
                session: object,
                court: widget.court
              );
            },
          );
        },
      ),
    );
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
  }
}