import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

Future<void> submitLostItem({
  required String title,
  required String description,
  required String location,
  required DateTime date,
  File? imageFile,
}) async {
  try {
    String imageUrl = '';

    // Upload image to Firebase Storage if an image is provided
    if (imageFile != null) {
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('lost_items/${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
    }

    // Store lost item details in Firestore
    await FirebaseFirestore.instance.collection('lost_items').add({
      'title': title,
      'description': description,
      'location': location,
      'date': date.toIso8601String(),
      'imageUrl': imageUrl,
    });

    print("Lost item reported successfully!");
  } catch (e) {
    print("Error reporting lost item: $e");
  }
}
