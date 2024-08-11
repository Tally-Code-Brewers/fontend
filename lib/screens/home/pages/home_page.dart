import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_tally/screens/code_editor/page/editor_page.dart';
import 'package:project_tally/screens/contest/page/contest_page.dart';
import 'package:project_tally/screens/help/pages/help_page.dart';
import 'package:project_tally/screens/problem/pages/problem_set.dart';

import '../../authentication/pages/auth_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const AuthPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: height*0.2,
            ),
            Text("Alright, time to lock in, fire up the brain, and make code sing",style: TextStyle(
              fontSize: 22,
              fontFamily: 'Figtree'
            ),),
            SizedBox(
              height: height*0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditorPage()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            color: Colors.blue.withOpacity(0.3),
                          ),

                          width: width*0.15,
                          height: width*0.15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0).copyWith(bottom: 15),
                                child: Icon(Icons.square_outlined,
                                  size: 50,
                                  color: Colors.blue,
                                ),
                              ),
                              Text("C O D I N G  P L A Y G R O U N D",style: TextStyle(
                                color: Colors.blue
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProblemSet()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12)
                          ),

                          width: width*0.15,
                          height: width*0.15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0).copyWith(bottom: 15),
                                child: Icon(Icons.circle_outlined,
                                  size: 50,
                                  color: Colors.green,
                                ),
                              ),
                              Text("C O D I N G  A R E N A",style: TextStyle(
                                  color: Colors.green
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ContestPage()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12)
                          ),

                          width: width*0.15,
                          height: width*0.15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0).copyWith(bottom: 15),
                                child: Icon(Icons.cancel_outlined,
                                  size: 50,
                                  color: Colors.red,
                                ),
                              ),
                              Text("C O D I N G  B A T T L E F I E L D",style: TextStyle(
                                  color: Colors.red
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpPage()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.yellow.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12)
                          ),

                          width: width*0.15,
                          height: width*0.15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0).copyWith(bottom: 15),
                                child: Icon(Icons.help,
                                  size: 50,
                                  color: Colors.yellow.shade700,
                                ),
                              ),
                              Text("C O D I N G  H E L P",style: TextStyle(
                                  color: Colors.yellow.shade700
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),

    );
  }
}
