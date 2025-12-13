import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/food_items_display.dart';
import 'package:recipe_app/widgets/my_icon_button.dart';

class ViewAllItems extends StatefulWidget {
  const ViewAllItems({super.key});

  @override
  State<ViewAllItems> createState() => _ViewAllItemsState();
}

class _ViewAllItemsState extends State<ViewAllItems> {
  final recipesCollection = FirebaseFirestore.instance.collection("recipes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Items'),
        automaticallyImplyLeading: false,
        actions: [
          MyIconButton(
            icon: Icons.arrow_back_rounded,
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          Spacer(),
          Text('All Items'),
          Spacer(),

          MyIconButton(icon: Icons.notifications, onPressed: () {}),
        ],
      ),
      body: StreamBuilder(
        stream: recipesCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final documentSnapshot = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    // padding: const EdgeInsets.fromLTRB(11, 0, 11, 11),
                    child: FoodItemsDisplay(documentSnapshot: documentSnapshot),
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
