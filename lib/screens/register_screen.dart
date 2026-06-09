import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad/screens/forget_password_screen.dart';
import 'package:mad/screens/main_screen.dart';
import 'package:mad/widgets/app_logo.dart' as appLogo;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool _isLoading = false;
  bool _obscureText = true;
  bool _isUsernameValid = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  void _onUsernameChangeHandler(String username) {
    if (username.isNotEmpty) {
      setState(() {
        _isUsernameValid = true;
      });
    } else {
      setState(() {
        _isUsernameValid = false;
      });
    }
  }

  Future<void> _onRegisterSubmitHandle() async{
    print("Username : ${usernameController.text}");
    print("Password : ${passwordController.text}");
    String email = usernameController.text.trim();
    String password = passwordController.text.trim();
    if (_formKey.currentState!.validate()) {
      await _createUserWithEmailAndPassword(email, password);
    }
  }

  Future<void> _createUserWithEmailAndPassword(String email, String password) async{
    setState(() {
      _isLoading = true;
    });
    await _auth.createUserWithEmailAndPassword(email: email, password: password).then((data){
      print("user : $data");
      if(data.credential != null){
        setState(() {
          _isLoading = false;
        });
      }
      final route = MaterialPageRoute(builder: (BuildContext context) => MainScreen());
      Navigator.pushReplacement(context, route);
    }).catchError((error){
      setState(() {
        _isLoading = false;
      });
      final snackBar = SnackBar(content: Text("Error : $error"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  void showUserError(String errorCode) {
    final snackBar = SnackBar(content: Text("Error : $errorCode"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {

    final username = Padding(padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
        child: TextFormField(
          validator: (v){
            if(v!.isEmpty){
              return "Username is not empty";
            }
            return null;
          },
          controller: usernameController,
          onChanged: _onUsernameChangeHandler,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_circle),
              suffixIcon:  _isUsernameValid ? Icon(Icons.check_circle, color: Colors.green,) : Icon(Icons.check_circle),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50)
              ),
              hintText: 'Username'
          ),
        )
    )
    ;
    final password = Padding(padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
        child: TextFormField(
          validator: (v){
            if(v!.isEmpty){
              return "Password is not empty";
            }
            return null;
          },
          controller: passwordController,
          obscureText: _obscureText,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(onPressed: (){
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
                  icon: _obscureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility)
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50)
              ),
              hintText: 'Password'
          ),
        ));

    final loginButton =  Padding(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 16),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF3051A0)
            ),
            onPressed: _onRegisterSubmitHandle,
            child: Text("ចុះឈ្មោះ", style: TextStyle(color: Colors.white),)),
      ),
    );

    final forgetPasswordButton = Padding(padding: EdgeInsets.only(left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: (){
                final route = MaterialPageRoute(builder: (BuildContext context) => ForgetPasswordScreen());
                Navigator.push(context, route);
              }, child: Text("ភ្លេចលេខសម្ងាត់",)
          )
        ],
      ),);

    final socialLogin = Padding(padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.email_outlined, color: Colors.red,size: 30,),
          SizedBox(width: 10,),
          Icon(Icons.facebook, color: Colors.blue,size: 30,),
        ],
      ),
    );

    final _formLogin = Form(
        key: _formKey,
        child: Column(children: [
          username,
          password,
        ],));

    final logo = SizedBox(
      height: 300,
      child: Center(
        child: appLogo.logo,
      ),
    );

    final _noAccountButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("មានគណនីរួចហើយ? "),
        TextButton(onPressed: (){}, child: Text("ចូលប្រើ", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),))
      ],
    );

    final _deviderWidget = Row(
      children: [
        Expanded(
            child: Divider()
        ),
        Text("Or"),
        Expanded(
            child: Divider()
        ),
      ],
    );

    final _skipButton = TextButton(onPressed: (){
      final route = MaterialPageRoute(builder: (BuildContext context) => MainScreen());
      Navigator.pushReplacement(context, route);
    }, child: Text("រំលង", style: TextStyle(color: Colors.blue),));

    return Scaffold(
        body: _isLoading ? Center(child: CircularProgressIndicator(),) :
          ListView(
          children: [
            logo,
            Expanded(
                child: Column(
                  children: [
                    _formLogin,
                    forgetPasswordButton,
                    loginButton,
                    _noAccountButton,
                    _skipButton,
                    SizedBox(height: 20,),
                    _deviderWidget,
                  ],
                )
            ),
            socialLogin
          ],
        )
    );
  }
}
