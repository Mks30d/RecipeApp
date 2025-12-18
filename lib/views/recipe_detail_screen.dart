import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/provider/favorite_provider.dart';
import 'package:recipe_app/provider/quantity_provider.dart';
import 'package:recipe_app/widgets/my_icon_button.dart';
import 'package:recipe_app/widgets/quantity_incre_decre.dart';

class RecipeDetailScreen extends StatefulWidget {
  final DocumentSnapshot docSanpshot;
  const RecipeDetailScreen({super.key, required this.docSanpshot});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  void initState() {
    // initialize base amounts in the provider
    List<double> baseAmounts = widget.docSanpshot['ingredientsAmount']
        .map<double>((amount) => double.parse(amount.toString()))
        .toList();

    Provider.of<QuantityProvider>(
      context,
      listen: false,
    ).setBaseIngredientAmounts(baseAmounts);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final quantityProvider = Provider.of<QuantityProvider>(context);

    final List ingredientsImage =
        widget.docSanpshot['ingredientsImage'] as List<dynamic>;
    final List ingredients = widget.docSanpshot['ingredients'] as List<dynamic>;

    // final List ingredientsAmount = widget.docSanpshot['ingredientsAmount'] as List<dynamic>;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: startCookingAndFavoriteButton(provider),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.docSanpshot['imageUrl'],
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.docSanpshot['imageUrl']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // for back button
                Positioned(
                  top: 20,
                  left: 10,
                  right: 10,
                  child: Row(
                    children: [
                      MyIconButton(
                        icon: Icons.arrow_back_ios_new,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Spacer(),
                      MyIconButton(icon: Icons.notifications, onPressed: () {}),
                    ],
                  ),
                ),

                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.height / 2.7,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),

            // for drag handle
            Center(
              child: Container(
                width: 40,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // for name and calories
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.docSanpshot['name'],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${widget.docSanpshot['calories']} cal",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "⭐ ${widget.docSanpshot['rating']}/5 (200+ reviews)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // for ingredients and quantity selector
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ingredients",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "How many servings?",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),

                      Spacer(),

                      // for quantity increment decrement widget
                      QuantityIncrementDecrement(
                        currNumber: quantityProvider.currentNumber,
                        onIncrement: () => quantityProvider.increaseQuantity(),
                        onDecrement: () => quantityProvider.decreaseQuantity(),
                      ),
                    ],
                  ),

                  // list of ingredients
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ingredients.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // ingredient image
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(ingredientsImage[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            SizedBox(width: 15),

                            // ingredient name
                            Expanded(
                              child: Text(
                                ingredients[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            // ingredient amount
                            Text(
                              "${quantityProvider.updateIngredientAmounts[index]} g",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 70),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton startCookingAndFavoriteButton(
    FavoriteProvider provider,
  ) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.transparent,
      elevation: 0,
      onPressed: () {},
      label: Row(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12),
            ),
            onPressed: () {},
            child: Text("Start"),
          ),

          SizedBox(width: 10),

          IconButton(
            onPressed: () {
              provider.toggleFavorite(widget.docSanpshot);
            },
            icon: provider.isExist(widget.docSanpshot)
                ? Icon(Icons.favorite, color: Colors.red)
                : Icon(Icons.favorite_border, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
