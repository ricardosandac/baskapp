import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profilescreen.dart';
import '../screens/add_court_screen.dart';
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
  final TextEditingController _addressController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    futureObjects = apiService.fetchObjects();
    _loadAddress();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _saveAddress();
      }
    });
  }

  Future<void> _loadAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _addressController.text = prefs.getString('address') ?? '';
    });
  }

  Future<void> _saveAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('address', _addressController.text);
    setState(() {
      _isEditing = false;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      placemarkFromCoordinates(position.latitude, position.longitude)
                      .then((placemarks) {
                    var place = 'No results found.';
                    if (placemarks.isNotEmpty) {
                      place = placemarks[0].name.toString();
                      setState(() {
                        _addressController.text = place;
                      });
                    }
                  });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: const Text(""),
        backgroundColor: AppColors.primaryColor,
        title: const AppText(
          text: "BaskAPP",
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
      body: GestureDetector(
        onTap: () {
          if (_isEditing) {
            _saveAddress();
          }
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              color: AppColors.primaryColor,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: AppColors.blackColor),
                    onPressed: () {
                      setState(() {
                        _isEditing = true;
                        _focusNode.requestFocus();
                      });
                    },
                  ),
                  Expanded(
                    child: _isEditing
                        ? TextField(
                            controller: _addressController,
                            focusNode: _focusNode,
                            decoration: InputDecoration(
                              hintText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              fillColor: AppColors.secondaryColor
                            ),
                            onEditingComplete: _saveAddress,
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                _isEditing = true;
                                _focusNode.requestFocus();
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                _addressController.text.isEmpty ? 'Enter address' : _addressController.text,
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 16.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                  ),
                  IconButton(
                    icon: Icon(Icons.my_location, color: AppColors.blackColor),
                    onPressed: _getCurrentLocation,
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Court>>(
                future: futureObjects,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    debugPrint('Error in FutureBuilder: ${snapshot.error}');
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    debugPrint('No courts found');
                    return Center(child: Text('No objects found'));
                  }

                  debugPrint('Snapshot data: ${snapshot.data}');

                  return ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: snapshot.data!.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Quadras perto de você',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: AppColors.primaryColor),
                                onPressed: () async {
                                  // Navega para a tela de adicionar quadra e aguarda o retorno
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddCourtScreen(),
                                    ),
                                  );

                                  // Recarrega a lista de courts se uma nova quadra foi adicionada
                                  if (result == true) {
                                    debugPrint('New court added');
                                    setState(() {
                                      futureObjects = apiService.fetchObjects();
                                      futureObjects.then((courts) {
                                        debugPrint('Updated courts list: $courts');
                                      });
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        final object = snapshot.data![index - 1];
                        return CourtWidget(
                          court: object,
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}