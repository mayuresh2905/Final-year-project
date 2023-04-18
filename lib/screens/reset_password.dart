import 'package:flutter/material.dart';
import 'package:agro_chain/screens/login_page.dart';
import 'package:agro_chain/theme.dart';
import 'package:agro_chain/widgets/primary_button.dart';
import 'package:agro_chain/widgets/reset_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Reset Password'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: kDefaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
            ),
            Text(
              'Reset Password',
              style: titleText,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Please enter your email address',
              style: subTitle.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: kTextFieldColor),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {

                _resetPassword(_emailController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => login_page(),
                  ),
                );
              },
              child: PrimaryButton(buttonText: 'Reset Password'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _resetPassword(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    // Show a success message to the user
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Password reset email sent'),
      duration: Duration(seconds: 3),
    ));
  } catch (e) {
    // Show an error message to the user
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Error resetting password'),
      duration: Duration(seconds: 3),
    ));
  }
}
}