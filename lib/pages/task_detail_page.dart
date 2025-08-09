import 'package:flutter/material.dart';

class TaskDetailPage extends StatelessWidget {
  final Map task;
  const TaskDetailPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task["title"]),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Type: ${task["type"]}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Time: ${task["time"]}", style: const TextStyle(fontSize: 16)),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.teal,
              ),
              child: const Text("Get Started"),
            )
          ],
        ),
      ),
    );
  }
}
