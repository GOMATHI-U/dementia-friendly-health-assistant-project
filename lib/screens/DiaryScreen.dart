import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final TextEditingController _diaryController = TextEditingController();
  final CollectionReference diary = FirebaseFirestore.instance.collection('diary_entries');

  Future<void> addDiaryEntry() async {
    if (_diaryController.text.isNotEmpty) {
      await diary.add({'entry': _diaryController.text, 'timestamp': Timestamp.now()});
      _diaryController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Diary')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _diaryController,
              decoration: InputDecoration(labelText: 'Write Entry', suffixIcon: IconButton(
                icon: Icon(Icons.add),
                onPressed: addDiaryEntry,
              )),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: diary.orderBy('timestamp', descending: true).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return ListTile(
                      title: Text(doc['entry']),
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
