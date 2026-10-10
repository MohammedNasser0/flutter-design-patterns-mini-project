import 'payment_receipt.dart';

/// ISP: one operation. LSP: implementations honor the same positive-amount contract.
abstract interface class PaymentMethod {
  PaymentReceipt pay(int amountCents);
}
