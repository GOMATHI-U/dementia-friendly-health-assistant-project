import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  String? _userRole;
  bool _isLoading = true;

  User? get currentUser => _currentUser;
  String? get userRole => _userRole;
  bool get isLoading => _isLoading;

  UserController() {
    _initializeUser();
  }

  /// Initializes the user by checking authentication state and loading user role.
  void _initializeUser() {
    _auth.authStateChanges().listen((User? user) async {
      _currentUser = user;
      if (_currentUser != null) {
        await _loadUserRole();
      } else {
        _userRole = null;
      }
      _isLoading = false;
      notifyListeners();
    });
  }

  /// Logs in the user with the provided [email] and [password].
  /// Assigns a role based on the email and saves it locally.
  Future<String?> loginUser(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _currentUser = userCredential.user;

      if (_currentUser != null) {
        // Assign roles based on email pattern or other criteria
        _userRole = email.contains("caregiver") ? "Caregiver" : "User";
        await _saveUserRole(_userRole!);
      }
      return null;
    } catch (e) {
      return "Login failed: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Saves the user role [role] in local storage.
  Future<void> _saveUserRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_role', role);
  }

  /// Loads the user role from local storage.
  Future<void> _loadUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userRole = prefs.getString('user_role') ?? "User"; // Default role is User
  }

  /// Logs out the current user and clears the stored role.
  Future<void> logoutUser() async {
    _isLoading = true;
    notifyListeners();
    await _auth.signOut();
    _currentUser = null;
    _userRole = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_role');
    _isLoading = false;
    notifyListeners();
  }
}
