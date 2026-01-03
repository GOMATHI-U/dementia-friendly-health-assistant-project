import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SchedulesScreen extends StatefulWidget {
  @override
  _SchedulesScreenState createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen> {
  final TextEditingController _scheduleController = TextEditingController();
  final CollectionReference schedules = FirebaseFirestore.instance.collection('schedules');

  // Add new schedule
  Future<void> addSchedule() async {
    if (_scheduleController.text.isNotEmpty) {
      try {
        await schedules.add({
          'title': _scheduleController.text.trim(), // Trim extra spaces
          'timestamp': Timestamp.now(),
        });
        _scheduleController.clear();
      } catch (e) {
        print("Error adding schedule: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add schedule!'))
        );
      }
    }
  }

  // Delete a schedule
  Future<void> deleteSchedule(DocumentReference docRef) async {
    try {
      await docRef.delete();
    } catch (e) {
      print("Error deleting schedule: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete schedule!'))
      );
    }
  }

  @override
  void dispose() {
    _scheduleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Schedules')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _scheduleController,
              decoration: InputDecoration(
                labelText: 'Enter Schedule',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: addSchedule,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: schedules.orderBy('timestamp', descending: true).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No schedules yet. Add one!'));
                }

                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return ListTile(
                      title: Text(doc['title']),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteSchedule(doc.reference),
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
