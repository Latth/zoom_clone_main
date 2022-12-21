import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zoom_clone_main/resources/firestore_methods.dart';

class HistoryMeetingScreen extends StatelessWidget {
  const HistoryMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreMethods().meetingsHistory,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: ((context, index) => ListTile(
                title: Text(
                    "Room Name: ${snapshot.data!.docs[index]['meetingName']}"),
                subtitle: Text(
                    "Joined on: ${DateFormat.yMEd().format(snapshot.data!.docs[index]['createdAt'].toDate())}"),
              )),
        );
      }),
    );
  }
}
