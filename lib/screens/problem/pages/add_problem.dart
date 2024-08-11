import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_tally/utils/custom_snackbars.dart';

class AddProblem extends StatefulWidget {
  const AddProblem({super.key});

  @override
  State<AddProblem> createState() => _AddProblemState();
}

class _AddProblemState extends State<AddProblem> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController difficultyController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController constraintsController = TextEditingController();
  final TextEditingController exampleController = TextEditingController();
  final TextEditingController testCase1Controller = TextEditingController();
  final TextEditingController testCase2Controller = TextEditingController();
  final TextEditingController desiredOutput1Controller = TextEditingController();
  final TextEditingController desiredOutput2Controller = TextEditingController();
  bool showSpinner=false;

  Future<void> _addProblemToFirestore() async {
    Map<String,dynamic> problemData = {
      'title': titleController.text,
      'difficulty_level': difficultyController.text,
      'description': descriptionController.text,
      'constraints': constraintsController.text,
      'example': exampleController.text,
      'testcase1':testCase1Controller.text,
      'testcase2':testCase2Controller.text,
      'desiredOutput1':desiredOutput1Controller.text,
      'desiredOutput2':desiredOutput2Controller.text,
    };

    try{
      await FirebaseFirestore.instance.collection('problems').add(problemData);
      setState(() {
        showSpinner=false;
      });
      ShowSuccessSnackBar(context, "Data Added");
    }catch(e){
      setState(() {
        showSpinner=false;
      });
      ShowFailureSnackBar(context, "Could not add Data");
      print(e);
      rethrow;
    }

  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Add Problem"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _addContainer("title", titleController, 1),
              _addContainer("difficulty level", difficultyController, 1),
              _addContainer("description", descriptionController, 5),
              _addContainer("constraints", constraintsController, 3),
              _addContainer("Example", exampleController, 3),
              _addContainer("testcase 1", testCase1Controller, 3),
              _addContainer("desired output 1", desiredOutput1Controller, 3),
              _addContainer("testcase 2", testCase2Controller, 3),
              _addContainer("desired output 1", desiredOutput2Controller, 3),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      showSpinner=true;
                    });
                    await _addProblemToFirestore();
                  },
                  child: Container(
                    width: width * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green),
                    child: showSpinner?Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SpinKitWave(
                        size: 18,
                        color: Colors.black,
                      ),
                    ):Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Add"),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _addContainer(
      String label, TextEditingController controller, int maxlines) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(label.toUpperCase() + " :              "),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                maxLines: maxlines,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                    BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  labelText: label,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    difficultyController.dispose();
    descriptionController.dispose();
    constraintsController.dispose();
    exampleController.dispose();
    super.dispose();
  }
}
