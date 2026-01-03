import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

// Screens
import 'screens/HomeScreen.dart';
import 'screens/ChatScreen.dart';
import 'screens/SettingsScreen.dart';
import 'screens/RemindersScreen.dart';
import 'screens/SchedulesScreen.dart';
import 'screens/MemoriesScreen.dart';
import 'screens/DiaryScreen.dart';
import 'screens/LoginScreen.dart';
import 'screens/FoodRecipes.dart';
import 'screens/Exercise.dart';
import 'screens/HealthTrackerScreen.dart';

// Controller
import 'controllers/UserController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserController()),
      ],
      child: MaterialApp(
        title: 'AI Assistant',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C5CE7)),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: false,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          ),
        ),
        darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C5CE7), brightness: Brightness.dark),
        ),
        themeMode: ThemeMode.system,

        // 🔑 Auth decides first screen
        home: const AuthWrapper(),

        // 🔁 Named routes (IMPORTANT)
        routes: {
          '/home': (_) => const HomeScreen(),
          '/login': (_) => LoginScreen(),
          '/chat': (_) => ChatScreen(),
          '/settings': (_) => SettingsScreen(),
          '/reminders': (_) => RemindersScreen(),
          '/schedules': (_) => SchedulesScreen(),
          '/memories': (_) => MemoriesScreen(),
          '/diary': (_) => DiaryScreen(),
          '/food': (_) => FoodRecipesScreen(),
          '/exercise': (_) => Exercise(),
          '/health-tracker': (_) => HealthTrackerScreen(),
        },
      ),
    );
  }
}

/// 🔐 AUTH DECISION LAYER
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, userController, _) {
        // ⏳ Loading
        if (userController.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // ❌ Not logged in
        if (userController.currentUser == null) {
          return LoginScreen();
        }

        // ✅ Logged in
        return const HomeScreen();
      },
    );
  }
}
