import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/java.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:project_tally/models/output_model.dart';
import 'package:project_tally/providers/provider.dart';
import 'package:project_tally/services/run_services.dart';

class EditorPage extends ConsumerStatefulWidget {
  const EditorPage({super.key});

  @override
  ConsumerState<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends ConsumerState<EditorPage> {
  RunServices run_services=RunServices();
  dynamic language = python;
  final TextEditingController inputController=TextEditingController();
  final TextEditingController outputController=TextEditingController();
  bool showSpinner=false;
  Future<CommandMetrics>? res;
  List<String> lang = ["java", "python", "c++"];
  Map<dynamic, String> line = {
    java: "//write your java code here",
    python: "#write your python code here",
    cpp: "//write your C++ code here"
  };
  Map<dynamic, int> num = {
    java:62,
    python: 92,
    cpp: 54
  };
  List<dynamic> lang2 = [java, python, cpp];
  late CodeController _controller;
  Future<void> onTap()async{// Update the provider state here
    setState(() {
      showSpinner = true;
    });
    res = getResult(); // Perform the async operation after updating the state
    setState(() {
      showSpinner = false;
    });

  }
  Future<CommandMetrics> getResult()async{
    return await run_services.getToken(context, _controller.text, num[language]!,inputController.text);

  }
  @override
  void dispose() {
    // TODO: implement dispose
    inputController.dispose();
    outputController.dispose();
    _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
      _controller = CodeController(
        text: line[language],
        language: language,
        analyzer: DefaultLocalAnalyzer(),
      );
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Editor Page"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildRow(height, width),
      ),
    );
  }

  Widget buildRow(double height, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
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
              ),
            ),
            CodeTheme(
              data: CodeThemeData(styles: monokaiSublimeTheme),
              child: Container(
                height: height * 0.8,
                width: width * 0.5,
                
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      CodeField(
                        controller: _controller,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(

              width: width*0.45,
              height: height*0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FutureBuilder(
                      future: res,
                      builder: (context,snapshot){
                        if (res==null)
                          {
                            return Row(
                              children: [
                                Text("Time: "),
                                Text("--"),
                              ],
                            );
                          }
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return Row(
                            children: [
                              Text("Time: "),
                              SpinKitThreeBounce(
                                size: 16,
                                color: Colors.black,
                              )
                            ],
                          );
                        }
                        return RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: "Time: "),
                              TextSpan(text: (snapshot.data?.metrics?.userTime ?? "0")+"s"),

                            ]
                          ),
                        );
                      }),
                  FutureBuilder(
                      future: res,
                      builder: (context,snapshot){
                        if (res==null)
                        {
                          return Row(
                            children: [
                              Text("Memory: "),
                              Text("--"),
                            ],
                          );
                        }
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return Row(
                            children: [
                              Text("Memory: "),
                              SpinKitThreeBounce(
                                size: 16,
                                color: Colors.black,
                              )
                            ],
                          );
                        }
                        return RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: "Memory: "),
                                TextSpan(text: "${snapshot.data?.metrics?.maximumResidentSetSize ?? "0"}kb"),

                              ]
                          ),
                        );
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Input Test Case"),
                    ),
                    Container(
                      width: width * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: inputController,
                          decoration: InputDecoration(),
                          maxLines: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.black
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Output"),
                    ),

                    Container(
                      width: width * 0.4,
                      height: height*0.3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FutureBuilder(
                          future: res,
                          builder: (context, snapshot) {
                            if (res == null) {
                              return const Text("Run the code to see the output");
                            }
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Text("Compiling your data...");
                            }
                            if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            var actualres = snapshot.data;
                            outputController.text = actualres!.output! ;
                            return TextField(
                              readOnly: true,
                              controller: outputController,
                              decoration: const InputDecoration(),
                              maxLines: 8,
                            );
                          },
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  showSpinner=true;
                });
                ref.read(codeProvider.notifier).state=_controller.text;
                onTap();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),

                child: showSpinner?Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SpinKitWave(
                    size: 18,
                    color:Colors.black,
                  ),
                ):Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Run Code"),
                ),
              ),
            )
          ],
        ),

      ],
    );
  }
}
