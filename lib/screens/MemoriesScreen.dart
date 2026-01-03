import 'package:flutter/material.dart';

class MemoriesScreen extends StatelessWidget {
  /// ✅ MUST be static const for const constructor to work
  static const String defaultImage1 =
      "https://images.unsplash.com/photo-1533616688419-b7a585564566?w=200";
  static const String defaultImage2 =
      "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=200";
  static const String defaultImage3 =
      "https://images.unsplash.com/photo-1529335764857-3f1164d1cb24?w=200";

  const MemoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Memories"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Edit Contacts
            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.contacts),
                label: const Text("Edit Contacts"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Add Memory
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Add Memory"),
              ),
            ),

            const SizedBox(height: 20),

            /// Memory Cards
            _buildMemoryCard(
              "Birthday Joy",
              "Grandma’s birthday celebration in the backyard.",
              defaultImage1,
            ),
            _buildMemoryCard(
              "Family Bond",
              "Family reunion with kids running around.",
              defaultImage2,
            ),
            _buildMemoryCard(
              "Lake Serenity",
              "Relaxing fishing trip by the peaceful lake.",
              defaultImage3,
            ),

            const SizedBox(height: 20),

            /// Goals
            const Text(
              "Goal Setting and Reminders",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Set a Goal 🎯",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 4),

            Text(
              "Create up to 5 custom goals for your loved one and track their progress.",
              style: TextStyle(color: Colors.grey[700]),
            ),

            const SizedBox(height: 20),

            /// Reminders
            const Text(
              "Upcoming Reminders",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            _buildReminderCard(
              "Afternoon Snack (2:30pm - 3:00pm)",
              "Mon, Wed, Fri",
              Icons.local_dining,
            ),
            _buildReminderCard(
              "Care Tasks (Daily 10:00am)",
              "",
              Icons.health_and_safety,
            ),
          ],
        ),
      ),
    );
  }

  /// Memory Card
  static Widget _buildMemoryCard(
    String title,
    String subtitle,
    String imageUrl,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title:
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }

  /// Reminder Card
  static Widget _buildReminderCard(
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: Icon(icon, color: Colors.deepPurple),
        title:
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
      ),
    );
  }
}
