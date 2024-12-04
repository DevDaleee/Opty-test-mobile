import 'package:finance/components/chart/bottom_navigation.dart';
import 'package:finance/components/helper/sizes.dart';
import 'package:finance/pages/charts/charts/bar_chart.dart';
import 'package:finance/pages/charts/charts/grid_chart.dart';
import 'package:finance/pages/charts/charts/pie_chart.dart';
import 'package:flutter/material.dart';

class Charts extends StatefulWidget {
  final List<dynamic> cashFlows;
  const Charts({super.key, required this.cashFlows});

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  int navigationIndex = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Acompanhe as suas finanças',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: TextSizes.lg),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (value) => setState(() => navigationIndex = value),
            children: const [
              CashFlowBarChart(),
              CashFlowPieChart(),
              SpendingTrendsBarChart(),
            ],
          ),
          if (MediaQuery.of(context).viewInsets.bottom == 0)
            BottomNavigation(
              navigationIndex: navigationIndex,
              onChange: (index) {
                setState(() => navigationIndex = index);
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.linearToEaseOut,
                );
              },
            ),
        ],
      ),
    );
  }
}
