import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';
import '../../service/user_http_service.dart';

// Define providers
final userProvider = StateNotifierProvider<UserNotifier, AsyncValue<User?>>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<AsyncValue<User?>> {
  UserNotifier() : super(const AsyncValue.data(null));

  Future<void> fetchUser() async {
    state = const AsyncValue.loading();
    try {// Simulate API call
      final user = await UserHttpService.shared.getUsers();
      state = AsyncValue.data(user.first);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void updateUser(String name, String email) {
    state.whenData((user) {
      if (user != null) {
        final updatedUser = User(
          id: user.id,
          name: name,
          username: user.username,
          email: email,
          address: user.address,
          phone: user.phone,
          website: user.website,
          company: user.company,
        );
        state = AsyncValue.data(updatedUser);
      }
    });
  }
}

class UserRiverpodScreen extends ConsumerWidget {
  const UserRiverpodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod User Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(userProvider.notifier).fetchUser(),
          ),
        ],
      ),
      body: userState.when(
        data: (user) {
          if (user == null) {
            return Center(
              child: ElevatedButton(
                onPressed: () => ref.read(userProvider.notifier).fetchUser(),
                child: const Text('Load User'),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${user.name}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Email: ${user.email}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Update User',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                _UpdateUserForm(),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error: $error',
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.read(userProvider.notifier).fetchUser(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UpdateUserForm extends ConsumerStatefulWidget {
  @override
  _UpdateUserFormState createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends ConsumerState<_UpdateUserForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            if (_nameController.text.isNotEmpty && 
                _emailController.text.isNotEmpty) {
              ref.read(userProvider.notifier).updateUser(
                _nameController.text,
                _emailController.text,
              );
              _nameController.clear();
              _emailController.clear();
            }
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
} 