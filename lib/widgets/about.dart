import 'package:flutter/material.dart';

Widget about() {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.person, size: 40, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Object Detection',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Our project is an application focused on object detection using artificial intelligence technology. It enables users to identify objects within images or videos, leveraging advanced algorithms for accurate detection and analysis. The application aims to provide a user-friendly interface for seamless interaction, making it accessible for various applications requiring object recognition capabilities.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 20),
            Container(
            width: double.infinity,
            height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assests/images/logo.jpg'),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }