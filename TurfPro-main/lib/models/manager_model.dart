class ManagerModel {
  final String id;
  final String name;
  final String email;
  final String phone;

  ManagerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory ManagerModel.fromJson(Map<String, dynamic> json) {
    return ManagerModel(
      id: json['id'] ?? 'Unknown', 
      name: json['name'] ?? 'No Name',
      email: json['email'] ?? 'No Email',
      phone: json['phone'] ?? 'No Phone',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
