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

class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);
  

  @override
  State<login_page> createState() => _login_pageState();
  
}

class _login_pageState extends State<login_page> {
 
 String? stakeRadioBtnVal ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
              LogInForm(),
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
          onChanged: (value){
            setState(() {
                stakeRadioBtnVal = value.toString();
            });
          },
      ),

      RadioListTile(
          title: Text("Distributor"),
          value: "Distributor", 
          groupValue: stakeRadioBtnVal, 
          onChanged: (value){
            setState(() {
                stakeRadioBtnVal = value.toString();
            });
          },
      ),

      RadioListTile(
            title: Text("Retailer"),
            value: "Retailer", 
            groupValue: stakeRadioBtnVal, 
            onChanged: (value){
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
                  stakeholderChange();
                },
                child: PrimaryButton(buttonText: 'Login')),
              SizedBox(
                height: 20,
              ),
             
            ],
          
           ) ],
        ),
      
      ),
    ),
    );
   
  }
  void stakeholderChange() {
     
      if (stakeRadioBtnVal=="Farmer"){

         Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Farmer(),
                      ));
      }
      else if(stakeRadioBtnVal=="Distributor"){
         Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Distributor(),
                      ));

      }
      else if(stakeRadioBtnVal=="Retailer"){
         Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Retailer(),
                      ));

      }
}
}


