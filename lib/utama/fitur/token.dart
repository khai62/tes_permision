// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// void makeAuthenticatedRequest() async {
//   // Get the current user
//   User? user = FirebaseAuth.instance.currentUser;

//   if (user != null) {
//     // Get the ID token of the user
//     String token = await user.getIdToken();

//     // Use the token in your request
//     // For example, making a Firestore request
//     FirebaseFirestore.instance
//         .collection('your_collection')
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         print(doc["your_field"]);
//       });
//     });
//   } else {
//     // Handle the case when user is not authenticated
//     print('User is not authenticated');
//   }
// }
