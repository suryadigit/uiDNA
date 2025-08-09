import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/meeting_model.dart';
import 'calender_dates.dart';
import 'calender_header.dart';
import 'detail/task_detail_screen.dart';
import 'meeting_card.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int selectedDate = 26;

  final List<Meeting> meetings = [
    Meeting(
      id: '#327',
      title: 'Remodeling',
      startTime: '9:30',
      endTime: '10:00',
      type: 'Internal Task',
      color: const Color.fromARGB(255, 9, 93, 59),
      icon: CupertinoIcons.calendar,
    ),
    Meeting(
      id: '#329',
      title: 'Generate Report',
      startTime: '10:00',
      endTime: '10:30',
      type: 'Personal Task',
      color: const Color(0xFF4A90E2),
      icon: Icons.note,
    ),
    Meeting(
      id: '#332',
      title: 'Chimney Repair',
      startTime: '11:00',
      endTime: '11:30',
      type: 'Maintenance...',
      color: const Color(0xFFFF9500),
      icon: Icons.handyman,
    ),
    Meeting(
      id: '#339',
      title: 'Energy Audits',
      startTime: '11:30',
      endTime: '12:00',
      type: 'Internal Task',
      color: const Color(0xFF4A90E2),
      icon: Icons.electric_bolt,
    ),
  ];

  void onDateSelected(int date) {
    setState(() {
      selectedDate = date;
    });
  }

  void onMeetingTap(Meeting meeting) {
    if (meeting.title == 'Remodeling') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskDetailScreen(meeting: meeting),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(meeting.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${meeting.id}'),
              Text('Time: ${meeting.startTime} - ${meeting.endTime}'),
              Text('Type: ${meeting.type}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Column(
          children: [
            const CalendarHeader(),
            CalendarDates(
              selectedDate: selectedDate,
              onDateSelected: onDateSelected,
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF2E6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_left),
                      color: Colors.black87,
                      iconSize: 24,
                      padding: EdgeInsets.all(8),
                      constraints: BoxConstraints(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop&crop=face',
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nicholas Amazon',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '4 hours',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_right),
                      color: Colors.black87,
                      iconSize: 24,
                      padding: EdgeInsets.all(8),
                      constraints: BoxConstraints(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: meetings.length,
                  itemBuilder: (context, index) {
                    return MeetingCard(
                      meeting: meetings[index],
                      onTap: () => onMeetingTap(meetings[index]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add new meeting')),
          );
        },
        backgroundColor: const Color(0xFF2D5A87),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
