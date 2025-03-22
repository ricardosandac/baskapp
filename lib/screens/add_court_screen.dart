import 'package:flutter/material.dart';
import '../models/court.dart';
import '../services/court_service.dart';
import '../utils/appcolors.dart';
import '../utils/apptext.dart'; // Caso o botão utilize AppText

class AddCourtScreen extends StatefulWidget {
  @override
  _AddCourtScreenState createState() => _AddCourtScreenState();
}

class _AddCourtScreenState extends State<AddCourtScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _addressStrController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _status = "active"; // Default status
  final CourtApiService apiService = CourtApiService();

  void _addCourt() {
    final newCourt = Court(
      id: 9,
      name: _nameController.text,
      address: _addressController.text,
      addressSTR: _addressStrController.text,
      description: _descriptionController.text,
      status: _status,
    );

    debugPrint('New court to add: $newCourt');

    apiService.addCourt(newCourt).then((_) {
      debugPrint('Court added successfully');
      if (mounted) {
        Navigator.pop(context, true); // Retorna true para indicar que a lista deve ser recarregada
      }
    }).catchError((error) {
      debugPrint('Error adding court: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Quadra'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome da Quadra',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Endereço',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _addressStrController,
              decoration: InputDecoration(
                labelText: 'Endereço Simplificado',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _status,
              items: [
                DropdownMenuItem(value: "active", child: Text("Ativo")),
                DropdownMenuItem(value: "under_maintenance", child: Text("Em manutenção")),
                DropdownMenuItem(value: "closed", child: Text("Fechado")),
              ],
              onChanged: (value) {
                setState(() {
                  _status = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity, // Botão ocupa toda a largura
              child: ElevatedButton(
                onPressed: _addCourt,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16), // Altura do botão
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Bordas arredondadas
                  ),
                ),
                child: AppText(
                  text: 'Adicionar',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}