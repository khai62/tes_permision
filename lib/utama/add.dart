import 'dart:io';
import 'package:tes/pustaka.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerQuantity = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('shopping_list');

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add an item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: Column(
            children: [
              TextFormField(
                controller: _controllerName,
                decoration: const InputDecoration(
                    hintText: 'Enter the name of the item'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerQuantity,
                decoration: const InputDecoration(
                    hintText: 'Enter the quantity of the item'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item quantity';
                  }
                  return null;
                },
              ),
              IconButton(
                onPressed: () async {
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  print('${file?.path}');

                  if (file == null) return;

                  // Menggunakan ID dokumen Firestore sebagai bagian dari nama file
                  String documentId =
                      _reference.doc().id; // Generate a new document ID
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDirImages = referenceRoot.child('images');
                  Reference referenceImageToUpload =
                      referenceDirImages.child(documentId);

                  try {
                    await referenceImageToUpload.putFile(File(file.path));
                    imageUrl = await referenceImageToUpload.getDownloadURL();
                    setState(() {}); // Update the UI with the new image URL
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Error uploading image: $error')));
                  }
                },
                icon: const Icon(Icons.image),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (imageUrl.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please upload an image')));
                    return;
                  }

                  if (key.currentState!.validate()) {
                    String itemName = _controllerName.text;
                    String itemQuantity = _controllerQuantity.text;

                    Map<String, String> dataToSend = {
                      'name': itemName,
                      'quantity': itemQuantity,
                      'image': imageUrl,
                    };

                    await _reference.add(dataToSend);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Item added successfully')));
                  }

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));

                  setState(() {
                    _controllerName.clear();
                    _controllerQuantity.clear();
                    imageUrl = '';
                  });
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
