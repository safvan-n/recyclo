/// Payment transaction model
class PaymentTransaction {
  final String id;
  final String date;
  final String collector;
  final String wasteType;
  final String amount;
  final String method;
  final String status;
  final String reference;

  const PaymentTransaction({
    required this.id,
    required this.date,
    required this.collector,
    required this.wasteType,
    required this.amount,
    required this.method,
    required this.status,
    required this.reference,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'date': date,
    'collector': collector,
    'wasteType': wasteType,
    'amount': amount,
    'method': method,
    'status': status,
    'reference': reference,
  };

  factory PaymentTransaction.fromMap(Map<String, dynamic> map) => PaymentTransaction(
    id: map['id'] ?? '',
    date: map['date'] ?? '',
    collector: map['collector'] ?? '',
    wasteType: map['wasteType'] ?? '',
    amount: map['amount'] ?? '',
    method: map['method'] ?? '',
    status: map['status'] ?? 'Completed',
    reference: map['reference'] ?? '',
  );
}
