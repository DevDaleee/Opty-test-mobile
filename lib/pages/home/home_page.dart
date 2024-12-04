import 'package:finance/components/cards/cashFlow_card.dart';
import 'package:finance/components/cards/history_card.dart';
import 'package:finance/components/helper/colors.dart';
import 'package:finance/components/helper/converters.dart';
import 'package:finance/components/helper/sizes.dart';
import 'package:finance/components/option_menu.dart';
import 'package:finance/providers/cash_flow_provider.dart';
import 'package:finance/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<UserProvider>().getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey iconKey = GlobalKey();
    UserProvider user = context.read<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finan.ce'),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(PaddingSizes.lg),
            child: Text(
              'Olá ${user.user!.name}!',
              style: const TextStyle(
                fontSize: TextSizes.lg,
              ),
            ),
          )
        ],
      ),
      body: Consumer<CashFlowProvider>(
        builder: (context, provider, _) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(PaddingSizes.lg),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Saldo Total',
                      style: TextStyle(
                        fontSize: TextSizes.md,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Card(
                      color: provider.totalBalance >= 0
                          ? namedColors['green']!.withOpacity(
                              Theme.of(context).brightness == Brightness.dark
                                  ? 0.35
                                  : 0.5,
                            )
                          : namedColors['red']!.withOpacity(
                              Theme.of(context).brightness == Brightness.dark
                                  ? 0.35
                                  : 0.5,
                            ),
                      child: Padding(
                        padding: const EdgeInsets.all(PaddingSizes.sm),
                        child: Text(
                          'R\$ ${provider.totalBalance.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CashFlowCard(
                      image: 'assets/icons/arrow-up.svg',
                      value: provider.cashIn.toStringAsFixed(2),
                    ),
                    CashFlowCard(
                      image: 'assets/icons/arrow-down.svg',
                      value: provider.cashOut.toStringAsFixed(2),
                    ),
                  ],
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(getSelectedFilter(provider.selectedFilterIndex)),
                      ElevatedButton(
                        key: iconKey,
                        onPressed: () {
                          showOptionsMenu(context, iconKey);
                        },
                        style: const ButtonStyle(
                            elevation: WidgetStatePropertyAll(0)),
                        child: SvgPicture.asset(
                          'assets/icons/${Theme.of(context).brightness != Brightness.dark ? 'D' : 'L'}Sort.svg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: provider.cashFlow.isEmpty
                      ? const Text(
                          'Você não tem transações cadastradas.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.filteredCashFlow.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                '/detail-cashFlow',
                                arguments: {
                                  'cashFlowId': provider.cashFlow[index]!.id,
                                },
                              ),
                              child: HistoryCard(
                                title: provider.cashFlow[index].reason ??
                                    'Sem motivo',
                                date: provider.cashFlow[index].createdAt ??
                                    DateTime.now(),
                                value: provider.cashFlow[index].amount
                                        ?.toStringAsFixed(2) ??
                                    '0.00',
                                isCashIn:
                                    provider.cashFlow[index].isCashIn ?? true,
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        activeIcon: Icons.close,
        children: [
          SpeedDialChild(
            elevation: 0,
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
            labelWidget: const Text('Adicionar movimentação'),
            backgroundColor:
                Theme.of(context).colorScheme.inverseSurface.withOpacity(0.5),
            onTap: () {
              Navigator.pushNamed(context, '/add-cashFlow');
            },
          ),
          SpeedDialChild(
            elevation: 0,
            child: Icon(
              Icons.bar_chart,
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
            labelWidget: const Text('Gráficos'),
            backgroundColor:
                Theme.of(context).colorScheme.inverseSurface.withOpacity(0.5),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/charts',
                arguments: {
                  'cashFlows': context.read<CashFlowProvider>().cashFlow,
                },
              );
            },
          ),
        ],
        child: SizedBox(
          width: SpaceSizes.md,
          child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
