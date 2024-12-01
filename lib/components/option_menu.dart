import 'package:finance/providers/cash_flow_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showOptionsMenu(
    BuildContext context, GlobalKey iconKey,) {
  final RenderBox renderBox =
      iconKey.currentContext!.findRenderObject() as RenderBox;
  CashFlowProvider provider = context.read<CashFlowProvider>();
  final position = renderBox.localToGlobal(Offset.zero);
  showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
      position.dx,
      position.dy + renderBox.size.height,
      position.dx + renderBox.size.width,
      0,
    ),
    items: [
      const PopupMenuItem(
        value: 0,
        child: Text('Somente Entradas'),
      ),
      const PopupMenuItem(
        value: 1,
        child: Text('Somente Saídas'),
      ),
      const PopupMenuItem(
        value: 2,
        child: Text('Mais Recente'),
      ),
      const PopupMenuItem(
        value: 3,
        child: Text('Mais Antigo'),
      ),
    ],
  ).then((value) {
    provider.filter(value!);
  });
}
