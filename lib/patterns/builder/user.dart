class User {
  const User({
    required this.firstName,
    required this.lastName,
    this.age,
    this.phone,
  });
  final String firstName;
  final String lastName;
  final int? age;
  final String? phone;
  @override
  String toString() =>
      'User(firstName: $firstName, lastName: $lastName${age == null ? '' : ', age: $age'}${phone == null ? '' : ', phone: $phone'})';
}
