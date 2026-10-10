/// Shared positive minor-unit contract for all payment strategies.
class PaymentAmount {
  PaymentAmount._();
  static void validate(int amountCents) {
    if (amountCents <= 0) {
      throw ArgumentError.value(
        amountCents,
        'amountCents',
        'Amount must be positive.',
      );
    }
  }
}
