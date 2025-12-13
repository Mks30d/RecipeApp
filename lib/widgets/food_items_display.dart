import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FoodItemsDisplay extends StatelessWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const FoodItemsDisplay({super.key, required this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},

      child: Container(
        margin: const EdgeInsets.only(right: 0),
        width: 230,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(documentSnapshot['imageUrl']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  documentSnapshot["name"],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 5),

                Row(
                  children: [
                    Icon(Icons.star, color: Colors.grey, size: 16),
                    SizedBox(width: 5),
                    Text(
                      documentSnapshot["rating"].toString(),
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),

            // for favorite icon
            Positioned(
              right: 10,
              top: 10,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Center(
                  child: Icon(
                    Icons.favorite_border,
                    size: 25,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
