import 'package:finance/components/helper/sizes.dart';
import 'package:finance/providers/cash_flow_provider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class CashFlowBarChart extends StatelessWidget {
  const CashFlowBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final cashFlowProvider = Provider.of<CashFlowProvider>(context);

    Map<String, double> expensesByCategory =
        cashFlowProvider.getExpensesByCategory();
    List<String> categories = expensesByCategory.keys.toList();
    List<double> values = expensesByCategory.values.toList();

    return Padding(
      padding: const EdgeInsets.all(PaddingSizes.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Com esse gráfico de barras você pode saber agora onde o seu dinheiro está.',
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
                  barGroups: _buildBarGroups(categories, values),
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
                          if (index >= 0 && index < categories.length) {
                            return Text(
                              categories[index],
                              style: const TextStyle(fontSize: TextSizes.sm),
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
                            style: const TextStyle(fontSize: TextSizes.sm),
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
      List<String> categories, List<double> values) {
    return List.generate(
      categories.length,
      (index) {
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: values[index],
              color: Colors.blue,
              width: 15,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        );
      },
    );
  }
}
