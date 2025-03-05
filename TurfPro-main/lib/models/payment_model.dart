class PaymentModel {
  final String id;
  final String customerName;
  final double amount;
  final String status;

  PaymentModel({
    required this.id,
    required this.customerName,
    required this.amount,
    required this.status,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['_id'], 
      customerName: json['customerName'],
      amount: json['amount'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'customerName': customerName,
      'amount': amount,
      'status': status,
    };
  }
}
