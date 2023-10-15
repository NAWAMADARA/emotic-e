

import 'package:emotic_e/view/bottom_nav_bar.dart';
import 'package:emotic_e/view/login_page.dart';
import 'package:flutter/material.dart';

import '../Utils/shared_preference.dart';

class CheckUser extends StatelessWidget {
  const CheckUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Center(
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                      SharedPreferencesUtil.instance.setString("teacher", "teacher");
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height/4,
                    decoration:  BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color
                          spreadRadius: 5, // Spread radius
                          blurRadius: 7, // Blur radius
                          offset: const Offset(0, 3), // Offset
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(12))
                    ),
                    child:  Text("Teacher",style: Theme.of(context).textTheme.headline6,),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    SharedPreferencesUtil.instance.setString("student", "student");
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height/4,
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            spreadRadius: 5, // Spread radius
                            blurRadius: 7, // Blur radius
                            offset: const Offset(0, 3), // Offset
                          ),
                        ],
                        borderRadius: const BorderRadius.all(Radius.circular(12))
                    ),
                    child:  Text("Student",style: Theme.of(context).textTheme.headline6,),
                  ),
                ),
              )
            ],
          ),
        )
        ,),
    );
  }
}
