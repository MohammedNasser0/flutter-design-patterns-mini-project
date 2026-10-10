import 'user.dart';

/// Builder accumulates optional attributes and enforces required names at build.
class UserBuilder {
  String? _firstName;
  String? _lastName;
  int? _age;
  String? _phone;
  UserBuilder setFirstName(String value) {
    _firstName = value.trim();
    return this;
  }

  UserBuilder setLastName(String value) {
    _lastName = value.trim();
    return this;
  }

  UserBuilder setAge(int value) {
    if (value < 0) throw ArgumentError.value(value, 'age');
    _age = value;
    return this;
  }

  UserBuilder setPhone(String value) {
    _phone = value.trim();
    return this;
  }

  User build() {
    if (_firstName == null ||
        _firstName!.isEmpty ||
        _lastName == null ||
        _lastName!.isEmpty) {
      throw StateError('First Name and Last Name are required.');
    }
    return User(
      firstName: _firstName!,
      lastName: _lastName!,
      age: _age,
      phone: _phone,
    );
  }
}
