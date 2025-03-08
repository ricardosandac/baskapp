class Session {
  final int id;
  final int courtId;
  final String name;
  final String type;
  final DateTime startDate;
  final DateTime? endDate;
  final String description; // Campo obrigatório
  final String? image; // Campo não obrigatório

  Session({
    required this.id,
    required this.courtId,
    required this.name,
    required this.startDate,
    this.type = 'Livre',
    this.endDate,
    required this.description, // Campo obrigatório
    this.image, // Campo não obrigatório
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      courtId: json['courtId'],
      name: json['name'],
      type: json['type'],
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      description: json['description'], // Campo obrigatório
      image: json['image'], // Campo não obrigatório
    );
  }

  /*Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courtId': courtId,
      'name': name,
      'type': type,
      'startDate': startDate,
      'endDate': endDate,
      'description': description, // Campo obrigatório
      'image': image, // Campo não obrigatório
    };
  }*/
}