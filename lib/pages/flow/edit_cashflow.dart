// ignore_for_file: use_build_context_synchronously

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:finance/components/buttons/custom_filled_button.dart';
import 'package:finance/components/helper/colors.dart';
import 'package:finance/components/helper/converters.dart';
import 'package:finance/components/helper/sizes.dart';
import 'package:finance/components/custom_form_field.dart';
import 'package:finance/components/tostification.dart';
import 'package:finance/models/cash_flow_models.dart';
import 'package:finance/providers/cash_flow_provider.dart';
import 'package:finance/services/api/cash_flow.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditCashFlow extends StatefulWidget {
  final String cashFlowId;
  const EditCashFlow({super.key, required this.cashFlowId});

  @override
  State<EditCashFlow> createState() => _EditCashFlowState();
}

class _EditCashFlowState extends State<EditCashFlow> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? selectedDate;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCashFlow();
  }

  Future<void> _loadCashFlow() async {
    var response = await CashFlowService.getCashFlowById(widget.cashFlowId);
    if (response['success'] == true) {
      var data = response['data'];
      setState(() {
        _titleController.text = data['reason'] ?? '';
        _descriptionController.text = data['description'] ?? '';
        _amountController.text = data['amount'].toString();
        selectedDate = DateTime.parse(data['createdAt']);
        context
            .read<CashFlowProvider>()
            .updateCategoryChoosed(data['category']);
        context.read<CashFlowProvider>().toggleIsCashIn(data['isCashIn']);
      });
    } else {
      showToast(context, {
        'statusCode': response['statusCode'],
        'message': response['message'] ?? 'Erro ao carregar a movimentação',
      });
    }
  }

  Future<void> _onUpdateFlow(Map<String, dynamic> updatedData) async {
    var response =
        await CashFlowService.updateCashFlow(widget.cashFlowId, updatedData);
    if (response['success'] == true) {
      var provider = context.read<CashFlowProvider>();
      provider.updateCashFlow(
          widget.cashFlowId, CashFlow.fromJson(response['data']));
      showToast(context, response);
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (_) => false,
      );
    } else {
      showToast(context, {
        'statusCode': response['statusCode'],
        'message': response['message'] ?? 'Erro ao atualizar a movimentação',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Editar movimentação',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: TextSizes.lg),
        ),
      ),
      body: Consumer<CashFlowProvider>(
        builder: (context, provider, _) => Padding(
          padding: const EdgeInsets.all(PaddingSizes.xl),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomTextField(
                      enabled: false,
                      filled: true,
                      controller: _titleController,
                      textInputAction: TextInputAction.next,
                      label: 'Título',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preencha esse campo';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    CustomTextField(
                      enabled: true,
                      filled: true,
                      controller: _descriptionController,
                      textInputAction: TextInputAction.next,
                      label: 'Descrição',
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    CustomTextField(
                      enabled: true,
                      filled: true,
                      controller: _amountController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      label: 'Valor',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preencha esse campo';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    OutlinedButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 365)),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null && picked != selectedDate) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                      child: Text(
                        'Data: ${selectedDate != null ? DateFormat('dd/MM/yyyy').format(selectedDate!) : 'Selecione'}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inverseSurface,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Column(
                      children: [
                        Text(
                          'Selecione uma categoria',
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inverseSurface),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 30,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              buttonStyleData: ButtonStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              iconStyleData: IconStyleData(
                                iconDisabledColor: Theme.of(context)
                                    .colorScheme
                                    .inverseSurface,
                                iconEnabledColor: Theme.of(context)
                                    .colorScheme
                                    .inverseSurface,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                elevation: 5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                              items: Category.values.map(
                                (category) {
                                  String categoryName =
                                      getStringFromCategory(category);
                                  return DropdownMenuItem<String>(
                                    value: categoryName,
                                    child: Text(
                                      categoryName,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inverseSurface,
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                              value: getStringFromCategory(
                                  provider.pickedCategory),
                              onChanged: (String? value) {
                                if (value != null) {
                                  provider.updateCategoryChoosed(value);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    GestureDetector(
                      onTap: () => provider.toggleIsCashIn(!provider.isCashIn!),
                      child: Card(
                        color: provider.isCashIn!
                            ? namedColors['blue']!.withOpacity(0.75)
                            : namedColors['red']!.withOpacity(0.75),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.35,
                            vertical: PaddingSizes.lg,
                          ),
                          child: Text(
                            provider.isCashIn! ? 'Entrada' : 'Saída',
                            style: TextStyle(
                              color: provider.isCashIn!
                                  ? Theme.of(context).colorScheme.surface
                                  : Theme.of(context)
                                      .colorScheme
                                      .inverseSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                    CustomFilledButton(
                      isLoading: isLoading,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          isLoading = true;
                          Map<String, dynamic> updatedData = {
                            "reason": _titleController.text,
                            "description": _descriptionController.text,
                            "category":
                                getStringFromCategory(provider.pickedCategory),
                            "amount": double.parse(_amountController.text),
                            "isCashIn": provider.isCashIn,
                            "createdAt": selectedDate!.toIso8601String(),
                          };
                          await _onUpdateFlow(updatedData);
                        }
                      },
                      titulo: 'Salvar',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
