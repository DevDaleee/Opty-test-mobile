import 'package:finance/models/cash_flow_models.dart';

String getMonthByNumber(int weekday) {
  switch (weekday) {
    case 1:
      return 'Jan';
    case 2:
      return 'Fev';
    case 3:
      return 'Mar';
    case 4:
      return 'Abr';
    case 5:
      return 'Mai';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Ago';
    case 9:
      return 'Set';
    case 10:
      return 'Out';
    case 11:
      return 'Nov';
    case 12:
      return 'Dez';
    default:
      return '';
  }
}

String getSelectedFilter(int selectedFilterIndex) {
  switch (selectedFilterIndex) {
    case 0:
      return 'Somente Entradas';
    case 1:
      return 'Somente Saídas';
    case 2:
      return 'Mais Recente';
    case 3:
      return 'Mais Antigo';
    default:
      return 'Mais Recente';
  }
}

Category getCategoryFromString(String categoryString) {
  switch (categoryString) {
    case 'Saúde':
      return Category.HEALTH;
    case 'Casa':
      return Category.HOUSING;
    case 'Investimentos':
      return Category.INVESTMENTS;
    case 'Comida':
      return Category.FOOD;
    case 'Entretenimento':
      return Category.INSURE;
    case 'Outro':
      return Category.OTHER;
    default:
      throw Exception('Categoria desconhecida: $categoryString');
  }
}

String getStringFromCategory(Category category) {
  switch (category) {
    case Category.HEALTH:
      return 'Saúde';
    case Category.HOUSING:
      return 'Casa';
    case Category.INVESTMENTS:
      return 'Investimentos';
    case Category.FOOD:
      return 'Comida';
    case Category.INSURE:
      return 'Entretenimento';
    case Category.OTHER:
      return 'Outro';
  }
}
