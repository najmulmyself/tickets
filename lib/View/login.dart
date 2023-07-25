import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:pillatickets/View/selection_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var isLoading = false;
  String ? userId;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  setToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', userId.toString());
  }

  void login(String email, password) async {
    setState(() {
      isLoading = true;
    });

    try {
      Response response =
          await post(Uri.parse('https://pillatickets.com/api/login'), body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['data']['user']['id']);
        // prefs.setString
        setState(() {
          userId = data['data']['user']['id'].toString();
           setToPrefs();
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SelectionScreen(
                    userId: userId,
                  )),
        );

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Login Successful'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Login Failed'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
        ));
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24292E),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80.h,
                ),
                Container(
                  height: 80.h,
                  width: 80.w,
                  child: Image.asset(
                    'assets/images/ICON APP.png',
                    width: 200.w,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(color: const Color(0xFF557089)),
                      borderRadius: BorderRadius.circular(12.h),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color(0xFF557089),
                        ),
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(color: const Color(0xFF557089)),
                      borderRadius: BorderRadius.circular(12.h),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color(0xFF557089),
                        ),
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Contraseña",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: InkWell(
                    onTap: () {
                      login(emailController.text.toString(),
                          passwordController.text.toString());
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(18.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF557089),
                            borderRadius: BorderRadius.circular(12.h),
                          ),
                          child: Center(
                            child: Text(
                              "Ingresar",
                              style: TextStyle(
                                color: const Color(0xFFF4F4F4),
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              isLoading, // Replace 'isLoading' with your loading indicator condition
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 120.h,
                ),
                Container(
                  color: const Color(0xFF002E3D),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Powered by ",
                        style: TextStyle(
                            color: const Color(0xFFF4F4F4),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                            fontFamily: 'Poppins'),
                      ),
                      Text(
                        "BLACK LAB",
                        style: TextStyle(
                            color: const Color(0xFFF4F4F4),
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                            fontFamily: 'Poppins'),
                      ),
                      Image(
                        image: const AssetImage('assets/images/thunder.png'),
                        height: 22.h,
                        width: 16.w,
                        color: const Color(0xFFFFFFFF),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
