import 'package:country_code_picker/country_code_picker.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Animation/FadeAnimation.dart';
import 'space_screen.dart';
import 'custom_top_bar.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splace(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController number = new TextEditingController();
  TextEditingController message = new TextEditingController();
  String dialCode = "+91";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _showDialog,
      child: Scaffold(
          appBar: TopBar(
            onPressed: () {},
            child: Text(''),
            title: "CliCk Chat",
          ),
          backgroundColor: Colors.teal,
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            colorFilter:
                                ColorFilter.mode(Colors.teal, BlendMode.color),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: FadeAnimation(
                              0.1,
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-2.png'))),
                              )),
                        ),
                        Positioned(
                          left: 150,
                          width: 80,
                          height: 150,
                          child: FadeAnimation(
                              0.1,
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/clock.png'))),
                              )),
                        ),
                        Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: FadeAnimation(
                              0.1,
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/light-1.png'),
                                  ),
                                ),
                              )),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CountryCodePicker(
                                      textStyle: TextStyle(color: Colors.white),
                                      onChanged: (country) {
                                        print(country.dialCode);
                                        dialCode = country.dialCode;
                                      },
                                      showFlag: true,
                                      hideSearch: false,
                                      initialSelection: 'IN',
                                      showFlagDialog: true,
                                    ),
                                    Expanded(
                                      child: FadeAnimation(
                                        0.2,
                                        Container(
                                          height: 60,
                                          child: TextFormField(
                                            controller: number,
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: (input) => input.length <
                                                    8
                                                ? 'Should be more than 8 characters'
                                                : null,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9]')),
                                            ],
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            cursorColor: Colors.white,
                                            cursorHeight: 25,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                            decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 2.0,
                                                  ),
                                                ),
                                                fillColor: Colors.white,
                                                hintText: " Phone number",
                                                labelText: " Phone number",
                                                labelStyle: TextStyle(
                                                    color: Colors.white),
                                                hintStyle: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 88),
                                  child: TextFormField(
                                    controller: message,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    // validator: (input) => input.length < 1
                                    //     ? 'Should be more than 1 characters'
                                    //     : null,
                                    maxLines: 5,

                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    cursorColor: Colors.white,
                                    cursorHeight: 25,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 2.0,
                                          ),
                                        ),
                                        fillColor: Colors.white,
                                        hintText: " Enter Message",
                                        labelText: " Enter Message",
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        hintStyle:
                                            TextStyle(color: Colors.white)),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                FadeAnimation(
                                    0.2,
                                    InkWell(
                                      onTap: () async {
                                        if (number.text != "" &&
                                            message.text != "") {
                                          bool isInstalled =
                                              await DeviceApps.isAppInstalled(
                                                  'com.whatsapp');

                                          if (isInstalled) {
                                            var mobile = dialCode + number.text;
                                            var msg = message.text;
                                            FlutterOpenWhatsapp
                                                .sendSingleMessage(mobile, msg);
                                          } else {
                                            launchURL(
                                                "https://play.google.com/store/apps/details?id=com.whatsapp");
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: LinearGradient(colors: [
                                              Colors.white,
                                              Colors.teal,
                                            ])),
                                        child: Center(
                                          child: Text(
                                            "Send",
                                            textScaleFactor: 1.5,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<bool> _showDialog() {
    return showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog(
                title: Text("Are you sure?"),
                content: Text("You want to exit app"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                  FlatButton(
                    child: Text("No"),
                    onPressed: () => Navigator.of(context).pop(false),
                  )
                ],
              );
            }) ??
        false;
  }
}
