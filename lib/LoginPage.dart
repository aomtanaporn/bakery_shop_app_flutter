import 'package:final_project/HomePage.dart';
import 'package:final_project/Robot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    MyStore central = Provider.of<MyStore>(context, listen: false);
      central.getFoodItem();

    super.initState();
  }

  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: h * 0.9,
        padding: EdgeInsets.only(top: h * 0.1, left: w * 0.1, right: w * 0.1),
        child: LoginForm(
          w: w,
          h: h,
        ),
      ),
      persistentFooterButtons: <Widget>[
        Container(
            height: h * 0.05,
            width: w * 1.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Don't Have an Account?"),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "  SignUp",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.redAccent),
                  ),
                )
              ],
            ))
      ],
      resizeToAvoidBottomPadding: false,
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key key,
    @required this.w,
    @required this.h,
  }) : super(key: key);

  final double w;
  final double h;

//
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool success;
  String userEmail;
  String password;

//  bool google_login;

  @override
  Widget build(BuildContext context) {
    var agent = Provider.of<MyStore>(context);
    _usernameController.text = "aomtanaporn";
    _passwordController.text = "123456";
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              width: widget.w * 0.5,
              alignment: Alignment.center,
              child: Image.asset("assets/Logo/cupcake.png"),
            ),
            SizedBox(
              height: widget.h * 0.05,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return "This is required field";
                }
                return null;
              },
              controller: _usernameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "Username"),
            ),
            SizedBox(
              height: widget.h * 0.03,
            ),
            PasswordFormField(
              controller: _passwordController,
            ),
            Container(
                padding: EdgeInsets.only(
                    top: widget.h * 0.04, left: widget.w * 0.45),
                child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(color: Colors.blue),
                    ))),
            SizedBox(
              height: widget.h * 0.05,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: widget.w,
              height: widget.h * 0.13,
              child: RaisedButton(
                onPressed: () async {
                  final String verified = await agent.login(_usernameController.text, _passwordController.text);
                  if(_formKey.currentState.validate()){

                    if(verified == "yes"){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                    else{
                      AlertDialog alert = AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        title: Text("Log-in failed"),
                        content: Text("Please try again"),
                        actions: [
                          RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text("okay"),
                              onPressed: () {
                                Navigator.pop(context);
                              })
                        ],
                      );

                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );

                    }
                  }

                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                child: Text(
                  "Log-in",
                  style: TextStyle(
                      color: Colors.white, letterSpacing: 2, fontSize: 25),
                ),
                color: Colors.blue,
                highlightElevation: 0,
              ),
            ),
            SizedBox(
              height: widget.h * 0.01,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class PasswordFormField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordFormField({Key key, @required this.controller})
      : assert(controller != null),
        super(key: key);

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "This is required field";
        }
        return null;
      },
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        hintText: "Password",
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
          child: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
        ),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      ),
      obscureText: !_showPassword,
    );
  }
} //ec
