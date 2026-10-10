import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:design_patterns_mini_project/patterns/builder/user_builder.dart';
import 'package:design_patterns_mini_project/patterns/factory/shape_factory.dart';
import 'package:design_patterns_mini_project/patterns/factory/shape_client.dart';
import 'package:design_patterns_mini_project/patterns/factory/circle.dart';
import 'package:design_patterns_mini_project/patterns/factory/square.dart';
import 'package:design_patterns_mini_project/patterns/factory/rectangle.dart';
import 'package:design_patterns_mini_project/patterns/singleton/database.dart';
import 'package:design_patterns_mini_project/payments/payment.dart';
import 'package:design_patterns_mini_project/payments/payment_processor.dart';
import 'package:design_patterns_mini_project/payments/cash_payment.dart';
import 'package:design_patterns_mini_project/payments/credit_payment.dart';

import 'support/voucher_payment.dart';

void main() {
  test('Builder leaves unspecified attributes null', () {
    final user = UserBuilder()
        .setFirstName('Mohammed')
        .setLastName('Nasser')
        .build();
    expect(user.age, isNull);
    expect(user.phone, isNull);
  });
  test('Builder enforces both nonempty required names', () {
    expect(() => UserBuilder().build(), throwsStateError);
    expect(
      () => UserBuilder().setFirstName('Mohammed').build(),
      throwsStateError,
    );
    expect(
      () => UserBuilder().setFirstName(' ').setLastName('Nasser').build(),
      throwsStateError,
    );
  });
  test('Builder supports all fields and validates age', () {
    final user = UserBuilder()
        .setFirstName(' A ')
        .setLastName('B')
        .setAge(20)
        .setPhone('123')
        .build();
    expect(user.firstName, 'A');
    expect(user.age, 20);
    expect(user.phone, '123');
    expect(() => UserBuilder().setAge(-1), throwsArgumentError);
  });
  test('Factory produces concrete shapes and rejects unknown input', () {
    final factory = ShapeFactory();
    expect(factory.getShape(' CIRCLE '), isA<Circle>());
    expect(factory.getShape('square'), isA<Square>());
    expect(factory.getShape('rectangle'), isA<Rectangle>());
    expect(() => factory.getShape('triangle'), throwsArgumentError);
  });
  test('Shape client reveals all three shapes', () {
    final lines = <String>[];
    runZoned(
      () => ShapeClient(ShapeFactory()).run(),
      zoneSpecification: ZoneSpecification(
        print: (self, parent, zone, line) => lines.add(line),
      ),
    );
    expect(lines, [
      'you chose to print circle',
      'you chose to print square',
      'you chose to print rectangle',
    ]);
  });
  test('Database creates one shared instance', () {
    expect(
      identical(Database.createDatabase(), Database.createDatabase()),
      isTrue,
    );
  });
  test('Payment facade delegates both strategies', () {
    final payment = Payment(
      processor: const PaymentProcessor(),
      cash: CashPayment(),
      credit: CreditPayment(),
    );
    expect(payment.cashPayment(100).method, 'Cash');
    expect(payment.creditPayment(250).amountCents, 250);
  });
  test('All payment strategies honor positive-amount contract', () {
    for (final method in [CashPayment(), CreditPayment(), VoucherPayment()]) {
      expect(() => method.pay(0), throwsArgumentError);
      expect(() => method.pay(-1), throwsArgumentError);
      expect(method.pay(1).amountCents, 1);
    }
  });
  test('New strategy works without changing processor', () {
    expect(
      const PaymentProcessor().process(VoucherPayment(), 123).method,
      'Voucher',
    );
  });
}
