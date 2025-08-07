import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_task/ui/screens/login_screen.dart';
import 'package:new_task/ui/screens/main_bottom_nav.dart';
import 'package:new_task/ui/utills/assets_path.dart';
import 'package:new_task/ui/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
   setState(() {
     _moveToNextPage();
   });
    super.initState();
  }

  Future<void> _moveToNextPage()async{
    await Future.delayed(const Duration(seconds: 2));
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainBottomNavScreen()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: Center(child: SvgPicture.asset(AssetsPath.logoSvg)))
    );
  }
}
