import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/UserController.dart';

/// 👤 User Roles
enum UserRole { patient, caregiver }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;
  UserRole _selectedRole = UserRole.patient; // ✅ Default

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userController = context.read<UserController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F4FB),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // 🧠 App Title
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Please sign in to continue",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),

                const SizedBox(height: 32),

                // 🧾 Login Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // 👥 Role Selector
                      Row(
                        children: [
                          Expanded(
                            child: _roleButton(
                              title: "Patient",
                              icon: Icons.person,
                              selected: _selectedRole == UserRole.patient,
                              onTap: () {
                                setState(() {
                                  _selectedRole = UserRole.patient;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _roleButton(
                              title: "Caregiver",
                              icon: Icons.medical_services,
                              selected: _selectedRole == UserRole.caregiver,
                              onTap: () {
                                setState(() {
                                  _selectedRole = UserRole.caregiver;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // 📧 Email
                      _buildField(
                        controller: _emailController,
                        label: "Email",
                        icon: Icons.email,
                      ),

                      const SizedBox(height: 16),

                      // 🔒 Password
                      _buildField(
                        controller: _passwordController,
                        label: "Password",
                        icon: Icons.lock,
                        obscure: true,
                      ),

                      const SizedBox(height: 24),

                      // 🔘 Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: _loading
                              ? null
                              : () async {
                                  setState(() => _loading = true);

                                  debugPrint(
                                      "Logging in as $_selectedRole");

                                  final error =
                                      await userController.loginUser(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                  );

                                  if (!mounted) return;

                                  setState(() => _loading = false);

                                  if (error != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(error),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                  // ✅ AuthWrapper will handle navigation
                                },
                          child: _loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ℹ️ Helper Text
                const Text(
                  "If you need help signing in,\nplease contact your caregiver.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Input Field
  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(fontSize: 18),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  // 🔹 Role Button
  Widget _roleButton({
    required String title,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: selected ? Colors.deepPurple : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selected ? Colors.white : Colors.black54,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
