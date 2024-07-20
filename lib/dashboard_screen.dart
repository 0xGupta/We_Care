import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'learncenter.dart';
import 'package:intl/intl.dart';
import 'package:we_care/questions.dart';

class DashboardPage extends StatelessWidget {
  final User user;
  DashboardPage({required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[50],
        elevation: 0,
        toolbarHeight: 50,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(Icons.notifications, color: Colors.grey),
                SizedBox(width: 10),
                Icon(Icons.mail, color: Colors.grey),
              ],
            ),
            Row(
              children: [
                Text('Hi, WelcomeBack ', style: TextStyle(color: Colors.black)),
                CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/user.jpg'), // Replace with your asset image
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Categories',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryItem(icon: Icons.favorite, label: 'Favorite'),
                CategoryItem(icon: Icons.person, label: 'Doctors'),
                CategoryItem(icon: Icons.location_on, label: 'Location'),
                CategoryItem(icon: Icons.note, label: 'Daily Notes'),
                CategoryItem(icon: Icons.folder, label: 'Patient Record'),
              ],
            ),
            SizedBox(height: 20),
            Text('Upcoming Schedule',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ScheduleSection(),
            SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 7,
                crossAxisSpacing: 5,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuestionnairePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF402579),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.alarm, size: 40, color: Colors.white),
                        SizedBox(height: 10),
                        Text('Early Detection',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LearnCenter()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF402579),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_circle_fill,
                            size: 40, color: Colors.white),
                        SizedBox(height: 10),
                        Text('Learning Center',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Nurse Assist page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF402579),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone, size: 40, color: Colors.white),
                        SizedBox(height: 10),
                        Text('Nurse Assist',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Community page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF402579),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat, size: 40, color: Colors.white),
                        SizedBox(height: 10),
                        Text('Community',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  CategoryItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(icon, color: Colors.deepPurple),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.black)),
      ],
    );
  }
}

class ScheduleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('d EEE');

    return Container(
      color: Color(0xFF402579),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) {
              DateTime date = now.add(Duration(days: index));
              return ScheduleButton(label: formatter.format(date));
            }),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('See all', style: TextStyle(color: Colors.white)),
              Text('Month', style: TextStyle(color: Colors.white)),
            ],
          ),
          SizedBox(height: 10),
          Container(
            color: Color(0xFF402579),
            child: Column(
              children: [
                ScheduleItem(
                  date: '11 Month - Wednesday - Today',
                  time: '10:00 am',
                  doctor: 'Dr. Olivia Turner',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScheduleButton extends StatelessWidget {
  final String label;

  ScheduleButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF402579),
        minimumSize: Size(15, 15),
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        side: BorderSide(width: 1, color: Colors.white),
      ),
    );
  }
}

class ScheduleItem extends StatelessWidget {
  final String date;
  final String time;
  final String doctor;

  ScheduleItem({required this.date, required this.time, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date, style: TextStyle(color: Colors.white)),
              Text(time, style: TextStyle(color: Colors.white)),
            ],
          ),
          Text(doctor, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
