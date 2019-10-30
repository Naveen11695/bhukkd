class GetterSetterBookingDetails {
  static String _bookingId;
  static String _resId;
  static String _resImageUrl;
  static String _resName;
  static String _resAddress;
  static String _resRating;
  static int _noOfTables;
  static double _avgCost;
  static double _securityPerPerson;
  static double _totalSecrityCost;
  static String _bookingDate;
  static String _timeSlot;
  static String _status;


  static String get bookingId => _bookingId;

  static set bookingId(String value) {
    _bookingId = value;
  }

  static String get resId => _resId;

  static set resId(String value) {
    _resId = value;
  }

  static String get resName => _resName;

  static String get timeSlot => _timeSlot;

  static set timeSlot(String value) {
    _timeSlot = value;
  }

  static String get bookingDate => _bookingDate;

  static set bookingDate(String value) {
    _bookingDate = value;
  }

  static double get totalSecrityCost => _totalSecrityCost;

  static set totalSecrityCost(double value) {
    _totalSecrityCost = value;
  }

  static double get securityPerPerson => _securityPerPerson;

  static set securityPerPerson(double value) {
    _securityPerPerson = value;
  }

  static double get avgCost => _avgCost;

  static set avgCost(double value) {
    _avgCost = value;
  }

  static int get noOfTables => _noOfTables;

  static set noOfTables(int value) {
    _noOfTables = value;
  }

  static String get resRating => _resRating;

  static set resRating(String value) {
    _resRating = value;
  }

  static String get resAddress => _resAddress;

  static set resAddress(String value) {
    _resAddress = value;
  }

  static set resName(String value) {
    _resName = value;
  }

  static String get resImageUrl => _resImageUrl;

  static set resImageUrl(String value) {
    _resImageUrl = value;
  }

  static String get status => _status;

  static set status(String value) {
    _status = value;
  }
}
