import 'package:agro_chain/screens/DistributerPage.dart';
import 'package:agro_chain/screens/Retailerpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:agro_chain/theme.dart';
import 'package:agro_chain/screens/reset_password.dart';
import 'package:agro_chain/screens/signup.dart';
import 'package:agro_chain/widgets/primary_button.dart';
import 'package:agro_chain/widgets/login_form.dart';
import 'package:agro_chain/screens/farmerpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);
  
  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  String? stakeRadioBtnVal;
  bool _isObscure = true;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email address';
  } 
  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
  }
  return null;
}

 String? validatePassword(String? value) {
  RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
          return null;
        }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        centerTitle: true,
        title: Text('Login as Stakeholder'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
              ),
              Text(
                'Welcome Back',
                style: titleText,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    'New to this app?',
                    style: subTitle,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: textButton.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildInputForm('Email', false,_emailController,validateEmail,(String? value){
                      _emailController.text = value!;
                    }),
                    buildInputForm('Password', true,_passwordController,validatePassword,(String? value) {
                      _passwordController.text = value!;
                    },),
                  ],
                ),

               ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: <Widget>[
                  Column(
                    children: [
                      RadioListTile(
                        title: Text("Farmer"),
                        value: "Farmer",
                        groupValue: stakeRadioBtnVal,
                        onChanged: (value) {
                          setState(() {
                            stakeRadioBtnVal = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text("Distributor"),
                        value: "Distributor",
                        groupValue: stakeRadioBtnVal,
                        onChanged: (value) {
                          setState(() {
                            stakeRadioBtnVal = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text("Retailer"),
                        value: "Retailer",
                        groupValue: stakeRadioBtnVal,
                        onChanged: (value) {
                          setState(() {
                            stakeRadioBtnVal = value.toString();
                          });
                        },
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPasswordScreen()));
                    },
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: kZambeziColor,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        signIn(_emailController.text, _passwordController.text);
                      },
                      child: PrimaryButton(buttonText: 'Login')),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void stakeholderChange() {
    if (stakeRadioBtnVal == "Farmer") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Farmer(),
          ));
    } else if (stakeRadioBtnVal == "Distributor") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Distributor(),
          ));
    } else if (stakeRadioBtnVal == "Retailer") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Retailer(),
          ));
    }
  }

  Padding buildInputForm(String label, bool pass, TextEditingController controller,String? Function(String?)? validator, void Function(String?)? onSaved) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: kTextFieldColor,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                  )
                : null),
                validator: validator,
                onSaved:onSaved
      ),
    );
  }

  void signIn(String email, String password) async {
    print(_emailController.text);
    print(_formKey.currentState?.validate());
    print("Oass");
    print(_passwordController.text);
    if (_formKey.currentState!.validate()) {
      print("Thus is sign in");
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  stakeholderChange()
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
