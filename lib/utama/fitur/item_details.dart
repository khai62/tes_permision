import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:tes/pustaka.dart';

// ignore: must_be_immutable
class ItemDetails extends StatelessWidget {
  ItemDetails(this.itemId, {super.key}) {
    _reference =
        FirebaseFirestore.instance.collection('shopping_list').doc(itemId);
    _futureData = _reference.get();
  }

  String itemId;
  late DocumentReference _reference;

  //_reference.get()  --> returns Future<DocumentSnapshot>
  //_reference.snapshots() --> Stream<DocumentSnapshot>
  late Future<DocumentSnapshot> _futureData;
  late Map data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item details'),
        actions: [
          IconButton(
              onPressed: () {
                //add the id to the map
                data['id'] = itemId;

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditItem(data)));
              },
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                //Delete the item
                _deleteItem(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            //Get the data
            DocumentSnapshot documentSnapshot = snapshot.data;
            data = documentSnapshot.data() as Map;

            //display the data
            return Column(
              children: [
                Text('${data['name']}'),
                Text('${data['quantity']}'),
              ],
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  // Function to delete item and its image
  void _deleteItem(BuildContext context) async {
    try {
      // Delete the item from Firestore
      await _reference.delete();

      // Periksa apakah URL gambar ada dan tidak null
      if (data.containsKey('image') && data['image'] != null) {
        String imageUrl = data['image'];
        Reference imageReference =
            FirebaseStorage.instance.refFromURL(imageUrl);

        // Coba hapus gambar dan tangani potensi kesalahan
        try {
          await imageReference.delete();
        } catch (storageError) {
          print("Kesalahan saat menghapus gambar: $storageError");
          // Tangani kesalahan khusus penyimpanan di sini (opsional)
        }
      }

      // Navigate back to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting item: $error')),
      );
    }
  }
}
