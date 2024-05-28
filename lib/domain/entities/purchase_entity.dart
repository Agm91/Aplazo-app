class PurchaseEntity {
  final int? id;
  final String customerId;
  final double amount;

  PurchaseEntity({this.id, required this.customerId, required this.amount});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'amount': amount,
    };
  }

  factory PurchaseEntity.fromMap(Map<String, dynamic> map) {
    return PurchaseEntity(
      id: map['id'],
      customerId: map['customerId'],
      amount: map['amount'],
    );
  }
}
