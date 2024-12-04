import 'package:finance/components/helper/sizes.dart';
import 'package:finance/providers/cash_flow_provider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class SpendingTrendsBarChart extends StatelessWidget {
  const SpendingTrendsBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final cashFlowProvider = Provider.of<CashFlowProvider>(context);

    Map<String, double> monthlyExpenses = cashFlowProvider.getMonthlyExpenses();
    List<String> months = monthlyExpenses.keys.toList();
    List<double> values = monthlyExpenses.values.toList();

    return Padding(
      padding: const EdgeInsets.all(PaddingSizes.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Agora você pode saber a progressão dos seus gastos e saber quando gastou mais!',
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
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  borderData: FlBorderData(show: false),
                  barGroups: _buildBarGroups(months, values),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          int index = value.toInt();
                          if (index >= 0 && index < months.length) {
                            return Text(
                              (months[index]),
                              style: const TextStyle(fontSize: TextSizes.xs),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(
                      showTitles: false,
                    )),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 12),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          )
        ],
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(
      List<String> months, List<double> values) {
    return List.generate(
      months.length,
      (index) {
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: values[index],
              color: values[index] > (index > 0 ? values[index - 1] : 0)
                  ? Colors.red
                  : Colors.green,
              width: 15,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        );
      },
    );
  }
}
