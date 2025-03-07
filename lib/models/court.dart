class Court {
  final int id;
  final String name;
  final String address;
  final String addressSTR;
  final String? description;
  final String? status;

  Court({required this.id, 
  required this.name, 
  required this.address, 
  required this.addressSTR,
  this.description,
  this.status});

  factory Court.fromJson(Map<String, dynamic> json) {
    return Court(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      addressSTR: json['addressSTR'],
      description: json['description'],
      status: json['status']
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id,
    'name': name,
    'address': address,
    'addressSTR': addressSTR,
    'description': description,
    'status': status};
  }
}