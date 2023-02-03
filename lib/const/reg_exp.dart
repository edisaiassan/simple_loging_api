bool emailValidate(String email) {
  bool valido = true;
  if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email) ==
      false) {
    valido = false;
  }
  return valido;
}

bool passwordValidate(String value) {
  return value
      .contains(RegExp(r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$'));
}

bool userNameValidate(String value) {
  return value
      .contains(RegExp(r'^[a-zA-Z]+\d*$'));
}
