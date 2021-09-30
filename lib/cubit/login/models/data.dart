class Data {
  Data({
    this.userId = '',
    this.userName = '',
    this.email = '',
    this.password = '',
    this.verifyCode = '',
    this.isNameValid = false,
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isCodeValid = false,
    this.verifiedOne = false,
    this.verifiedTwo = false,
    this.verifiedThree = false,
    this.isLogged = false,
    this.isVerified = false,
    this.currentLoginTab = 0,
    this.message = '',
  });

  String userId;

  String userName;
  String email;
  String password;
  String? verifyCode;

  bool isNameValid;
  bool isEmailValid;
  bool isPasswordValid;
  bool isCodeValid;

  bool verifiedOne;
  bool verifiedTwo;
  bool verifiedThree;

  bool? isLogged;
  bool? isVerified;

  int currentLoginTab;

  String message;

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

    isLogged = false;
    isVerified = false;

    currentLoginTab = 0;
  }
}
