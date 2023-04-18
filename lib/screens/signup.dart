import 'package:flutter/material.dart';
import 'package:agro_chain/screens/login_page.dart';
import 'package:agro_chain/theme.dart';
import 'package:agro_chain/widgets/checkbox.dart';
import 'package:agro_chain/widgets/primary_button.dart';
import 'package:agro_chain/widgets/signup_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agro_chain/models/Data_models.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;

  

  
  // string for displaying the error Message
  String? errorMessage;
  
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNamecontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController qualificationcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController cpasswordcontroller = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  
  
  
  
  
  bool _isObscure = true;

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
        }
        
  String? validateUserName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your username';
  } 
  
  return null;
}

 String? validatelocation(String? value) {
          if (value!.isEmpty) {
            return ("location is required for login");
          }
         
        }

 String? validateQualification(String? value) {
          if (value!.isEmpty) {
            return ("Qualification is required for login");
          }
         
        }
  

 String? validateCPassword(String? value) {
          return null;
    }
 Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      print(e.toString());
    }
  }
  
  @override
  Widget build(BuildContext context) {

    

  
  
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Stakeholder Registration form'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: kDefaultPadding,
              child: Text(
                'Create Account',
                style: titleText,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: kDefaultPadding,
              child: Row(
                children: [
                  Text(
                    'Already a member?',
                    style: subTitle,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      signUp(emailController.text
                      , passwordcontroller.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => login_page()));
                    },
                    child: Text(
                      'Log In',
                      style: textButton.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: kDefaultPadding,
              child: Form(key: _formKey,child:Column(
                children: [
                  buildInputForm(' Username', false,userNamecontroller,validateUserName,(String? value){
                  userNamecontroller.text = value!;
                 }),
                  buildInputForm('Email', false,emailController,validateEmail,(String? value){
                  emailController.text = value!;
                 }),
                  comboBox('Select Occupation', ['Farmer', 'Distributor', 'Retailer'], occupationController, ['farmer', 'distributor', 'retailer']),
                  buildInputForm('Location', false,locationcontroller,validatelocation,(String? value){
                  locationcontroller.text = value!;
                 }),
                  buildInputForm('Qualification', false, qualificationcontroller,validateQualification,(String? value){
                  qualificationcontroller.text = value!;
                 }),
                  buildInputForm('Password', true,passwordcontroller,validatePassword,(String? value){
                  passwordcontroller.text = value!;
                 }),
                  buildInputForm('Confirm Password', true,cpasswordcontroller,validateCPassword,(String? value){
                  cpasswordcontroller.text = value!;
                 }),
                ],
              ), ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: kDefaultPadding,
              child: PrimaryButton(buttonText: 'Sign Up',onTap: () => signUp(emailController.text, passwordcontroller.text),),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
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

  Widget comboBox(String hint, List<String> items, TextEditingController controller, List<String> values) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: kTextFieldColor),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: kPrimaryColor)),
      ),
      items: List.generate(
        items.length,
        (index) => DropdownMenuItem<String>(
          value: values[index],
          child: Text(items[index]),
        ),
      ),
      value: controller.text.isEmpty ? null : controller.text,
      onChanged: (String? newValue) {
        if (newValue != null) {
          controller.text = newValue;
        }
      },
    ),
  );
}

 void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
       
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
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
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.UserName = userNamecontroller.text;
    userModel.location = locationcontroller.text;
    userModel.Occupation = occupationController.text;
    userModel.Qualification =qualificationcontroller.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => login_page()),
        (route) => false);
  }
}