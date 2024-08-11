import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width*0.5,
                  height: height,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.withOpacity(0.1)
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Lottie.network("https://lottie.host/1789b155-2355-4eac-a0d7-57d121ec7fb7/Eq0ldz3wwQ.json",
                      ),
                    ),
                  ),
                ),

              ],
            ),
            Container(
              width: width,
              height: height*0.3,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
