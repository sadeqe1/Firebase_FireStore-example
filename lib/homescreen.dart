import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  List<Widget> makelistwidget(AsyncSnapshot snapshot) {
    return snapshot.data.docs.map<Widget>((docs) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Text(docs["name"]),
            subtitle: Text(docs["gander"]),
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Fire Store'),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('user').snapshots(),
          builder: (context, snapshots) {
            if (!snapshots.hasData)
              return Center(child: CircularProgressIndicator());
            return ListView(
              children: makelistwidget(snapshots),
            );
          },
        ),
      ),
    );
  }
}
