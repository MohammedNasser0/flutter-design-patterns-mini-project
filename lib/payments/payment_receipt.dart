class PaymentReceipt {
  const PaymentReceipt({required this.method, required this.amountCents});
  final String method;
  final int amountCents;
  @override
  String toString() =>
      '$method payment: ${(amountCents / 100).toStringAsFixed(2)} (simulation)';
}
