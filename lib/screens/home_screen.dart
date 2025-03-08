// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'profilescreen.dart';
import '../utils/appcolors.dart';
import '../utils/apptext.dart';
import '../services/court_service.dart';
import '../models/court.dart';
import '../widgets/court_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final CourtApiService apiService = CourtApiService();
  late Future<List<Court>> futureObjects;

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
        leading: const Text(""),
        backgroundColor: AppColors.primaryColor,
        title: const AppText(
          text: "BASKAPP",
          fontSize: 18.0,
          color: AppColors.blackColor,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
              icon: const Icon(
                Icons.account_circle_outlined,
                color: AppColors.blackColor,
              ))
        ],
      ),
      body: FutureBuilder<List<Court>>(
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
              return CourtWidget(
                court: object
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