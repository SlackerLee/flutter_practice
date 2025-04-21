import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<UserProvider>().fetchUser("1");
            },
          ),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userProvider.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => userProvider.fetchUser("1"),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final user = userProvider.user;
          if (user == null) {
            return Center(
              child: ElevatedButton(
                onPressed: () => userProvider.fetchUser("1"),
                child: const Text('Load User'),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoCard(
                  title: 'Personal Information',
                  children: [
                    _buildInfoRow('Name', user.name),
                    _buildInfoRow('Username', user.username),
                    _buildInfoRow('Email', user.email),
                    _buildInfoRow('Phone', user.phone),
                    _buildInfoRow('Website', user.website),
                  ],
                ),
                const SizedBox(height: 16),
                _buildInfoCard(
                  title: 'Address',
                  children: [
                    _buildInfoRow('Street', user.address.street),
                    _buildInfoRow('Suite', user.address.suite),
                    _buildInfoRow('City', user.address.city),
                    _buildInfoRow('Zipcode', user.address.zipcode),
                    _buildInfoRow('Latitude', user.address.geo.lat),
                    _buildInfoRow('Longitude', user.address.geo.lng),
                  ],
                ),
                const SizedBox(height: 16),
                _buildInfoCard(
                  title: 'Company',
                  children: [
                    _buildInfoRow('Name', user.company.name),
                    _buildInfoRow('Catch Phrase', user.company.catchPhrase),
                    _buildInfoRow('BS', user.company.bs),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
} 