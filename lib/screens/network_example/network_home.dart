import 'package:flutter/material.dart';
import 'package:info/service/user_http_service.dart';

class NetworkHome extends StatefulWidget {
  const NetworkHome({super.key});

  @override
  State<NetworkHome> createState() => _NetworkHomeState();

}

class _NetworkHomeState extends State<NetworkHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Network Example'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, '/');
          },
        ),
      ),
      body: FutureBuilder(future: UserHttpService.shared.getUsers(), builder:
        (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final users = snapshot.data;
            return ListView.builder(
              itemCount: users?.length,
              itemBuilder: (context, index) {
                final user = users?[index];
                return ListTile(
                  title: Text(user?.name ?? ''),
                  subtitle: Text(user?.email ?? ''),
                );
              },
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      )
    );
  }
}