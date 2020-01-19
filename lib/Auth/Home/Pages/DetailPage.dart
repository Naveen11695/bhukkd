import 'package:bhukkd/Auth/Home/GetterSetter/GetterSetterAppConstant.dart';
import 'package:bhukkd/Auth/Home/GetterSetter/GetterSetterUserDetails.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class Account extends StatefulWidget {
  final String screenKey;

  Account(this.screenKey);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Size deviceSize;

  DateTime _date = DateTime(1980, 2, 20);

  String _gender = "default";

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _fillForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        color: SECONDARY_COLOR_1,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 10, right: 10),
              child: Card(
                color: Colors.white,
                elevation: 10,
                child: _buildForm(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 20.0),
              child: Container(
                child: new IconButton(
                  icon: new Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: Color.fromRGBO(249, 129, 42, 1),
                    size: 20.0,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Widget _buildForm() {
    Color _birthColor;
    _date == DateTime(1980, 2, 20)
        ? _birthColor = Colors.grey
        : _birthColor = Colors.green;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                _Text("PRIMARY DETAILS"),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        _buildText(
                            "First name *",
                            "Enter your first name",
                            FontAwesomeIcons.userCircle,
                            _firstNameController,
                            false,
                            TextInputType.text,
                            1,
                            1,
                            _validateFirstName,
                            null,
                            "Value Can\'t Be Empty",
                            TextCapitalization.characters),
                        _buildText(
                            "Middle name",
                            "Enter your middle name",
                            FontAwesomeIcons.userCircle,
                            _middleNameController,
                            false,
                            TextInputType.text,
                            1,
                            1,
                            false,
                            null,
                            "Value Can\'t Be Empty",
                            TextCapitalization.characters),
                        _buildText(
                            "Last name *",
                            "Enter your last name",
                            FontAwesomeIcons.userCircle,
                            _lastNameController,
                            false,
                            TextInputType.text,
                            1,
                            1,
                            _validateLastName,
                            null,
                            "Value Can\'t Be Empty",
                            TextCapitalization.characters),
                        new ListTile(
                          leading: const Icon(
                            FontAwesomeIcons.birthdayCake,
                            color: Color.fromRGBO(249, 129, 42, 1),
                          ),
                          title: const Text(
                            'Birthday *',
                            style: TextStyle(
                              letterSpacing: 1.0,
                              color: Colors.black45,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: FONT_TEXT_PRIMARY,
                            ),
                          ),
                          subtitle: Text(
                            (_date == null)
                                ? 'February 20, 1980'
                                : _formatDate(_date),
                            style: TextStyle(
                              letterSpacing: 1.0,
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontFamily: FONT_TEXT_PRIMARY,
                            ),
                          ),
                          trailing: Icon(
                            Icons.check_circle,
                            color: _birthColor,
                          ),
                          onTap: () {
                            setState(() {
                              _datePicker();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Card(
                    elevation: 10,
                    child: RadioButtonGroup(
                        labels: <String>[
                          "Male",
                          "Female",
                          "Others",
                        ],
                        picked: _gender,
                        margin: EdgeInsets.all(8.0),
                        activeColor: Color.fromRGBO(249, 129, 42, 1),
                        orientation: GroupedButtonsOrientation.HORIZONTAL,
                        onSelected: (String selected) {
                          setState(() {
                            _gender = selected;
                          });
                        }),
                  ),
                ),
                _Text("SECONDARY DETAILS"),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        _buildText(
                            "Phone number *",
                            "Enter your phone number",
                            FontAwesomeIcons.mobile,
                            _phoneController,
                            false,
                            TextInputType.phone,
                            1,
                            1,
                            _validatePhone,
                            10,
                            "Invaild phone number",
                            TextCapitalization.characters),
                        _buildText(
                            "Email id",
                            "Enter your email id",
                            FontAwesomeIcons.envelope,
                            _emailController,
                            true,
                            TextInputType.emailAddress,
                            1,
                            1,
                            false,
                            null,
                            "Value Can\'t Be Empty",
                            TextCapitalization.characters),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              _buildText(
                                  "Address *",
                                  "Enter your address",
                                  FontAwesomeIcons.home,
                                  _addressController,
                                  false,
                                  TextInputType.text,
                                  3,
                                  0.70,
                                  _validateAddress,
                                  null,
                                  "Value Can\'t Be Empty",
                                  TextCapitalization.sentences),
                              InkWell(
                                splashColor: Colors.white24,
                                highlightColor: Colors.white10,
                                child: Icon(
                                  Icons.location_searching,
                                  color: Color.fromRGBO(249, 129, 42, 1),
                                ),
                                onTap: () {
                                  _addressController.text =
                                      GetterSetterAppConstant.address;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _Text("ADDTIONAL DETAILS"),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        _buildText(
                            "Description",
                            'Tell us a little something about yourself (in less than 150 characters)',
                            Icons.description,
                            _descriptionController,
                            false,
                            TextInputType.text,
                            7,
                            1,
                            false,
                            150,
                            "Value Can\'t Be Empty",
                            TextCapitalization.sentences),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            child: semi_circlar_button("Proceed", saveDetails),
          ),
        ],
      ),
    );
  }

  _Text(String text) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 25,
            fontFamily: FONT_TEXT_PRIMARY,
            fontWeight: FontWeight.bold,
            wordSpacing: 2.0,
            color: Colors.black54,
            letterSpacing: 1.5),
      ),
    );
  }

  Widget _buildText(
      String title,
      String hint,
      IconData icon,
      TextEditingController controller,
      bool enable,
      TextInputType textInputType,
      int maxLine,
      double size,
      _validate,
      int _maxlength,
      String _errorMessage,
      TextCapitalization capitalised) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: deviceSize.width * size,
        child: TextField(
          enabled: !enable,
          textCapitalization: capitalised,
          controller: controller,
          keyboardType: textInputType,
          maxLines: maxLine,
          style: new TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontFamily: FONT_TEXT_PRIMARY,
              letterSpacing: 1.0,
              wordSpacing: 2.0),
          decoration: new InputDecoration(
            errorText: _validate ? _errorMessage : null,
            errorStyle: new TextStyle(
              letterSpacing: 1.0,
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 10,
              fontFamily: FONT_TEXT_SECONDARY,
            ),
            border: null,
            fillColor: Color.fromRGBO(249, 129, 42, 1),
            focusedBorder: new OutlineInputBorder(
                borderSide:
                    new BorderSide(color: Colors.transparent, width: 5.0),
                borderRadius: BorderRadius.circular(30.0)),
            hintText: hint,
            labelText: title,
            labelStyle: new TextStyle(
              letterSpacing: 1.0,
              color: Colors.black45,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: FONT_TEXT_PRIMARY,
            ),
            hintStyle: new TextStyle(
              letterSpacing: 1.0,
              color: Colors.black45,
              fontSize: 15,
              fontFamily: FONT_TEXT_PRIMARY,
            ),
            prefixIcon: Icon(
              icon,
              color: Color.fromRGBO(249, 129, 42, 1),
            ),
          ),
          maxLength: _maxlength,
        ),
      ),
    );
  }

  void _fillForm() async {
    await _auth.currentUser().then((val) {
      if (val != null) {
        setState(() {
          _firstNameController.text = GetterSetterUserDetails.firstName;
          _middleNameController.text = GetterSetterUserDetails.middleName;
          _lastNameController.text = GetterSetterUserDetails.lastName;
          if (GetterSetterUserDetails.dob != null) {
            _date = DateTime(
                int.parse(GetterSetterUserDetails.dob.split(":")[2].trim()),
                int.parse(GetterSetterUserDetails.dob.split(":")[1].trim()),
                int.parse(GetterSetterUserDetails.dob.split(":")[0].trim()));
          }
          if (GetterSetterUserDetails.gender != null)
            _gender = GetterSetterUserDetails.gender;
          _phoneController.text = GetterSetterUserDetails.phoneNumber;
          _emailController.text = val.email;
          _addressController.text =
              capitalizeFirstLetter(GetterSetterUserDetails.address);
          _descriptionController.text =
              capitalizeFirstLetter(GetterSetterUserDetails.description);
        });
      }
    });
  }

  String capitalizeFirstLetter(String s) =>
      (s?.isNotEmpty ?? false) ? '${s[0].toUpperCase()}${s.substring(1)}' : s;

  saveDetails() async {
    _auth.currentUser().then((val) {
      if (val != null) {
        if (validateForm()) {
          var fireStore = Firestore.instance;
          DocumentReference documentReference =
              fireStore.collection('UsersData').document(val.email);
          documentReference.get().then((dataSnapshot) {
            if (dataSnapshot.exists) {
              documentReference.updateData({
                "FirstName": _firstNameController.text,
                "MiddleName": _middleNameController.text,
                "LastName": _lastNameController.text,
                "Dob": _date.day.toString() +
                    " : " +
                    _date.month.toString() +
                    " : " +
                    _date.year.toString(),
                "Gender": _gender,
                "PhoneNumber": _phoneController.text,
                "EmailId": _emailController.text,
                "Address": _addressController.text,
                "Description": _descriptionController.text
              }).whenComplete(() {
                setData(val.email);
                print("Successfull: UserDetails update");
                Navigator.pop(context);
              }).catchError((e) {
                print("Error: UserDetails update" + e.toString());
              });
            } else {
              documentReference.setData({
                "FirstName": _firstNameController.text,
                "MiddelName": _middleNameController.text,
                "LastName": _lastNameController.text,
                "Dob": _date.day.toString() +
                    " : " +
                    _date.month.toString() +
                    " : " +
                    _date.year.toString(),
                "Gender": _gender,
                "PhoneNumber": _phoneController.text,
                "EmailId": _emailController.text,
                "Address": _addressController.text,
                "Description": _descriptionController.text
              }).whenComplete(() {
                setData(val.email);
                print("Successfull: UserDetails add");
                Navigator.pop(context);
              }).catchError((e) {
                print("Error: UserDetails add" + e.toString());
              });
            }
          });
        } else {
          setState(() {
            if (!_validateFirstName &&
                !_validateLastName &&
                !_validatePhone &&
                !_validateAddress) {
              if (_validateGender) {
                var snackBar =
                    SnackBar(content: Text("Please select the your gender"));
                scaffoldKey.currentState.showSnackBar(snackBar);
              }
            }
          });
        }
      }
    });
  }

  _formatDate(DateTime date) {
    return formatDate(
        _date,
        (_date.day == 1)
            ? ['MM', ' ', 'd', 'st ', ', ', 'yyyy']
            : (_date.day == 2)
                ? ['MM', ' ', 'd', 'nd ', ', ', 'yyyy']
                : ['MM', ' ', 'd', 'th ', ', ', 'yyyy']);
  }

  _datePicker() {
    return DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1980, 2, 20),
        maxTime: DateTime.now(), onConfirm: (date) {
      setState(() {
        _date = date;
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  bool _validateFirstName = false;
  bool _validateLastName = false;
  bool _validatePhone = false;
  bool _validateAddress = false;
  bool _validateGender = false;

  bool validateForm() {
    _firstNameController.text.isEmpty
        ? _validateFirstName = true
        : _validateFirstName = false;
    _lastNameController.text.isEmpty
        ? _validateLastName = true
        : _validateLastName = false;
    _gender.compareTo("default") == 0
        ? _validateGender = true
        : _validateGender = false;
    _phoneController.text.trim().length != 10
        ? _validatePhone = true
        : _validatePhone = false;
    _addressController.text.isEmpty
        ? _validateAddress = true
        : _validateAddress = false;
    if (!_validateFirstName &&
        !_validateLastName &&
        !_validateGender &&
        !_validatePhone &&
        !_validateAddress) {
      return true;
    } else {
      return false;
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void setData(String email) async {
    GetterSetterUserDetails.firstName = _firstNameController.text;
    GetterSetterUserDetails.middleName = _middleNameController.text;
    GetterSetterUserDetails.lastName = _lastNameController.text;
    GetterSetterUserDetails.dob = _date.day.toString() +
        " : " +
        _date.month.toString() +
        " : " +
        _date.year.toString();
    GetterSetterUserDetails.gender = _gender;
    GetterSetterUserDetails.phoneNumber = _phoneController.text;
    GetterSetterUserDetails.emailId = email;
    GetterSetterUserDetails.address = _addressController.text;
    GetterSetterUserDetails.description = _descriptionController.text;
  }
}
