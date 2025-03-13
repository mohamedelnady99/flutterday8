import 'package:api_learn/data/model/user.dart';
import 'package:api_learn/data/repository/user_repo.dart';
import 'package:api_learn/data/web_services/user_web_services.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ApiLearn());
}

class ApiLearn extends StatelessWidget {
  const ApiLearn({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserListScreen(), // Set the home to the UserListScreen
    );
  }
}

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  UserListScreenState createState() => UserListScreenState();
}

class UserListScreenState extends State<UserListScreen> {
  late UserRepository userRepository;
  late Future<List<Users>> futureUsers; // Store future list of users

  @override
  void initState() {
    super.initState();
    // Initialize the repository and fetch the users
    UserWebServices userWebServices = UserWebServices();
    userRepository = UserRepository(userWebServices: userWebServices);
    futureUsers = userRepository.getUsers(); // Fetch users from page 2
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Users List'),
        ),
        body: FutureBuilder<List<Users>>(
          future: futureUsers,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No users found.'));
            } else {
              // Display users in a ListView
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final user = snapshot.data![index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar), // User avatar
                    ),
                    title:
                        Text('${user.firstName} ${user.lastName}'), // User name
                    subtitle: Text(user.email), // User email
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
