import 'package:flutter/material.dart';

class CalendarDates extends StatelessWidget {
  final int selectedDate;
  final Function(int) onDateSelected;

  const CalendarDates({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dates = [
      {'date': 25, 'day': 'Sun'},
      {'date': 26, 'day': 'Mon'},
      {'date': 27, 'day': 'Tue'},
      {'date': 28, 'day': 'Wed'},
      {'date': 29, 'day': 'Thu'},
      {'date': 30, 'day': 'Fri'},
      {'date': 31, 'day': 'Sat'},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: dates.map((dateInfo) {
          final date = dateInfo['date'] as int;
          final day = dateInfo['day'] as String;
          final isSelected = date == selectedDate;
          
          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2D5A87) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    date.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : const Color(0xFF2D5A87),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    day,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white70 : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}