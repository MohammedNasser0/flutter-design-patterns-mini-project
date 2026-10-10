import 'payment_method.dart';
import 'payment_processor.dart';
import 'payment_receipt.dart';

/// Assignment-compatible facade; strategies are injected at the composition edge.
class Payment {
  const Payment({
    required this._processor,
    required this._cash,
    required this._credit,
  });
  final PaymentProcessor _processor;
  final PaymentMethod _cash;
  final PaymentMethod _credit;
  PaymentReceipt cashPayment(int amountCents) =>
      _processor.process(_cash, amountCents);
  PaymentReceipt creditPayment(int amountCents) =>
      _processor.process(_credit, amountCents);
}
