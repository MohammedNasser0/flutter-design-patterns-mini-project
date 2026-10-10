import 'user.dart';
import 'user_builder.dart';

class UserClient {
  User createPartialUser() =>
      UserBuilder().setFirstName('Mohammed').setLastName('Nasser').build();
}
