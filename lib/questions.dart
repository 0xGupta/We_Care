import 'dart:convert';
import 'package:we_care/doctor_list.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'backend/get_questions.dart';

class QuestionnairePage extends StatefulWidget {
  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  final QuestionService _questionService = QuestionService();
  List<Question> _questions = [];
  Map<String, double> _ratings = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    try {
      List<Question> questions = await _questionService.fetchQuestions();
      setState(() {
        _questions = questions;
        for (var q in questions) {
          for (var question in q.questions) {
            _ratings[question] = 1.0;
          }
        }
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching questions: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _submitRatings() async {
    Map<String, double> categorySums = {};
    for (var q in _questions) {
      double sum = 0;
      for (var question in q.questions) {
        sum += _ratings[question]!;
      }
      categorySums[q.category] = sum;
    }

    // Find the category with the maximum sum
    String maxCategory = categorySums.keys.first;
    double maxSum = categorySums.values.first;
    for (var entry in categorySums.entries) {
      if (entry.value > maxSum) {
        maxCategory = entry.key;
        maxSum = entry.value;
      }
    }

    Map<String, dynamic> data = {
      maxCategory: maxSum,
    };

    print(data);
    final response = await http.post(
      Uri.parse(
          'https://github-cloud-run-service-scocq2dp5a-ey.a.run.app/doctors'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      // Handle successful submission
      print('Ratings submitted successfully');
      print(response.body);
      // Parse the response and navigate to the doctor list page
      final List<dynamic> doctorsJson =
          json.decode(response.body)['doctors'][0];
      List<Doctor> doctors =
          doctorsJson.map((json) => Doctor.fromJson(json)).toList();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DoctorListPage(doctors: doctors)),
      );
    } else {
      // Handle error
      print('Error submitting ratings: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Early Detection'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _questions.isEmpty
              ? Center(child: Text('No questions available'))
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.add_alert,
                              size: 80,
                              color: Color(0xFF402579),
                            ),
                            Text(
                              'Early Detection',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF402579),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      ..._questions.map((q) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                q.category,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              ...q.questions.map((question) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          question,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Slider(
                                          value: _ratings[question]!,
                                          min: 1,
                                          max: 5,
                                          divisions: 4,
                                          label: _ratings[question]!
                                              .round()
                                              .toString(),
                                          onChanged: (value) {
                                            setState(() {
                                              _ratings[question] = value;
                                            });
                                          },
                                          activeColor: Color(0xFF402579),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          )),
                      Center(
                        child: ElevatedButton(
                          onPressed: _submitRatings,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF402579),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
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
        selectedItemColor: Color(0xFF402579),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle bottom navigation bar item tap
        },
      ),
    );
  }
}
