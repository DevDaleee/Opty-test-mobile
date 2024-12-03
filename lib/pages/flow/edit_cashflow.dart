// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:finance/components/buttons/custom_outlined_button.dart';
import 'package:finance/components/custom_dialog.dart';
import 'package:finance/components/helper/sizes.dart';
import 'package:finance/components/custom_form_field.dart';
import 'package:finance/components/tostification.dart';
import 'package:finance/providers/cash_flow_provider.dart';
import 'package:finance/services/api/cash_flow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCashFlow extends StatefulWidget {
  final String cashFlowId;
  const EditCashFlow({
    required this.cashFlowId,
    super.key,
  });

  @override
  State<EditCashFlow> createState() => _EditCashFlowState();
}

class _EditCashFlowState extends State<EditCashFlow> {
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> cashFlow = {};

  @override
  void initState() {
    super.initState();
    _loadCashFlow();
  }

  Future<void> _loadCashFlow() async {
    final fetchedCashFlow =
        await CashFlowService.getCashFlowById(widget.cashFlowId);
    setState(() {
      cashFlow = fetchedCashFlow['data'];
    });
  }

  _onDeleteFlow(String cashFlowId) async {
    var response = await CashFlowService.deleteCashFlow(cashFlowId);
    if (response['success'] == true) {
      context.read<CashFlowProvider>().removeCashFlowById(cashFlowId);
      showToast(context, response);
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (_) => false,
      );
    } else {
      showToast(context, {
        'statusCode': response['statusCode'],
        'message': response['message'] ?? 'Erro ao deletar o fluxo',
      });
    }
  }

  Future<bool?> _updateFlow(
    String title,
    String bodyMessage,
    String textCancel,
    String textConfirm,
  ) async {
    return await showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: title,
        bodyMessage: bodyMessage,
        textCancel: textCancel,
        textConfirm: textConfirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              var response = await _updateFlow(
                'Deseja realmente deletar essa movimentação?',
                'Você não poderá recuperá-la, pode criar uma nova caso queira.',
                'Cancelar',
                'Deletar',
              );

              if (response != null) {
                _onDeleteFlow(
                  cashFlow['id'].toString(),
                );
              }
            },
            icon: const Icon(Icons.delete),
          )
        ],
        title: Text(
          'Movimentação: ${cashFlow['reason']}',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: TextSizes.lg),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(PaddingSizes.md),
        child: Column(
          children: [
            CustomTextField(
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontWeight: FontWeight.w700,
              ),
              enabled: false,
              label: cashFlow['reason'].toString(),
              filled: true,
              borderColor: Theme.of(context)
                  .colorScheme
                  .inverseSurface
                  .withOpacity(0.45),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            CustomTextField(
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontWeight: FontWeight.w700,
              ),
              enabled: false,
              label: cashFlow['description'].toString(),
              filled: true,
              borderColor: Theme.of(context)
                  .colorScheme
                  .inverseSurface
                  .withOpacity(0.45),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            CustomTextField(
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontWeight: FontWeight.w700,
              ),
              enabled: false,
              label: cashFlow['isCashIn'].toString(),
              filled: true,
              borderColor: Theme.of(context)
                  .colorScheme
                  .inverseSurface
                  .withOpacity(0.45),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            CustomTextField(
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontWeight: FontWeight.w700,
              ),
              enabled: false,
              label: cashFlow['category'].toString(),
              filled: true,
              borderColor: Theme.of(context)
                  .colorScheme
                  .inverseSurface
                  .withOpacity(0.45),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            CustomTextField(
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontWeight: FontWeight.w700,
              ),
              enabled: false,
              label: 'R\$ ${cashFlow['amount'].toString()}',
              filled: true,
              borderColor: Theme.of(context)
                  .colorScheme
                  .inverseSurface
                  .withOpacity(0.45),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            CustomTextField(
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontWeight: FontWeight.w700,
              ),
              enabled: false,
              label: cashFlow['createdAt'].toString(),
              filled: true,
              borderColor: Theme.of(context)
                  .colorScheme
                  .inverseSurface
                  .withOpacity(0.45),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 5.7),
            CustomOutlinedButton(titulo: 'Editar', onPressed: () {})
          ],
        ),
      ),
    );
  }
}