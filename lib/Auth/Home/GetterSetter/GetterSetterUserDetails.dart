class GetterSetterUserDetails {
  static String _firstName;
  static String _middleName;
  static String _lastName;
  static String _dob;
  static String _gender;
  static String _phoneNumber;
  static String _emailId;
  static String _address;
  static String _description;

  GetterSetterUserDetails();

  static String get description => _description;

  static set description(String value) {
    _description = value;
  }

  static String get address => _address;

  static set address(String value) {
    _address = value;
  }

  static String get emailId => _emailId;

  static set emailId(String value) {
    _emailId = value;
  }

  static String get phoneNumber => _phoneNumber;

  static set phoneNumber(String value) {
    _phoneNumber = value;
  }

  static String get gender => _gender;

  static set gender(String value) {
    _gender = value;
  }

  static String get dob => _dob;

  static set dob(String value) {
    _dob = value;
  }

  static String get lastName => _lastName;

  static set lastName(String value) {
    _lastName = value;
  }

  static String get middleName => _middleName;

  static set middleName(String value) {
    _middleName = value;
  }

  static String get firstName => _firstName;

  static set firstName(String value) {
    _firstName = value;
  }
}
