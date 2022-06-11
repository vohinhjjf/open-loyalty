import 'package:flutter/material.dart';
import 'package:open_loyalty/Screens/register/register.dart';
import 'package:open_loyalty/components/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../view/Admin/Dashboard/AdminScreen/AdminScreen.dart';
import '../../view/Dashboard/dashboard_screen.dart';
import '../forget_password/forget_password.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {
  final _email_text = TextEditingController();
  final _password_text = TextEditingController();
  bool _validate1 = false;
  bool _validate2 = false;

  @override
  void dispose() {
    _email_text.dispose();
    _password_text.dispose();
    super.dispose();
  }

  //login function
  static Future loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseException catch (e) {
      String error = e.message.toString();
      var errorCode = e.code;
      if (error != 'Given String is empty or null') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(error),
              );
            });
      }
    }
    return user;
  }

  bool _showPassword = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String email = "";
    String password = "";

    return Scaffold(
      body: Background(
        child: new SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA),
                      fontSize: 36),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  controller: _email_text,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    errorText: _validate1 ? 'Email is empty' : null,
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  // controller: _passwordController,
                  onChanged: (value) {
                    password = value;
                  },
                  controller: _password_text,
                  obscureText: _showPassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    errorText: _validate2 ? 'Password is empty' : null,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.orange,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      icon: Icon(
                        !_showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen()))
                  },
                  child: const Text(
                    "Forgot your password?",
                    style: TextStyle(fontSize: 12, color: Color(0XFF2661FA)),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: RaisedButton(
                  onPressed: () async {
                    print(email);
                    print(password);

                    setState(() {
                      _email_text.text.isEmpty
                          ? _validate1 = true
                          : _validate1 = false;
                      _password_text.text.isEmpty
                          ? _validate2 = true
                          : _validate2 = false;
                    });

                    User? user = await loginUsingEmailPassword(
                        email: email, password: password, context: context);
                    if (user != null) {
                      if (user.email == "trng1907@gmail.com") {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => AdminScreen()));
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 255, 136, 34),
                          Color.fromARGB(255, 255, 177, 41)
                        ])),
                    padding: const EdgeInsets.all(0),
                    child: const Text(
                      "LOGIN",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()))
                  },
                  child: const Text(
                    "Don't Have an Account? Sign up",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
