import 'payment_method.dart';
import 'payment_receipt.dart';

/// DIP: depends on an abstraction. OCP: new methods need no processor changes.
class PaymentProcessor {
  const PaymentProcessor();
  PaymentReceipt process(PaymentMethod method, int amountCents) =>
      method.pay(amountCents);
}
