import 'package:flutter/material.dart';

class Doctor {
  final String name;
  final String photo;
  final String type;

  Doctor({required this.name, required this.photo, required this.type});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'],
      photo: json['photo'],
      type: json['type'],
    );
  }
}

class DoctorListPage extends StatelessWidget {
  final List<Doctor> doctors;

  DoctorListPage({required this.doctors});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors'),
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(doctor.photo),
            ),
            title: Text(doctor.name),
            subtitle: Text(doctor.type),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    // Handle info button press
                  },
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    // Handle calendar button press
                  },
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {
                    // Handle favorite button press
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
