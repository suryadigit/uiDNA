import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dashboard_header.dart';
import 'accounting_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}
class _DashboardPageState extends State<DashboardPage> {
  String selectedPeriod = 'This Month';
  final List<String> periods = ['This Month', 'Last Month', 'This Quarter', 'This Year'];
  Map<String, dynamic> dashboardData = {};

  @override
  void initState() {
    super.initState();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    final String response = await rootBundle.loadString('assets/dashboard_data.json');
    final data = json.decode(response);
    setState(() {
      dashboardData = data;
    });
  }



  @override
  Widget build(BuildContext context) {
    if (dashboardData.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentData = dashboardData[selectedPeriod];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardHeader(),
              const SizedBox(height: 24),
              AccountingCard(
                selectedPeriod: selectedPeriod,
                periods: periods,
                onPeriodChanged: (value) {
                  setState(() {
                    selectedPeriod = value;
                  });
                },
                data: currentData,
              ),
              const SizedBox(height: 12),
              // Deskripsi periode muncul di sini sesuai selectedPeriod
              // Text(
              //   _getPeriodDescription(selectedPeriod),
              //   style: const TextStyle(
              //     fontSize: 14,
              //     color: Colors.grey,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
