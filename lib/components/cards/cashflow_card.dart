import 'package:finance/components/helper/sizes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class CashFlowCard extends StatelessWidget {
  final String value;
  final String image;
  const CashFlowCard({super.key, required this.image, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.inverseSurface,
      child: Padding(
        padding: const EdgeInsets.all(PaddingSizes.lg),
        child: Row(
          children: [
            SvgPicture.asset(
              image,
              fit: BoxFit.scaleDown,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            Text(
              'R\$ $value',
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
