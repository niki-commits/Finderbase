import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/lost_item_card.dart';

class LostItemsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lost & Found")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('lost_items').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No lost items found."));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              return LostItemCard(
                title: data['title'],
                description: data['description'],
                location: data['location'],
                date: data['date'],
                imageUrl: data['imageUrl'],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
