import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:flutter/material.dart';
import '../Pages/Details.dart';
import '../Components/CustomComponets.dart';
class otp extends StatefulWidget {
  _otpState createState() => new _otpState();
}

class _otpState extends State<otp> {
  FocusNode focus1 = FocusNode();
  FocusNode focus2 = FocusNode();
  FocusNode focus3 = FocusNode();
  FocusNode focus4 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView(children:[
        getOtp(),
        new Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 20, 0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepOrangeAccent
                  ), 
                  child: Center(child:TextField(
                    autofocus: true,
                    focusNode: focus1,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 28
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "0",
                    ),
                    onChanged: (String newVal) {
                      if (newVal.length == 1) {
                        focus1.unfocus();
                        FocusScope.of(context).requestFocus(focus2);
                      }
                    },
                  ),
                ),),
                SizedBox(width: 5,),
                Container(
                   height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepOrangeAccent
                  ), 
                  child: Center(child:TextField(
                    textAlign: TextAlign.center,
                    focusNode: focus2,
                    keyboardType: TextInputType.number,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 28
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "0",
                    ),
                    onChanged: (String newVal) {
                      if (newVal.length == 1) {
                        focus2.unfocus();
                        FocusScope.of(context).requestFocus(focus3);
                      }
                    },
                  ),
                ),),
                SizedBox(width: 5,),
                Container(
                   height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepOrangeAccent
                  ), 
                  child: Center(child:TextField(
                    textAlign: TextAlign.center,
                    focusNode: focus3,
                    keyboardType: TextInputType.number,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 28
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "0",
                    ),
                    onChanged: (String newVal) {
                      if (newVal.length == 1) {
                        focus3.unfocus();
                        FocusScope.of(context).requestFocus(focus4);
                      }
                    },
                  ),
                ),),
                SizedBox(width: 5,),
                Container(
                   height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepOrangeAccent
                  ), 
                  child: Center(child:TextField(
                    textAlign: TextAlign.center,
                    focusNode: focus4,
                    keyboardType: TextInputType.number,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 28
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "0",
                    ),
                  ),
                ),)
              ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
          child: new InkWell(
            child: new Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.deepOrangeAccent),
              child: new Icon(
                Icons.arrow_forward,
                size: 20.0,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Details()),
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget getOtp() {
    return new Stack(
      children: <Widget>[
        background,
        Container(
          color: Color.fromRGBO(255, 255, 255, 150),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
          child: new Text(
            "Verify Your Number",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 60.0,
              color: Colors.deepOrangeAccent,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 280, 20, 40),
          child: new Text(
            "Enter the otp sent to your number",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.normal,
              fontSize: 20.0,
              decorationColor: Colors.white30,
            ),
          ),
        ),
        /*new TextFormField(
          decoration: new InputDecoration(
              hintText: 'Enter otp',
              border: new OutlineInputBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(10.0))
              ),
          ),
          keyboardType: TextInputType.number,
          maxLength: 6,
        ),*/
        
       
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(20, 400, 20, 0),
        //   child :new TextField(
        //     keyboardType: TextInputType.phone,
        //     textAlign: TextAlign.center,
        //     decoration: new InputDecoration(
        //         border: new OutlineInputBorder(
        //           borderRadius: const BorderRadius.all(
        //             const Radius.circular(30.0),
        //           ),
        //         ),
        //         filled: true,
        //         hintStyle: new TextStyle(color: Colors.grey[800]),
        //         hintText: "Enter OTP",
        //         fillColor: Colors.white70,
        //       labelText: 'OTP',
        //       prefixIcon: const Icon(
        //         Icons.format_list_numbered,
        //         color: Colors.deepOrangeAccent,
        //       ),
        //     ),
        //     maxLength: 6,
        //   ),
        //   ),
        
        /*new RaisedButton(
            padding: new EdgeInsets.fromLTRB(80.0, 10.0, 80.0, 10.0),
            color: Colors.deepOrangeAccent,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0)),
            child: new Text(
              "Resend",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 30.0,
              ),
            ),
            onPressed: () {}),*/
      ],
    );
  }
}
