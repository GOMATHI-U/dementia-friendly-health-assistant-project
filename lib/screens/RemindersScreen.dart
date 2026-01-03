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
      appBar: AppBar(title: Text('Reminders')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _reminderController,
              decoration: InputDecoration(labelText: 'Enter Reminder', suffixIcon: IconButton(
                icon: Icon(Icons.add),
                onPressed: addReminder,
              )),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: reminders.orderBy('timestamp', descending: true).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return ListTile(
                      title: Text(doc['title']),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => doc.reference.delete(),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
