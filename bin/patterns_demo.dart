// Console demonstrations intentionally print their results.
// ignore_for_file: avoid_print
import 'package:design_patterns_mini_project/patterns/builder/user_client.dart';
import 'package:design_patterns_mini_project/patterns/factory/shape_client.dart';
import 'package:design_patterns_mini_project/patterns/factory/shape_factory.dart';
import 'package:design_patterns_mini_project/patterns/singleton/database_client.dart';
import 'package:design_patterns_mini_project/payments/payment.dart';
import 'package:design_patterns_mini_project/payments/payment_processor.dart';
import 'package:design_patterns_mini_project/payments/cash_payment.dart';
import 'package:design_patterns_mini_project/payments/credit_payment.dart';

void main(List<String> arguments) {
  final phase = arguments.isEmpty ? 'all' : arguments.first;
  if (phase == 'all' || phase == 'builder') {
    print('PHASE 1 | BUILDER');
    final user = UserClient().createPartialUser();
    print(user);
    print('Optional fields omitted: age=${user.age}, phone=${user.phone}');
  }
  if (phase == 'all' || phase == 'factory') {
    print('PHASE 2 | FACTORY');
    ShapeClient(ShapeFactory()).run();
  }
  if (phase == 'all' || phase == 'singleton') {
    print('PHASE 3 | SINGLETON');
    print(
      'Both Database instances are identical: ${DatabaseClient().hasSingleInstance()}',
    );
  }
  if (phase == 'all' || phase == 'payment') {
    print('PHASE 4 | SOLID PAYMENT SIMULATION');
    final payment = Payment(
      processor: const PaymentProcessor(),
      cash: CashPayment(),
      credit: CreditPayment(),
    );
    print(payment.cashPayment(12500));
    print(payment.creditPayment(25000));
  }
}
