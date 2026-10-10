import 'package:design_patterns_mini_project/payments/payment_method.dart';
import 'package:design_patterns_mini_project/payments/payment_receipt.dart';

class VoucherPayment implements PaymentMethod {
  @override
  PaymentReceipt pay(int amountCents) {
    if (amountCents <= 0) throw ArgumentError.value(amountCents);
    return PaymentReceipt(method: 'Voucher', amountCents: amountCents);
  }
}
