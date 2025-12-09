import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SaveDetails extends StatelessWidget {
  const SaveDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference recipeCollection = FirebaseFirestore.instance
        .collection("recipes");

    Future<void> saveDetails() async {
      try {
        await recipeCollection.doc().set({
          'name': 'Lunch Recipe',
          "rating": 4.5,
          "calories": 140,
          "category": "Lunch",
          'ingredients': ['Ingredient 1', 'Ingredient 2'],
          "ingredientAmout": ['100g', '200g'],
          "time": 30,
          "imageUrl": "",
        });

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
