import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_tally/models/problem_data.dart';
import 'package:project_tally/screens/problem/pages/add_problem.dart';
import 'package:project_tally/screens/problem/pages/problem_page.dart';

class ProblemSet extends StatefulWidget {
  const ProblemSet({super.key});

  @override
  State<ProblemSet> createState() => _ProblemSetState();
}

class _ProblemSetState extends State<ProblemSet> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Problem List"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: width * 0.5,
                  height: height,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('problems').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('No problems found.'));
                      }

                      var problems = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: problems.length,
                        itemBuilder: (context, index) {
                          var problem = problems[index];
                          return GestureDetector(
                            onTap: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProblemPage(data: ProblemData(
                                    title: problem['title'],
                                    constraints: problem['constraints'],
                                    description: problem['description'],
                                    desiredOutput1: problem['desiredOutput1'],
                                    desiredOutput2: problem['desiredOutput2'],
                                    difficultyLevel: problem['difficulty_level'],
                                    example: problem['example'],
                                    testcase1: problem['testcase1'],
                                    testcase2: problem['testcase2']),)),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: Column(
                                      children: [
                                        Text("Problem no."),
                                        Text((index + 1).toString()),
                                      ],
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: Text(problem['title'] ?? 'Untitled'),
                                    ),
                                    trailing: Text(problem['difficulty_level'] ?? 'Unknown'),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddProblem()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
