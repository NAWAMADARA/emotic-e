import 'package:emotic_e/Utils/shared_preference.dart';
import 'package:emotic_e/view/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../controller/auth.dart';
import 'bottom_nav_bar.dart';

class RegisterPage extends StatefulWidget {
   RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isObscure2 = true;

  String _email = "";
  String _password = "";
  String _rePassword = "";
  final auth = Auth();
  bool _flag = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: _flag ? const Center(child: CircularProgressIndicator(),) :SafeArea(
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
                            if(value.length < 6){
                              return "Password should contain at least 6 characters";
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (value){
                            _rePassword = value;
                          },
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return "Please Enter Password";
                            }
                            return null;
                          },
                          obscureText: _isObscure2 ? true:false,
                          decoration:  InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            suffixIcon:
                            IconButton(
                                onPressed: (){
                              setState(() {_isObscure2 = !_isObscure2;});
                            },
                                icon:  Icon(_isObscure2 ?Icons.remove_red_eye : Icons.panorama_fish_eye)),
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
                            hintText: 'Re-enter password',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                  if(_formkey.currentState!.validate()){
                    if(_password == _rePassword){
                      setState(() {_flag = true;});
                      await auth.createUserWithEmailAndPassword(email: _email, password: _password).then((value) {
                        SharedPreferencesUtil.instance.setString("email", _email);
                        SharedPreferencesUtil.instance.setString("password", _password);
                        SharedPreferencesUtil.instance.setString("name",value.user!.displayName!);
                        _flag = false;
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const BottomNavBar()));
                      }).onError((error, stackTrace){
                        if (kDebugMode) {print(error);}
                        setState(() {
                          _flag = false;
                          ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("$stackTrace")));
                        });
                      });
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please provide same pasword in both fileds")));
                    }
                  }
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)))),
                      fixedSize: MaterialStateProperty.all(const Size(96, 40))),
                  child: const Text(
                    "SignUp",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already Registered?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                      },
                      child: const Text(
                        'Login now.',
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
