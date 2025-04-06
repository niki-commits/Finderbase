import 'package:flutter/material.dart';

class LostItemCard extends StatelessWidget {
  final String title;
  final String description;
  final String location;
  final String date;
  final String imageUrl;

  LostItemCard({
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            imageUrl.isNotEmpty
                ? Image.network(imageUrl, height: 60, width: 60, fit: BoxFit.cover)
                : Icon(Icons.image, size: 60, color: Colors.grey),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(description, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey),
                      Text(location),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      Text(date),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

