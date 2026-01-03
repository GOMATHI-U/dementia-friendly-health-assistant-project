import 'package:flutter/material.dart';

// Screens
import 'RemindersScreen.dart';
import 'HealthTrackerScreen.dart';
import 'MemoriesScreen.dart';
import 'SettingsScreen.dart';
import 'ChatScreen.dart';

/// This is the class expected by main.dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreenDementia();
  }
}

class HomeScreenDementia extends StatefulWidget {
  const HomeScreenDementia({super.key});

  @override
  State<HomeScreenDementia> createState() => _HomeScreenDementiaState();
}

class _HomeScreenDementiaState extends State<HomeScreenDementia> {
  String _currentTime = "";

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    final now = DateTime.now();
    final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';

    setState(() {
      _currentTime = "$hour:$minute $period";
    });

    Future.delayed(const Duration(minutes: 1), _updateTime);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int columns;
    if (width < 600) {
      columns = 2; // mobile
    } else if (width < 1000) {
      columns = 3; // tablet
    } else {
      columns = 4; // desktop / web
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8E44AD), Color(0xFF5E60CE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),

            _buildTimeDisplay(),

            const SizedBox(height: 20),

            const Text(
              "Hello! Let's take care of you",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            /// ✅ FIXED GRID (Responsive)
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: _menuItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final item = _menuItems[index];
                  return _menuCard(
                    icon: item.icon,
                    label: item.label,
                    screen: item.screen,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _currentTime,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _menuCard({
    required IconData icon,
    required String label,
    required Widget screen,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.deepPurple),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Menu model
class _MenuItem {
  final IconData icon;
  final String label;
  final Widget screen;

  _MenuItem(this.icon, this.label, this.screen);
}

/// Menu data
final List<_MenuItem> _menuItems = [
  _MenuItem(Icons.alarm, "Reminders", RemindersScreen()),
  _MenuItem(Icons.favorite, "Health Tracker", HealthTrackerScreen()),
  _MenuItem(Icons.memory, "Memories", MemoriesScreen()),
  _MenuItem(Icons.chat, "Chat", ChatScreen()),
  _MenuItem(Icons.settings, "Settings", SettingsScreen()),
];
