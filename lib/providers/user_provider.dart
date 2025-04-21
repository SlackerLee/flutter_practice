import 'package:flutter/material.dart';

import '../models/user.dart';
import '../service/user_http_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _error;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Set user
  void setUser(User user) {
    _user = user;
    _error = null;
    notifyListeners();
  }

  // Clear user
  void clearUser() {
    _user = null;
    notifyListeners();
  }

  // Set loading state
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set error
  void setError(String error) {
    _error = error;
    _user = null;
    notifyListeners();
  }

  // Fetch user data
  Future<void> fetchUser(String userId) async {
    try {
      setLoading(true);
      setError('');

      // Simulate API call
     List<User> users = await UserHttpService.shared.getUserById(userId);
      setUser(users.first);
    } catch (e) {
      setError('Failed to fetch user: $e');
    } finally {
      setLoading(false);
    }
  }

  // Update user
  Future<void> updateUser(User updatedUser) async {
    try {
      setLoading(true);
      setError('');

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      setUser(updatedUser);
    } catch (e) {
      setError('Failed to update user: $e');
    } finally {
      setLoading(false);
    }
  }
} 