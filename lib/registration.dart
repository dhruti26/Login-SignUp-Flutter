import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'applogo.dart';
import 'loginPage.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;

  void registerUser() async{
    print('******************************************************************************************************************');
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      print('11111111111111111111111111111111111');

      var regBody = {
        "email":emailController.text,
        "password":passwordController.text
      };
      print(regBody);

      var response = await http.post(Uri.parse(registration),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(regBody)
      );
      print('222222222222222222222222');
      print(response);
      var jsonResponse = jsonDecode(response.body);
      print('3333333333333333333333333333333333333');

      print(jsonResponse['status']);

      if(jsonResponse['status']){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPage()));
      }else{
        print("SomeThing Went Wrong");
      }
    }else{
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [const Color(0xFFFFBF00),const Color(0xFF9932CC)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomCenter,
                stops: [0.0,0.8],
                tileMode: TileMode.mirror
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  HeightBox(10),
                  "CREATE YOUR ACCOUNT".text.size(22).yellow100.make(),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ).p4().px24(),
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      // suffixIcon: IconButton(icon: Icon(Icons.copy),onPressed: (){
                      //   final data = ClipboardData(text: passwordController.text);
                      //   Clipboard.setData(data);
                      // },),
                      // prefixIcon: IconButton(icon: Icon(Icons.password),onPressed: (){
                      //   String passGen =  generatePassword();
                      //   passwordController.text = passGen;
                      //   setState(() {
                      //
                      //   });
                      // },),
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ).p4().px24(),
                  HStack([
                    GestureDetector(
                      onTap: ()=>{
                        registerUser()
                      },
                      child: VxBox(child: "Register".text.white.makeCentered().p16()).green600.roundedLg.make().px16().py16(),
                    ),
                  ]),
                  GestureDetector(
                    onTap: (){
                      print("Sign In");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPage()));
                    },
                    child: HStack([
                      "Already Registered?".text.make(),
                      " Sign In".text.white.make()
                    ]).centered(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// String generatePassword() {
//   String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
//   String lower = 'abcdefghijklmnopqrstuvwxyz';
//   String numbers = '1234567890';
//   String symbols = '!@#\$%^&*()<>,./';
//
//   String password = '';
//
//   int passLength = 20;
//
//   String seed = upper + lower + numbers + symbols;
//
//   List<String> list = seed.split('').toList();
//
//   Random rand = Random();
//
//   for (int i = 0; i < passLength; i++) {
//     int index = rand.nextInt(list.length);
//     password += list[index];
//   }
//   return password;
// }