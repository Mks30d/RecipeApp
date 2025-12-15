import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SaveDetails extends StatelessWidget {
  const SaveDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference recipeCollection = FirebaseFirestore.instance
        .collection("recipes");
    // final imageUrl = "https://tse1.mm.bing.net/th/id/OIP.fgEb3K-H9k8ovUMpQhnQxgHaFj?rs=1&pid=ImgDetMain&o=7&rm=3"; // panner
    // final imageUrl = "https://th.bing.com/th/id/OIP.w6YULaQyOnQCtsGT0Ka5CwHaLG?w=190&h=285&c=7&r=0&o=7&cb=ucfimg2&dpr=1.2&pid=1.7&rm=3&ucfimg=1"; // chowmein
    final imageUrl = "https://tse1.explicit.bing.net/th/id/OIP.6Nx_C1m4YCujBiHe48YpHAHaE8?rs=1&pid=ImgDetMain&o=7&rm=3"; // dosa
    final ingredientsUrl1 = "https://tse4.mm.bing.net/th/id/OIP.Q671BE_Ll3cktooX5CpLWgHaEo?cb=ucfimg2&ucfimg=1&w=1080&h=675&rs=1&pid=ImgDetMain&o=7&rm=3";
    final ingredientsUrl2 = "https://th.bing.com/th/id/OIP.MkBFufZRO7kPC-EFjzUWcwHaE8?w=225&h=181&c=7&r=0&o=7&dpr=1.2&pid=1.7&rm=3";
    final ingredientsUrl3 = "https://th.bing.com/th/id/OIP.Jm5JUAOE_U6f9vYAA0_nyAHaEK?w=329&h=185&c=7&r=0&o=7&dpr=1.2&pid=1.7&rm=3";
    final ingredientsUrl4 = "https://th.bing.com/th/id/OIP.TjCyBvquEHVqnZQwvRuAggHaE7?w=269&h=180&c=7&r=0&o=7&dpr=1.2&pid=1.7&rm=3";

    Future<void> saveDetails() async {
      try {
        await recipeCollection.doc().set({
          'name': 'Dosa',
          "rating": 4.77,
          "calories": 220,
          "category": "Dinner",
          'ingredients': ['Ingredient 1', 'Ingredient 2', 'Ingredient 3', 'Ingredient 4'],
          "time": 30,
          "imageUrl": imageUrl,
          "ingredientsAmount": ['100', '200', '50', '100'],
          "ingredientsImage": [
            ingredientsUrl1,
            ingredientsUrl2,
            ingredientsUrl3,
            ingredientsUrl4,
          ],
        }, SetOptions(merge: true));

        debugPrint("Details saved successfully.");
      } on FirebaseException catch (e) {
        debugPrint("Error saving details: ${e.code} - ${e.message}");
      } catch (e) {
        debugPrint('Unknown error:- $e');
      }
    }

    return Center(
      child: ElevatedButton(
        onPressed: () {
          saveDetails();
        },
        child: Text("Save"),
      ),
    );
  }
}
