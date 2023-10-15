import 'package:emotic_e/view/register_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Utils/shared_preference.dart';
import '../controller/auth.dart';
import 'bottom_nav_bar.dart';

class LoginPage extends StatefulWidget {
   const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  final _formkey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  final auth = Auth();
  bool _flag = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 45,
                ),
                Image.asset(
                  'assets/emofullsize.png',
                  height: size.height / 3,
                  width: size.width / 3,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: size.width / 1.5,
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (value){
                            _email = value;
                          },
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return "Please Enter Email";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white10,
                                ),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Email'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (value){
                            _password = value;
                          },
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return "Please Enter Password";
                            }
                            return null;
                          },
                          obscureText: _isObscure ? true:false,
                          decoration:  InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(onPressed: (){
                              setState(() {_isObscure = !_isObscure;});
                            },
                                icon:  Icon(_isObscure ?Icons.remove_red_eye : Icons.panorama_fish_eye)),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white10,
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Password',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ],
                ),

                ElevatedButton(
                  onPressed: () async {
                    if(_formkey.currentState!.validate()){
                        setState(() {_flag = true;});
                        await auth.signInWithEmailAndPassword(email: _email, password: _password).then((value) {
                          SharedPreferencesUtil.instance.setString("email", _email);
                          SharedPreferencesUtil.instance.setString("password", _password);
                          SharedPreferencesUtil.instance.setString("name",value.user!.displayName!);
                          _flag = false;
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const BottomNavBar()));
                        }).onError((error, stackTrace){if (kDebugMode) {print(error);}});

                    }
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                      fixedSize: MaterialStateProperty.all(const Size(96, 40))),
                  child: const Text(
                    "SignIn",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a member?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
                      },
                      child: const Text(
                        'Register now.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
