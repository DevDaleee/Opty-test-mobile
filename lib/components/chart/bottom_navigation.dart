import 'package:finance/components/helper/sizes.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    super.key,
    required this.navigationIndex,
    required this.onChange,
  });

  final int navigationIndex;
  final Function(int index) onChange;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            blurRadius: 4,
            spreadRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      height: 60,
      padding: const EdgeInsets.all(PaddingSizes.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: navigationItem(
              indexSignature: 0,
              title: 'Categorias',
            ),
          ),
          Expanded(
            child: navigationItem(
              indexSignature: 1,
              title: 'Visão Geral',
            ),
          ),
          Expanded(
            child: navigationItem(
              indexSignature: 2,
              title: 'Meses',
            ),
          ),
        ],
      ),
    );
  }

  Widget navigationItem({
    required int indexSignature,
    required String title,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () => widget.onChange(indexSignature),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: PaddingSizes.sm),
            decoration: BoxDecoration(
              color: widget.navigationIndex == indexSignature
                  ? Theme.of(context).colorScheme.primary
                  : null,
              borderRadius: BorderRadius.circular(RadiusSizes.xs),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: TextSizes.sm,
                color: widget.navigationIndex == indexSignature
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
          )
        ],
      ),
    );
  }
}
