import 'package:flutter/material.dart';

Widget buildNotificationCard({
  required String title,
  required String subtitle,
  required String time,
  required bool isRead,
}) {
  return Card(
    color: isRead ? Colors.white : Colors.grey[200],
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: ListTile(
      leading: Icon(
        Icons.notifications,
        color: isRead ? Colors.grey : Colors.blue,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: Text(
        time,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    ),
  );
}
