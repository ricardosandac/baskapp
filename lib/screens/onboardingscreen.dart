import 'package:flutter/material.dart';
import 'package:baskapp/screens/home_screen.dart';
import '../utils/appcolors.dart';
import '../utils/appconstants.dart';
import '../utils/helper/data_functions.dart';
import '../utils/onboarding_util/countryCodes.dart';
import '../utils/onboarding_util/languages.dart';
import '../utils/apptext.dart';
import '../widgets/expanded_button_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  DataHandler dataHandler = DataHandler();

  String nome = '';
  String sobrenome = '';
  String email = '';
  String? posicao;
  String? posicaoSecundaria;
  CountryCodes? selectedCountry;
  Language? selectedLanguage;
  String? genero;
  final List<String> generos = ['Masculino', 'Feminino', 'Outro'];
  final List<String> posicoes = ['Armador', 'Ala-Armador', 'Ala', 'Ala-Pivô', 'Pivô'];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          leading: const Text(""),
          backgroundColor: AppColors.primaryColor,
          title: const AppText(
            text: "Cadastro",
            fontSize: 18.0,
            color: AppColors.blackColor,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(color: AppColors.blackColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.blackColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    nome = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Sobrenome',
                  labelStyle: TextStyle(color: AppColors.blackColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.blackColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    sobrenome = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: AppColors.blackColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.blackColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  AppText(
                    text: "Posição",
                    fontSize: 12.0,
                    color: AppColors.blackColor,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.normal,
                  ),
                  Spacer()
                ],
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: AppColors.blackColor.withOpacity(0.7)),
                  color: Colors.white,
                ),
                child: DropdownButton<String>(
                  value: posicao,
                  items: posicoes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: AppText(
                        text: value,
                        fontSize: 18.0,
                        color: AppColors.blackColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      posicao = newValue!;
                    });
                  },
                  underline: Container(),
                  icon: const Icon(Icons.arrow_drop_down, color: AppColors.blackColor),
                  elevation: 8,
                  isExpanded: true,
                  dropdownColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  AppText(
                    text: "Posição Secundária",
                    fontSize: 12.0,
                    color: AppColors.blackColor,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.normal,
                  ),
                  Spacer()
                ],
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: AppColors.blackColor.withOpacity(0.7)),
                  color: Colors.white,
                ),
                child: DropdownButton<String>(
                  value: posicaoSecundaria,
                  items: posicoes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: AppText(
                        text: value,
                        fontSize: 18.0,
                        color: AppColors.blackColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      posicaoSecundaria = newValue!;
                    });
                  },
                  underline: Container(),
                  icon: const Icon(Icons.arrow_drop_down, color: AppColors.blackColor),
                  elevation: 8,
                  isExpanded: true,
                  dropdownColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  AppText(
                    text: "Gênero",
                    fontSize: 12.0,
                    color: AppColors.blackColor,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.normal,
                  ),
                  Spacer()
                ],
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: AppColors.blackColor.withOpacity(0.7)),
                  color: Colors.white,
                ),
                child: DropdownButton<String>(
                  value: genero,
                  items: generos.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: AppText(
                        text: value,
                        fontSize: 18.0,
                        color: AppColors.blackColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      genero = newValue!;
                    });
                  },
                  underline: Container(),
                  icon: const Icon(Icons.arrow_drop_down, color: AppColors.blackColor),
                  elevation: 8,
                  isExpanded: true,
                  dropdownColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  AppText(
                    text: "País",
                    fontSize: 12.0,
                    color: AppColors.blackColor,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.normal,
                  ),
                  Spacer()
                ],
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: AppColors.blackColor.withOpacity(0.7)),
                  color: Colors.white,
                ),
                child: DropdownButton<CountryCodes>(
                  value: selectedCountry,
                  items: countries.map((CountryCodes country) {
                    return DropdownMenuItem<CountryCodes>(
                      value: country,
                      child: AppText(
                        text: country.name,
                        fontSize: 16.0,
                        color: AppColors.blackColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (CountryCodes? newValue) {
                    setState(() {
                      selectedCountry = newValue!;
                    });
                  },
                  underline: Container(),
                  icon: const Icon(Icons.arrow_drop_down, color: AppColors.blackColor),
                  elevation: 8,
                  isExpanded: true,
                  dropdownColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  AppText(
                    text: "Idioma",
                    fontSize: 12.0,
                    color: AppColors.blackColor,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.normal,
                  ),
                  Spacer()
                ],
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: AppColors.blackColor.withOpacity(0.7)),
                  color: Colors.white,
                ),
                child: DropdownButton<Language>(
                  value: selectedLanguage,
                  items: languages.map((Language language) {
                    return DropdownMenuItem<Language>(
                      value: language,
                      child: AppText(
                        text: language.name,
                        fontSize: 16.0,
                        color: AppColors.blackColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (Language? newValue) {
                    setState(() {
                      selectedLanguage = newValue!;
                    });
                  },
                  underline: Container(),
                  icon: const Icon(Icons.arrow_drop_down, color: AppColors.blackColor),
                  elevation: 8,
                  isExpanded: true,
                  dropdownColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ExpandedButton(
                buttonColor: AppColors.primaryColor.withOpacity(1),
                onPressed: () async {
                  print('Button Pressed!');
                  print(nome);
                  print(sobrenome);
                  print(email);
                  print(posicao);
                  print(posicaoSecundaria);
                  print(genero);
                  print(selectedCountry!.name.toString());
                  print(selectedLanguage!.name.toString());
                  print(selectedLanguage!.code.toString());

                  await dataHandler.setStringValue(AppConstants.userName, nome);
                  await dataHandler.setStringValue(AppConstants.userSurname, sobrenome);
                  await dataHandler.setStringValue(AppConstants.userEmail, email);
                  await dataHandler.setStringValue(AppConstants.userPosition, posicao.toString());
                  await dataHandler.setStringValue(AppConstants.userSecondaryPosition, posicaoSecundaria.toString());
                  await dataHandler.setStringValue(AppConstants.genderValue, genero.toString());
                  await dataHandler.setStringValue(AppConstants.countryCode, selectedCountry!.code.toString());
                  await dataHandler.setStringValue(AppConstants.countryName, selectedCountry!.name.toString());
                  await dataHandler.setStringValue(AppConstants.langCode, selectedLanguage!.code.toString());
                  await dataHandler.setStringValue(AppConstants.langName, selectedLanguage!.name.toString());
                  await dataHandler.setStringValue(AppConstants.doneOnboarding, "YES");

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: const AppText(
                  text: "Começar a usar",
                  fontSize: 18.0,
                  color: AppColors.blackColor,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}