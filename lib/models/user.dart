class User {
  final int id;
  final String name;
  final String ?surname;
  final String email;
  final Enum ?role;
  final Enum ?secondRole;
  final String address;
  final String ?description;

  User({required this.id, 
  required this.name, 
  required this.email,
  required this.address,
  this.surname,
  this.role,
  this.secondRole,
  this.description,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      role: json['role'],
      secondRole: json['secondRole'],
      address: json['address'],
      description: json['description']
    );
  }

  /*Map<String, dynamic> toJson() {
    return {'id': id, 
    'name': name, 
    'surname': surname, 
    'email':email,
    'role': role, 
    'secondRole': secondRole, 
    'address': address, 
    'description': description};
  }*/
}