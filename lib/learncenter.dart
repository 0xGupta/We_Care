import 'package:flutter/material.dart';
import 'backend/search.dart'; // Import the service class
import 'backend/search_results.dart'; // Import the result page
import 'learncenter_output.dart';

class LearnCenter extends StatefulWidget {
  @override
  _LearnCenterState createState() => _LearnCenterState();
}

class _LearnCenterState extends State<LearnCenter> {
  final TextEditingController _searchController = TextEditingController();
  final BackendService _backendService = BackendService();

  void _search() async {
    try {
      List<Result> results =
          await _backendService.fetchResults(_searchController.text.trim());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultPage(results: results)),
      );
    } catch (e) {
      print(e);
      // Handle error, show a message to the user, etc.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon press
            },
          ),
          IconButton(
            icon: Icon(Icons.mail),
            onPressed: () {
              // Handle mail icon press
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.play_circle_fill,
                    size: 80,
                    color: Colors.deepPurple,
                  ),
                  Text(
                    'Learning Center',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'How are you feeling today ?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                Chip(
                  label: Text('restless'),
                  onDeleted: () {
                    // Handle delete action
                  },
                ),
                Chip(
                  label: Text('upset'),
                  onDeleted: () {
                    // Handle delete action
                  },
                ),
                Chip(
                  label: Text('suspicious'),
                  onDeleted: () {
                    // Handle delete action
                  },
                ),
                Chip(
                  label: Text('general emotional distress'),
                  onDeleted: () {
                    // Handle delete action
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Additional Notes',
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _search,
                child: Text('Search'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0, // Set the current index to highlight the selected item
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle bottom navigation bar item tap
        },
      ),
    );
  }
}
