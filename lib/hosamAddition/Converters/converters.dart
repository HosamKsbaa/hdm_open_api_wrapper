import 'package:intl/intl.dart';

class Converters {
  static String formatCurrency(double number) {
    // Format the number to show up to one decimal place
    String formatted = NumberFormat.currency(
      locale: 'en_US',
      symbol: 'د.ك.',
      customPattern: '#,##0.0 ¤',
    ).format(number);

    // // Trim trailing zeros and the decimal point if there are no decimals
    // if (formatted.contains('.0')) {
    //   formatted = formatted.replaceAll(RegExp(r'\.0+$'), '');
    // } else {
    //   formatted = formatted.replaceAll(RegExp(r'(\.\d*?[1-9])0+$'), r'\1');
    // }

    return formatted;
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
  }
}
