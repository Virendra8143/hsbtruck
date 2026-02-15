import 'package:intl/intl.dart';

String formatIndianAmount(String amount) {
  try {
    String cleanedAmount = amount.replaceAll(",", "");
    double value = double.parse(cleanedAmount);
    final formatter = NumberFormat.decimalPattern('en_IN');
    return formatter.format(value); // e.g. 75,982.00
  } catch (e) {
    return '0.00';
  }
}
