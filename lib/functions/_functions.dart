import 'package:intl/intl.dart';

class CurrencyFormat {
  static String convertToIdr(String number, int decimalDigits) {
    int parseNumber = int.parse(number);
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp.',
      decimalDigits: decimalDigits,
    );
    return currencyFormatter.format(parseNumber);
  }
}

class DiscountCount {
  static String mathDiscount(String priceBeforeDiscount, String discount) {
    int parsePriceBeforeDiscount = int.parse(priceBeforeDiscount);
    double parseDiscount = double.parse(discount);

    double priceAfterDiscount = parsePriceBeforeDiscount -
        (parsePriceBeforeDiscount * (parseDiscount / 100));

    return priceAfterDiscount.toInt().toString();
  }
}

class Date {
  static String formatted(timestamp) {
    DateTime time = DateTime.parse(timestamp);

    String formattedDateTime = DateFormat('dd MMM yyyy').format(time);

    return formattedDateTime;
  }
}

class Validator {
  static errorMessage(value, message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
