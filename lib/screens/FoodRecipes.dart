import 'package:flutter/material.dart';

class FoodRecipesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Recipes"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displaying a static sentimental recipe
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Grandma’s Secret Pizza",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "This pizza takes me back to my childhood. Every Friday, "
                      "Grandma would knead the dough with love, humming old songs. "
                      "The aroma of fresh basil and melted cheese filled our tiny kitchen, "
                      "bringing the whole family together. 🍕❤️",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Ingredients:\n- 2 cups flour\n- 1 tsp yeast\n- 1/2 cup warm water\n- "
                      "Tomato sauce, cheese, and your favorite toppings",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Static Add Recipe Button (Does Nothing)
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Button does nothing, just for UI
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Text(
                  "Add Recipe",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
