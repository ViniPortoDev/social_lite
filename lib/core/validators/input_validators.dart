import 'package:get/get.dart';

class InputValidators {
  static String digitsOnly(String value) => value.replaceAll(RegExp(r'\D'), '');

  static bool isValidEmail(String value) {
    final v = value.trim();
    return v.isNotEmpty && GetUtils.isEmail(v);
  }

  static bool isValidBrPhone(String value) {
    final digits = digitsOnly(value);
    return digits.length == 11;
  }

  static bool isValidCpf(String value) {
    final cpf = digitsOnly(value);
    if (cpf.length != 11) return false;
    if (RegExp(r'^(\d)\1{10}$').hasMatch(cpf)) return false;

    final nums = cpf.split('').map(int.parse).toList(growable: false);

    int calcDigit(int count) {
      var sum = 0;
      var weight = count + 1;
      for (var i = 0; i < count; i++) {
        sum += nums[i] * (weight - i);
      }
      final mod = sum % 11;
      return mod < 2 ? 0 : 11 - mod;
    }

    final d1 = calcDigit(9);
    final d2 = calcDigit(10);
    return nums[9] == d1 && nums[10] == d2;
  }

  static DateTime? parseBrazilDate(String value) {
    final v = value.trim();
    final m = RegExp(r'^(\d{2})\/(\d{2})\/(\d{4})$').firstMatch(v);
    if (m == null) return null;

    final day = int.tryParse(m.group(1)!);
    final month = int.tryParse(m.group(2)!);
    final year = int.tryParse(m.group(3)!);
    if (day == null || month == null || year == null) return null;
    if (year < 1900 || year > 2100) return null;

    final dt = DateTime(year, month, day);
    if (dt.year != year || dt.month != month || dt.day != day) return null;

    final now = DateTime.now();
    if (dt.isAfter(DateTime(now.year, now.month, now.day))) return null;

    return dt;
  }
}
