import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/food_items_display.dart';
import 'package:recipe_app/widgets/my_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String category = "All";

  final CollectionReference categoryCollection = FirebaseFirestore.instance
      .collection("Category");

  Query get filteredRecipes {
    return FirebaseFirestore.instance
        .collection('recipes')
        .where('category', isEqualTo: category);
  }

  Query get allRecipes {
    return FirebaseFirestore.instance.collection("recipes");
  }

  Query get selectedRecipes => category == "All" ? allRecipes : filteredRecipes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 45, 18, 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerPart(),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),

            selectedCategory(),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quick & Easy",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),

                TextButton(onPressed: () {}, child: Text("View all")),
              ],
            ),

            SizedBox(height: 15),

            // for food items display
            StreamBuilder(
              stream: selectedRecipes.snapshots(),
              builder: (context, snapshot) {
                // if data is available
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> recipes =
                      snapshot.data?.docs ?? [];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: recipes.map((e) {
                          return FoodItemsDisplay(documentSnapshot: e);
                        }).toList(),
                      ),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> selectedCategory() {
    return StreamBuilder(
      stream: categoryCollection.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        // if data is available
        if (snapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(snapshot.data!.docs.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      category = snapshot.data!.docs[index]['name'];
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15,
                    ),
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      color: category == snapshot.data!.docs[index]['name']
                          ? Colors.blue
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      snapshot.data!.docs[index]['name'],
                      style: TextStyle(
                        color: category == snapshot.data!.docs[index]['name']
                            ? Colors.white
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Row headerPart() {
    return Row(
      children: [
        Text(
          'What are you \ncooking today?',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        Spacer(),
        MyIconButton(icon: Icons.notifications_outlined, onPressed: () {}),
      ],
    );
  }
}
