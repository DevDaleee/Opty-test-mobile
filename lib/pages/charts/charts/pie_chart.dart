import 'package:finance/components/chart/indicator.dart';
import 'package:finance/components/helper/colors.dart';
import 'package:finance/components/helper/sizes.dart';
import 'package:finance/providers/cash_flow_provider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class CashFlowPieChart extends StatelessWidget {
  const CashFlowPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final cashFlowProvider = Provider.of<CashFlowProvider>(context);

    double cashIn = cashFlowProvider.cashIn;
    double cashOut = cashFlowProvider.cashOut;

    return Padding(
      padding: const EdgeInsets.all(PaddingSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Tenha uma visão geral das suas finanças',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.inverseSurface,
              fontSize: TextSizes.md,
              fontWeight: FontWeight.w500,
            ),
          ),
          Center(
            child: AspectRatio(
              aspectRatio: 1.2,
              child: PieChart(
                PieChartData(
                  sections: _buildPieChartSections(cashIn, cashOut),
                  centerSpaceRadius: 50,
                  sectionsSpace: 4,
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Indicator(
                color: namedColors['green']!,
                text: 'Receita',
                isSquare: true,
              ),
              Indicator(
                color: namedColors['red']!,
                text: 'Despesas',
                isSquare: true,
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(
      double cashIn, double cashOut) {
    double total = cashIn + cashOut;

    return [
      PieChartSectionData(
        value: cashIn,
        title: '${((cashIn / total) * 100).toStringAsFixed(1)}%',
        color: Colors.green,
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        value: cashOut,
        title: '${((cashOut / total) * 100).toStringAsFixed(1)}%',
        color: Colors.red,
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
}
