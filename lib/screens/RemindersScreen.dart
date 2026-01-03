import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemindersScreen extends StatefulWidget {
  @override
  _RemindersScreenState createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  final TextEditingController _reminderController = TextEditingController();
  final CollectionReference reminders = FirebaseFirestore.instance.collection('reminders');

  Future<void> addReminder() async {
    if (_reminderController.text.isNotEmpty) {
      await reminders.add({'title': _reminderController.text, 'timestamp': Timestamp.now()});
      _reminderController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reminders'), backgroundColor: Colors.transparent, elevation: 0,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _reminderController,
                        decoration: const InputDecoration(
                          hintText: 'Enter reminder...',
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) => addReminder(),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Color(0xFF6C5CE7), size: 28),
                      onPressed: addReminder,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: StreamBuilder(
                stream: reminders.orderBy('timestamp', descending: true).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                  final docs = snapshot.data!.docs;
                  if (docs.isEmpty) {
                    return const Center(child: Text('No reminders yet', style: TextStyle(color: Colors.black54)));
                  }
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final ts = doc['timestamp'] as Timestamp?;
                      final timeStr = ts != null ? (ts as Timestamp).toDate().toLocal().toString() : '';
                      return Dismissible(
                        key: ValueKey(doc.id),
                        direction: DismissDirection.endToStart,
                        background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Icon(Icons.delete, color: Colors.white)),
                        confirmDismiss: (_) async {
                          final ok = await showDialog<bool>(context: context, builder: (c) => AlertDialog(
                            title: const Text('Delete reminder?'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
                              TextButton(onPressed: () => Navigator.pop(c, true), child: const Text('Delete')),
                            ],
                          ));
                          if (ok == true) {
                            await doc.reference.delete();
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reminder deleted')));
                          }
                          return ok;
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(doc['title']),
                            subtitle: timeStr.isNotEmpty ? Text(timeStr, style: const TextStyle(fontSize: 12)) : null,
                            trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () async {
                              final ok = await showDialog<bool>(context: context, builder: (c) => AlertDialog(
                                title: const Text('Delete reminder?'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
                                  TextButton(onPressed: () => Navigator.pop(c, true), child: const Text('Delete')),
                                ],
                              ));
                              if (ok == true) {
                                await doc.reference.delete();
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reminder deleted')));
                              }
                            }),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
