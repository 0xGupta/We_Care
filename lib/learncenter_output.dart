import 'package:flutter/material.dart';
import 'backend/search_results.dart'; // Import the model class

class ResultPage extends StatelessWidget {
  final List<Result> results;

  ResultPage({required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final result = results[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(result.imageUrl),
              title: Text(result.title),
              subtitle: Text(result.description),
              trailing: ElevatedButton(
                onPressed: () {
                  // Handle share action
                },
                child: Text('Share'),
              ),
            ),
          );
        },
      ),
    );
  }
}
