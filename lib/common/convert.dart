class Convert {
  static String listToString(List<String> values) {
   return values.join("|");
  }
  static List<String> stringToList(String value) {
   return value.split('|').toList();
  }
}