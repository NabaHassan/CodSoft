import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'flutter_flow.dart';
import 'flutter_flow_theme.dart';
import 'package:flutter/material.dart';


import 'home_page_model.dart';
export 'home_page_model.dart';

class secondApp extends StatefulWidget {
  const secondApp({Key? key}) : super(key: key);

  @override
  _secondApp createState() => _secondApp();
}

class _secondApp extends State<secondApp> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    _model.textController1 ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
  }


  T createModel<T>(BuildContext, T Function() modelBuilder) {
    return modelBuilder();
  }

  void _deleteTask(String taskId) async {
    try {
      await _firestore.collection('tasks')
          .doc(taskId)
          .delete();
      print('task deleted sucessfully');
    } catch (e) {
      print('Error deleting task: $e');
    }
  }



  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color.fromRGBO(118, 88, 39, 1),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            backgroundColor: Color.fromRGBO(101, 69, 31, 1),
            automaticallyImplyLeading: false,
            title: Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                child: Text(
                  'To-Do-List',
                  style: FlutterFlowTheme
                      .of(context)
                      .title1
                      .override(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            actions: [],
            centerTitle: true,
            elevation: 2,
          ),
        ),
        body: Column(
          children: [

            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('tasks').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                      {
                        return CircularProgressIndicator();
                      }
                      else if (snapshot.hasError){
                        return Text('Error: ${snapshot.error}');
                      }
                      else if (!snapshot.hasData){
                        return Text("no data availible");
                      }
                      else {
                        final documents = snapshot.data!.docs;

                        return ListView.builder(
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data = documents[index]
                                  .data()! as Map<String, dynamic>;
                              String taskId = documents[index].id;

                              Timestamp timestampFromFirestore = data['DueDate'] ?? Timestamp.fromDate(DateTime.now());
                              DateTime dateTime = timestampFromFirestore.toDate();
                              String formattedDate = DateFormat('EEE M/d/y').format(dateTime);

                              Color taskColor = Colors.white;

                              if (data['Priority'] == 'High'){
                                taskColor = Color.fromRGBO(180, 33, 59, 1.0);
                              }
                              else if (data['Priority'] == "Medium"){
                                taskColor = Color.fromRGBO(231, 175, 31, 1.0);
                              }
                              else{
                                taskColor = Color.fromRGBO(19, 108, 68, 1.0);
                              }

                              return Padding(
                                  padding: const EdgeInsets.all(20),
                                child: Column(
                                children:[
                                  Container(

                                  padding: EdgeInsets.all(20),
                                  height: 160,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: taskColor,
                                      width: 3

                                    ),
                                    color: Color.fromRGBO(200,174,125,1),
                                    borderRadius: BorderRadius.circular(24),

                                  ),

                                    child: Stack(
                                    children: [
                                      Stack(
                                        children:[
                                        ListView(
                                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        children:[
                                          Text(data['task']?? 'Task',
                                          style: GoogleFonts.lato(
                                            fontSize: 25,
                                              fontWeight: FontWeight.bold ),
                                          ),
                                          Text(data['Desc']?? 'No Description',

                                          style: GoogleFonts.lato(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal )
                                          ),

                                          Text(formattedDate,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15
                                          ),
                                          ),
                                        ]
                                      )
                                        ]
                                      ),
                                        //Update Button
                                        Align(
                                            alignment: AlignmentDirectional(1.2, 0.95),
                                            child: ElevatedButton(
                                              
                                            style: ElevatedButton.styleFrom(

                                            backgroundColor: Color.fromRGBO(234, 198, 150,1),
                                              
                                            shape: CircleBorder(),

                                        ),
                                            onPressed: () {
                                              Navigator.pushNamed(context, '/third_page');
                                          },
                                              child: Icon(
                                            Icons.update
                                          )
                                      )
                                        ),
                                        //Delete Button
                                        Align(
                                          alignment: AlignmentDirectional(1.2, -0.7),
                                          child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromRGBO(234, 198, 150,1),
                                              shape: CircleBorder()

                                          ),
                                          onPressed: () {
                                            _deleteTask(taskId);
                                          },
                                            child: Icon(
                                              Icons.delete
                                          )
                                      ),


                                      )
                                    ],
                                ),


                              ),
                                ]
                              )
                              );


                            }
                        );
                      }
                    }
                )
            ),

            Align(
              alignment: AlignmentDirectional(1,1),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromRadius(30),
                  backgroundColor: Color.fromRGBO(234, 198, 150,1),
                    shape: CircleBorder()
                ),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/NewTaskWidget');
                },
                child:
                Icon(
                    Icons.add

                )
            )
            )
          ],
        )
    );
  }
}