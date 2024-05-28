class Customer {
  final String name;
  final String birthDate;

  Customer({required this.name, required this.birthDate});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthDate': birthDate,
    };
  }
}
