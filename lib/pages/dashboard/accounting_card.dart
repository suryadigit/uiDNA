import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'chart_section.dart';
import 'summary_item.dart';

class AccountingCard extends StatelessWidget {
  final String selectedPeriod;
  final List<String> periods;
  final Function(String) onPeriodChanged;
  final Map<String, dynamic> data;

  const AccountingCard({
    super.key,
    required this.selectedPeriod,
    required this.periods,
    required this.onPeriodChanged,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 8),
          _buildPeriodDescription(selectedPeriod),
          const SizedBox(height: 24),
          Text(
            'AVG. Monthly Income',
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${_formatCurrency(data['avgIncome'])}',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          ///////////////
          Row(
            children: [
              Icon(
                data['growth'] > 0 ? Icons.trending_up : Icons.trending_down,
                size: 18,
                color: data['growth'] > 0 ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 6),
              Text(
                '${data['growth'].toStringAsFixed(2)}% vs \$${_formatCurrency(data['previousAmount'])} prev. 90 days',
                style: TextStyle(
                  fontSize: 13,
                  color: data['growth'] > 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          ChartSection(chartData: List<double>.from(data['chartData'])),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SummaryItem(
                icon: CupertinoIcons.money_dollar,
                iconColor: Colors.green,
                amount: '\$${_formatCurrency(data['totalIncome'])}',
                label: 'Total Income',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 16),
              SummaryItem(
                icon: CupertinoIcons.money_dollar,
                iconColor: Colors.red,
                amount: '\$${_formatCurrency(data['totalExpenses'])}',
                label: 'Total Expenses',
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY();
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Accounting',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            value: selectedPeriod,
            isExpanded: false,
            buttonStyleData: ButtonStyleData(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.keyboard_arrow_down, size: 18),
            ),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            items: periods.map((e) {
              return DropdownMenuItem<String>(
                value: e,
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    Text(e),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) onPeriodChanged(value);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodDescription(String periods) {
    final description = _getPeriodDescription(periods);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.blueGrey.shade600,
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.2, end: 0);
  }

  String _formatCurrency(double amount) {
    if (amount >= 1000000) return '${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(1)}K';
    return amount.toStringAsFixed(2);
  }

  String _getPeriodDescription(String period) {
    final now = DateTime.now();

    switch (period) {
      case 'This Month':
        {
          final start = DateTime(now.year, now.month, 1);
          final end = DateTime(now.year, now.month + 1, 0);
          return '${_formatDate(start)} - ${_formatDate(end)}';
        }
      case 'Last Month':
        {
          final start = DateTime(now.year, now.month - 1, 1);
          final end = DateTime(now.year, now.month, 0);
          return '${_formatDate(start)} - ${_formatDate(end)}';
        }
      case 'This Quarter':
        {
          final quarter = ((now.month - 1) ~/ 3) + 1;
          final startMonth = (quarter - 1) * 3 + 1;
          final start = DateTime(now.year, startMonth, 1);
          final end = DateTime(now.year, startMonth + 3, 0);
          return '${_formatDate(start)} - ${_formatDate(end)}';
        }
      case 'This Year':
        {
          final start = DateTime(now.year, 1, 1);
          final end = DateTime(now.year, 12, 31);
          return '${_formatDate(start)} - ${_formatDate(end)}';
        }
      default:
        return '';
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final monthStr = months[date.month - 1];
    return '$monthStr ${date.day}, ${date.year}';
  }
}
