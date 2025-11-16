import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class RecipeListScreen extends StatelessWidget {
  final bool premium;
  RecipeListScreen({this.premium = false});
  final FirestoreService _service = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(premium ? "Premium Recipes" : "Recipes")),
      body: StreamBuilder<List<Map<String,dynamic>>>(
        stream: _service.getRecipes(premium: premium),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final recipes = snapshot.data!;
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return ListTile(
                leading: Image.network(recipe['imageUrl'], width: 50, height: 50, fit: BoxFit.cover),
                title: Text(recipe['name']),
                subtitle: Text(recipe['difficulty']),
                trailing: recipe['premium'] ? Icon(Icons.star, color: Colors.amber) : null,
                onTap: () {
                  // navigate to recipe detail
                },
              );
            },
          );
        },
      ),
    );
  }
}
