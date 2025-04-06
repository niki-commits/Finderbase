import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'lost_found_provider.dart';

class FoundForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lostFoundProvider = Provider.of<LostFoundProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Report Found Item"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select the item you found:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  if (lostFoundProvider.lostItems.isEmpty)
                    Text(
                      "No lost items reported!",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  if (lostFoundProvider.lostItems.isNotEmpty)
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      hint: Text("Select an item"),
                      items: lostFoundProvider.lostItems.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (selectedItem) {
                        if (selectedItem != null) {
                          _confirmFoundItem(context, lostFoundProvider, selectedItem);
                        }
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _confirmFoundItem(BuildContext context, LostFoundProvider provider, String item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm"),
        content: Text("Are you sure you found \"$item\"?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              provider.markItemAsFound(item);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("$item has been marked as found!")),
              );
              Navigator.pop(context);
            },
            child: Text("Yes, Mark as Found"),
          ),
        ],
      ),
    );
  }
}
