import 'package:finance/providers/boot_provider.dart';
import 'package:finance/providers/theme_provider.dart';
import 'package:finance/providers/user_provider.dart';
import 'package:finance/providers/cash_flow_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers() {
  return [
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => BootProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => CashFlowProvider()),
  ];
}
