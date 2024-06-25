// ignore: file_names
import 'package:flutter/material.dart';

Widget objectList(detectedObjects) {
    if (detectedObjects.isEmpty) {
      return const Center(child: Text('No objects detected.'));
    }
    return ListView.builder(
      itemCount: detectedObjects.length,
      itemBuilder: (context, index) {
        final object = detectedObjects[index];
        return Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListTile(
            leading: const Icon(
              Icons.circle,
              color: Colors.blueGrey,
              size: 50,
            ),
            title: Text(
              object['object_name'].toString().toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blueGrey,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Precision: ${object['precision'].toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Fecha: ${object['timestamp']}',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            contentPadding: const EdgeInsets.all(10),
          ),
        );
      },
    );
  }
