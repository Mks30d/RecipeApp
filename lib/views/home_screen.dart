import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/my_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final category = "All";

  final CollectionReference categories = FirebaseFirestore.instance.collection(
    "Category",
  );

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
          ],
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> selectedCategory() {
    return StreamBuilder(
      stream: categories.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(snapshot.data!.docs.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    category == snapshot.data!.docs[index]['name'];
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
