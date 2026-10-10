import 'payment_amount.dart';
import 'payment_method.dart';
import 'payment_receipt.dart';

/// SRP: models only cash payments, with no UI, storage or real transactions.
class CashPayment implements PaymentMethod {
  @override
  PaymentReceipt pay(int amountCents) {
    PaymentAmount.validate(amountCents);
    return PaymentReceipt(method: 'Cash', amountCents: amountCents);
  }
}
