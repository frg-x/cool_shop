class Data {
  Data({
    required this.userId,
    required this.userName,
    required this.email,
    required this.password,
    required this.verifyCode,
    required this.isNameValid,
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.verifiedOne,
    required this.verifiedTwo,
    required this.verifiedThree,
    required this.isCodeFilled,
    required this.isLogged,
    required this.isVerified,
    required this.currentLoginTab,
  });

  String userId;

  String userName;
  String email;
  String password;
  String? verifyCode;

  bool isNameValid;
  bool isEmailValid;
  bool isPasswordValid;

  bool verifiedOne;
  bool verifiedTwo;
  bool verifiedThree;

  bool isCodeFilled;

  bool? isLogged;
  bool? isVerified;

  int currentLoginTab;

  void clear() {
    userId = '';

    userName = '';
    email = '';
    password = '';
    verifyCode = '';

    isNameValid = false;
    isEmailValid = false;
    isPasswordValid = false;

    verifiedOne = false;
    verifiedTwo = false;
    verifiedThree = false;

    isCodeFilled = false;

    isLogged = false;
    isVerified = false;

    currentLoginTab = 0;
  }
}
