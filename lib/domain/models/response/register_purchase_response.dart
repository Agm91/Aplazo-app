class RegisterPurchaseResponse {
  final int purchaseId;

  RegisterPurchaseResponse({required this.purchaseId});

  factory RegisterPurchaseResponse.fromJson(Map<String, dynamic> json) {
    return RegisterPurchaseResponse(
      purchaseId: json['id'],
    );
  }
}
