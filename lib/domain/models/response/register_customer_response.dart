class RegisterCustomerResponse {
  final int customerId;
  final double creditAmount;

  RegisterCustomerResponse(
      {required this.customerId, required this.creditAmount});

  factory RegisterCustomerResponse.fromJson(Map<String, dynamic> json) {
    return RegisterCustomerResponse(
      customerId: json['id'],
      creditAmount: json['amount'].toDouble(),
    );
  }
}
