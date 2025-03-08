import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baskapp/utils/appcolors.dart';
import 'package:baskapp/utils/appconstants.dart';

import '../utils/helper/data_functions.dart';
import '../utils/apptext.dart';
import 'home_screen.dart';
import 'onboardingscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DataHandler dataHandler = DataHandler();
  String doneOnboarding = "";
  String setdoneOnboarding = "";


  void readData() async {
    doneOnboarding = await dataHandler.getStringValue(AppConstants.doneOnboarding);

    setState(() {
      setdoneOnboarding = doneOnboarding;

    });
  }

  @override
  void initState() {
    super.initState();
    readData();


    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                // (context) => const HomeScreen()
                (context) =>  setdoneOnboarding.toString() == "YES" ? HomeScreen() : const OnboardingScreen()
            ),
        )
    );
  }




  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              text: "BASKAPP",
              fontSize: 32.0,
              color: Colors.black,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 100,),
            CupertinoActivityIndicator()
          ],
        ),
      ),
    );
  }
}
