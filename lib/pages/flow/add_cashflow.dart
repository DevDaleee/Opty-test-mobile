import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:finance/components/helper/colors.dart';
import 'package:finance/components/helper/sizes.dart';
import 'package:finance/components/tostification.dart';
import 'package:finance/models/cash_flow_models.dart';
import 'package:finance/providers/cash_flow_provider.dart';
import 'package:finance/services/api/cash_flow.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddCashFlow extends StatefulWidget {
  const AddCashFlow({super.key});

  @override
  State<AddCashFlow> createState() => _AddCashFlowState();
}

class _AddCashFlowState extends State<AddCashFlow> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? selectedDate = DateTime.now();
  bool isCashIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Cadastrar nova movimentação',
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
                    // Campo: Título
                    TextFormField(
                      controller: _titleController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: 'Título'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preecha esse campo';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                    // Campo: Descrição
                    TextFormField(
                      controller: _descriptionController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: 'Descrição'),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                    // Campo: Valor
                    TextFormField(
                      controller: _amountController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'Valor'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preecha esse campo';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                    // Botão: Seletor de Data
                    OutlinedButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate!,
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
                        'Data: ${DateFormat('dd/MM/yyyy').format(selectedDate!)}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inverseSurface,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                    // Dropdown: Categoria
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
                                      provider.getStringFromCategory(category);
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
                              value: provider.getStringFromCategory(
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

                    // Botão: Entrada/Saída
                    GestureDetector(
                      onTap: () => provider.isCashIn = !provider.isCashIn,
                      child: Card(
                        color: provider.isCashIn
                            ? namedColors['blue']!.withOpacity(0.75)
                            : namedColors['red']!.withOpacity(0.75),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.35,
                            vertical: PaddingSizes.lg,
                          ),
                          child: Text(
                            provider.isCashIn ? 'Entrada' : 'Saída',
                            style: TextStyle(
                              color: provider.isCashIn
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

                    // Botão: Salvar
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> data = {
                            "reason": _titleController.text,
                            "description": _descriptionController.text,
                            "category": provider
                                .getStringFromCategory(provider.pickedCategory),
                            "amount": double.parse(_amountController.text),
                            "isCashIn": provider.isCashIn,
                            "createdAt": selectedDate!.toIso8601String(),
                          };
                          Map<String, dynamic> response =
                              await CashFlowService.addCashFlow(data);
                          if (context.mounted) {
                            showToast(context, response);
                            await 
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/home',
                              (_) => false,
                            );
                          }
                        }
                      },
                      child: const Text('Salvar'),
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
