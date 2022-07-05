import 'package:musette_app/screens/browse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/signup.dart';
import '../screens/forgot_password.dart';
void main() {
  runApp(const Login());
}
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();

  @override
  void initState() {
    //check login state
    checkAuth(context);
  }

  Future checkAuth(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('Sign out!');
      } else {
        print('Sign in!');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MyHomePage()));
      }
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Failed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Invalid email or password'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future LogIn() async{
    await _auth
        .signInWithEmailAndPassword(
        email: _emailController.text.trim(), password: _passwordController.text.trim())
        .then((user) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyHomePage()));
    }).catchError((error) {
      print(error);
      _showMyDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 270),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/musettelogo.png'),
                fit: BoxFit.fill,
              ),
            ),
            child:
            const Text(
              ' WWWWWWWWW',
              style: TextStyle(color: Colors.white, fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        TextField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          controller: _passwordController,
                          style: const TextStyle(),
                          obscureText: true,
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              ' Sign in',
                              style: TextStyle(
                                  fontSize: 27, fontWeight: FontWeight.w700),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0xff4c505b),
                              child: IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    LogIn();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignUp()));
                              },
                              child: const Text(
                                'Sign Up',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                    fontSize: 18),
                              ),
                              style: const ButtonStyle(),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ForgotPassword()));
                                },
                                child: const Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                )),

                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

