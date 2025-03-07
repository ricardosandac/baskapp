import 'package:flutter/material.dart';
import '../services/court_service.dart';
import '../models/court.dart';

class ObjectControlScreen extends StatefulWidget {
  const ObjectControlScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ObjectControlScreenState createState() => _ObjectControlScreenState();
}

class _ObjectControlScreenState extends State<ObjectControlScreen> {
  final CourtApiService apiService = CourtApiService();
  late Future<List<Court>> futureObjects;

  @override
  void initState() {
    super.initState();
    futureObjects = apiService.fetchObjects();
  }

  /*void toggleStatus(Cat object) async {
    await apiService.toggleObjectStatus(object.id, !object.status);
    setState(() {
      futureObjects = apiService.fetchObjects();
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Object Control')),
      body: FutureBuilder<List<Court>>(
        future: futureObjects,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading objects'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No objects found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final object = snapshot.data![index];
              return ListTile(
                title: Text(object.name)/*,
                trailing: Switch(
                  value: object.status,
                  onChanged: (value) => toggleStatus(object),
                ),*/
              );
            },
          );
        },
      ),
    );
  }
}