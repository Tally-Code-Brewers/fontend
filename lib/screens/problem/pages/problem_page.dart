import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/java.dart';
import 'package:project_tally/models/problem_data.dart';
import 'package:project_tally/utils/custom_snackbars.dart';

import '../../../models/output_model.dart';
import '../../../services/run_services.dart';

class ProblemPage extends StatefulWidget {
  final ProblemData data;
  const ProblemPage({super.key, required this.data});

  @override
  State<ProblemPage> createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage>
    with SingleTickerProviderStateMixin {
  RunServices run_services = RunServices();
  late CodeController _controller;
  final ScrollController _scrollController = ScrollController();
  TabController? _tabController;
  bool showSpinner = false;
  Future<CommandMetrics>? res;
  CommandMetrics? res2;
  CommandMetrics? res3;
  String? output;
  dynamic language = python;
  List<String> lang = ["java", "python", "c++"];
  Map<dynamic, String> line = {
    java: "//write your java code here",
    python: "#write your python code here",
    cpp: "//write your C++ code here"
  };
  Map<dynamic, int> num = {java: 62, python: 92, cpp: 54};
  List<dynamic> lang2 = [java, python, cpp];

  Future<void> onTap() async {
    setState(() {
      showSpinner = true;
    });

    // Await the results of the asynchronous operations
    final result1 = await getResult(widget.data.testcase1!);
    final result2 = await getResult(widget.data.testcase2!);

    setState(() {
      res2 = result1;
      res3 = result2;
      showSpinner = false;
    });

    // After the results are set, check the condition and show the Snackbar
    if (res2!.output == widget.data.desiredOutput1 && res3!.output == widget.data.desiredOutput2) {
      ShowSuccessSnackBar(context, "You got the correct answer");
      Confetti.launch(
          context,
          options: const ConfettiOptions(
              particleCount: 100, spread: 70, y: 0.6)
      );
    } else {
      ShowFailureSnackBar(context, "You got the wrong answer");
    }
  }


  Future<CommandMetrics> getResult(String testCase) async {
    return await run_services.getToken(
      context,
      _controller.text,
      num[language]!,
      testCase,
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _controller = CodeController(
      text: line[language],
      language: language,
      analyzer: DefaultLocalAnalyzer(),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: AppBar(
        title: Text("Problem"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: width * 0.5,
                  height: height * 0.895,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.title!,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.data.description!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.5,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 24),
                                Text(
                                  'Constraints:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  padding: EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    widget.data.constraints!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 24),
                                Text(
                                  'Examples:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  padding: EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(widget.data.example!),
                                      SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onTap,
                          child: Container(
                            height: height * 0.08,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: showSpinner?Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SpinKitWave(
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ):Text(
                                  "Submit",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: width * 0.4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                              RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(text: "Time: "),
                                          TextSpan(
                                              text: (res2?.metrics?.userTime ?? "--")+ "s   "),
                                        ],
                                      ),
                                    ),
                                      // FutureBuilder(
                                      //     future: res,
                                      //     builder: (context, snapshot) {
                                      //       if (res == null) {
                                      //         return Row(
                                      //           children: [
                                      //             Text("Time: "),
                                      //             Text("--  "),
                                      //           ],
                                      //         );
                                      //       }
                                      //       if (snapshot.connectionState ==
                                      //           ConnectionState.waiting) {
                                      //         return Row(
                                      //           children: [
                                      //             Text("Time: "),
                                      //             SpinKitThreeBounce(
                                      //               size: 16,
                                      //               color: Colors.black,
                                      //             ),
                                      //           ],
                                      //         );
                                      //       }
                                      //       //     Future((){
                                      //       //       setState(() {
                                      //       //         output = snapshot.data!.output!;
                                      //       //       });
                                      //       //
                                      //       // });
                                      //       return RichText(
                                      //         text: TextSpan(
                                      //           children: [
                                      //             TextSpan(text: "Time: "),
                                      //             TextSpan(
                                      //                 text: (snapshot.data?.metrics?.userTime ?? "0")+ "s   "),
                                      //           ],
                                      //         ),
                                      //       );
                                      //     }),

                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(text: "Memory: "),
                                            TextSpan(
                                                text: (res2?.metrics?.maximumResidentSetSize ??"--" )+ "kb"),
                                          ],
                                        ),
                                      )
                                      // FutureBuilder(
                                      //     future: res,
                                      //     builder: (context, snapshot) {
                                      //       if (res == null) {
                                      //         return Row(
                                      //           children: [
                                      //             Text("Memory: "),
                                      //             Text("--"),
                                      //           ],
                                      //         );
                                      //       }
                                      //       if (snapshot.connectionState ==
                                      //           ConnectionState.waiting) {
                                      //         return Row(
                                      //           children: [
                                      //             Text("Memory: "),
                                      //             SpinKitThreeBounce(
                                      //               size: 16,
                                      //               color: Colors.black,
                                      //             ),
                                      //           ],
                                      //         );
                                      //       }
                                      //       return RichText(
                                      //         text: TextSpan(
                                      //           children: [
                                      //             TextSpan(text: "Memory: "),
                                      //             TextSpan(
                                      //                 text: (snapshot
                                      //                     .data?.metrics?.maximumResidentSetSize ??"0" )+ "kb"),
                                      //           ],
                                      //         ),
                                      //       );
                                      //     })
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: DropdownButton<dynamic>(
                                      value: language,
                                      onChanged: (value) {
                                        setState(() {
                                          language = value;
                                          _controller = CodeController(
                                            text: line[language],
                                            language: language,
                                            analyzer: DefaultLocalAnalyzer(),
                                          );
                                        });
                                      },
                                      items: List.generate(
                                        lang2.length,
                                            (index) => DropdownMenuItem(
                                          value: lang2[index],
                                          child: Text(lang[index]),
                                        ),
                                      ),
                                      underline: SizedBox(),
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.blueAccent,
                                      ),
                                      dropdownColor: Colors.white,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: width * 0.475,
                      height: height * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CodeTheme(
                          data: CodeThemeData(styles: monokaiSublimeTheme),
                          child: CodeField(
                            controller: _controller,
                            textStyle: TextStyle(
                              fontFamily: 'SourceCodePro',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: width * 0.475,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExpansionTile(
                          initiallyExpanded: true,
                          shape: Border(),
                          title: Text("TestCases"),
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  TabBar(
                                    controller: _tabController,
                                    tabs: [
                                      Tab(text: 'Case 1'),
                                      Tab(text: 'Case 2'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.2,
                                    child: TabBarView(
                                      controller: _tabController,
                                      children: [
                                        _buildTestCaseView(
                                          input: widget.data.testcase1!,
                                          output:res2?.output ?? "" ,
                                          expected: widget.data.desiredOutput1!,
                                        ),
                                        _buildTestCaseView(
                                          input: widget.data.testcase2!,
                                          output: res3?.output ?? "",
                                          expected:  widget.data.desiredOutput2!,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTestCaseView({
    required String input,
    required String output,
    required String expected,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Input: $input',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Output: $output',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Expected: $expected',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
