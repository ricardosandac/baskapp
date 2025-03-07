class Session {
  final int id;
  final int courtId;
  final String name;
  final String type;
  final DateTime startDate;
  final DateTime? endDate;

  Session({required this.id, 
  required this.courtId,
  required this.name,
  required this.startDate,
  this.type = 'Livre',
  this.endDate});

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      courtId: json['courtId'],
      name: json['name'],
      type: json['type'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate'])
    );
  }

  /*Map<String, dynamic> toJson() {
    return {'id': id,
    'courtId': courtId,
    'name': name,
    'type': type,
    'startDate':startDate,
    'endDate': endDate};
  }*/
}