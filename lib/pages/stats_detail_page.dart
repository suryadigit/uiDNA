import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsDetailPage extends StatelessWidget {
  final String title;
  final String count;
  final Color color;

  const StatsDetailPage({
    super.key,
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Hero(
          tag: "stats_$title",
          child: Material(
            color: Colors.transparent,
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Text(
              "$count Tasks",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ).animate().fadeIn(duration: 500.ms).scale(),
          ),
          const SizedBox(height: 20),
          _buildCompletionChart().animate().fadeIn(duration: 600.ms).slideY(),
          const SizedBox(height: 20),
          _buildSummaryList().animate().fadeIn(duration: 700.ms).slideY(),
        ],
      ),
    );
  }

  Widget _buildCompletionChart() {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 30),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
                  if (value >= 0 && value < days.length) {
                    return Text(days[value.toInt()]);
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: color,
              spots: [
                const FlSpot(0, 3),
                const FlSpot(1, 4),
                const FlSpot(2, 5),
                const FlSpot(3, 4.5),
                const FlSpot(4, 6),
                const FlSpot(5, 6.5),
                const FlSpot(6, 7),
              ],
              belowBarData: BarAreaData(
                show: true,
                color: color.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryList() {
    final items = [
      {"label": "Completed On Time", "value": "95%"},
      {"label": "Completed Late", "value": "5%"},
      {"label": "Average Duration", "value": "1h 20m"},
      {"label": "Most Active Day", "value": "Thursday"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item["label"]!, style: const TextStyle(fontSize: 16)),
                  Text(item["value"]!, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
