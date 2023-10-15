
import 'package:emotic_e/Utils/shared_preference.dart';
import 'package:emotic_e/view/bottom_nav_bar.dart';
import 'package:emotic_e/view/check_user.dart';
import 'package:emotic_e/view/login_page.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  Future<void> gettingData() async {
     await SharedPreferencesUtil.initialize().then((value) {
       if (SharedPreferencesUtil.instance.get("email") != null &&
           SharedPreferencesUtil.instance.get("password") != null) {
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
       } else {
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const CheckUser()));
       }
     });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}