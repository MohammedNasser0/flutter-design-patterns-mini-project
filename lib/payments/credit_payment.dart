import 'payment_amount.dart';
import 'payment_method.dart';
import 'payment_receipt.dart';

/// SRP: models only credit payments, with no UI, storage or real transactions.
class CreditPayment implements PaymentMethod {
  @override
  PaymentReceipt pay(int amountCents) {
    PaymentAmount.validate(amountCents);
    return PaymentReceipt(method: 'Credit', amountCents: amountCents);
  }
}
