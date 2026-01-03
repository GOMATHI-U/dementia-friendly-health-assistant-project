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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.health_and_safety, color: Color(0xFF6C5CE7))),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Good day", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              Text("Care Assistant — $_currentTime", style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.95))),
            ])
          ],
        ),
        actions: [
          IconButton(onPressed: () => Navigator.pushNamed(context, '/settings'), icon: const Icon(Icons.settings, color: Colors.white)),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.only(top: 80),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7C4DFF), Color(0xFF6C5CE7)],
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0,4))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Current time", style: TextStyle(fontSize: 12, color: Colors.black54)),
              const SizedBox(height: 6),
              Text(_currentTime, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ]),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/reminders'),
              icon: const Icon(Icons.alarm),
              label: const Text("Reminders"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard({
    required IconData icon,
    required String label,
    required Widget screen,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
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
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(colors: [Color(0xFFEDE7FF), Color(0xFFD7C8FF)]),
                ),
                child: Icon(icon, size: 36, color: const Color(0xFF6C5CE7)),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A2FA3),
                ),
              ),
            ],
          ),
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
