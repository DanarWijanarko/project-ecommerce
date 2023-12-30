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
