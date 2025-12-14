import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/provider/favorite_provider.dart';
import 'package:recipe_app/widgets/my_icon_button.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final favoriteItems = provider.favorites;

    return Scaffold(
      appBar: AppBar(title: Text("Favorites"), centerTitle: true),
      body: favoriteItems.isEmpty
          ? Center(
              child: Text(
                "No favorite items yet!",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final favorite = favoriteItems[index];
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("recipes")
                      .doc(favorite)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData ||
                        !snapshot.data!.exists ||
                        snapshot.data == null) {
                      // return SizedBox.shrink();
                      return ListTile(title: Text("Item not found"));
                    }

                    if (snapshot.hasData) {
                      final favoriteItem = snapshot.data!;
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          // padding: EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(5),
                            dense: true,

                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                favoriteItem['imageUrl'],
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              favoriteItem['name'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text("${favoriteItem['calories']} cal"),
                            trailing: MyIconButton(
                              icon: Icons.delete,
                              onPressed: () {
                                provider.toggleFavorite(favoriteItem);
                              },
                            ),
                          ),
                        ),
                      );
                    }

                    return Text("Something went wrong");
                  },
                );
              },
            ),
    );
  }
}
