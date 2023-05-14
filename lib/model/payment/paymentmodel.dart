class Transaction {
  final String statusCode;
  final String statusMessage;
  final String transactionId;
  final String orderId;
  final String merchantId;
  final String grossAmount;
  final String currency;
  final String paymentType;
  final DateTime transactionTime;
  final String transactionStatus;
  final String fraudStatus;
  final List<Map<String, dynamic>> actions;
  final DateTime expiryTime;

  Transaction({
    required this.statusCode,
    required this.statusMessage,
    required this.transactionId,
    required this.orderId,
    required this.merchantId,
    required this.grossAmount,
    required this.currency,
    required this.paymentType,
    required this.transactionTime,
    required this.transactionStatus,
    required this.fraudStatus,
    required this.actions,
    required this.expiryTime,
  });
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      statusCode: json['status_code'],
      statusMessage: json['status_message'],
      transactionId: json['transaction_id'],
      orderId: json['order_id'],
      merchantId: json['merchant_id'],
      grossAmount: json['gross_amount'].toString(),
      currency: json['currency'],
      paymentType: json['payment_type'],
      transactionTime: DateTime.parse(json['transaction_time']),
      transactionStatus: json['transaction_status'],
      fraudStatus: json['fraud_status'],
      actions: List<Map<String, dynamic>>.from(json['actions']),
      expiryTime: DateTime.parse(json['expiry_time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status_code': statusCode,
      'status_message': statusMessage,
      'transaction_id': transactionId,
      'order_id': orderId,
      'merchant_id': merchantId,
      'gross_amount': grossAmount,
      'currency': currency,
      'payment_type': paymentType,
      'transaction_time': transactionTime.toIso8601String(),
      'transaction_status': transactionStatus,
      'fraud_status': fraudStatus,
      'actions': actions,
      'expiry_time': expiryTime.toIso8601String(),
    };
  }
}
