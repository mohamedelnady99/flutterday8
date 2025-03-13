import 'package:api_learn/data/model/user.dart';
import 'package:api_learn/data/web_services/user_web_services.dart';

class UserRepository {
  final UserWebServices userWebServices;

  // Constructor: Inject the UserWebServices dependency
  UserRepository({required this.userWebServices});

  // Method to get the list of users
  Future<List<Users>> getUsers() async {
    final List<dynamic> usersData = await userWebServices.fetchUsers();

    // Convert each user data from API to a User model object
    return usersData.map((user) => Users.fromJson(user)).toList();
  }
}
