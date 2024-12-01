import 'package:finance/components/helper/colors.dart';
import 'package:finance/components/helper/sizes.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final String value;
  final bool isCashIn;
  const HistoryCard({
    super.key,
    required this.title,
    required this.date,
    required this.value,
    required this.isCashIn,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isCashIn == true
          ? namedColors['blue']!.withOpacity(
              Theme.of(context).brightness == Brightness.dark ? 0.65 : 0.45,
            )
          : namedColors['red']!.withOpacity(
              Theme.of(context).brightness == Brightness.dark ? 0.65 : 0.45,
            ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: PaddingSizes.sm,
          horizontal: PaddingSizes.lg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inverseSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: TextSizes.md,
                  ),
                ),
                Text(
                  'Data: ${date.day}/${date.month}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                )
              ],
            ),
            Text(
              'R\$ $value',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontWeight: FontWeight.bold,
                fontSize: TextSizes.lg,
              ),
            )
          ],
        ),
      ),
    );
  }
}
