class Purchase {
  final String customerId;
  final String purchaseAmount;

  Purchase({required this.customerId, required this.purchaseAmount});

  Map<String, String> toJson() {
    return {
      'customerId': customerId,
      'purchaseAmount': purchaseAmount,
    };
  }
}
