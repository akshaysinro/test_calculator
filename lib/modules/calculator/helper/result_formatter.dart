class ResultFormatter {
  static String format(String valueStr) {
    if (valueStr.endsWith(".0")) {
      return valueStr.substring(0, valueStr.length - 2);
    }
    return valueStr;
  }
}
