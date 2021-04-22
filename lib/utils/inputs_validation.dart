class InputsValidator {
  static String inputEmpty(String data) {
    if (data.isEmpty) return "Asegurese de llenar este dato";
    return null;
  }
}
