import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tes/pustaka.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key}) {
    _stream = _reference.snapshots();
  }

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('shopping_list');

  late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          // Check if data is available
          if (snapshot.hasData) {
            // Get the data
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            // Convert the documents to Maps
            List<Map<String, dynamic>> items = documents.map((e) {
              Map<String, dynamic> data = e.data() as Map<String, dynamic>;
              data['id'] = e.id; // Add the document ID to the data map
              return data;
            }).toList();

            // Display the list
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                // Get the item at this index
                Map<String, dynamic> thisItem = items[index];

                // Return the widget for the list items
                return ListTile(
                  title: Text('${thisItem['name']}'),
                  subtitle: Text('${thisItem['quantity']}'),
                  leading: SizedBox(
                    height: 80,
                    width: 80,
                    child: thisItem.containsKey('image') &&
                            thisItem['image'] != null
                        ? Image.network(
                            '${thisItem['image']}',
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color:
                                Colors.grey), // Placeholder for missing image
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ItemDetails(thisItem['id']),
                    ));
                  },
                );
              },
            );
          }

          // Show loader
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddScreen()));
        },
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
