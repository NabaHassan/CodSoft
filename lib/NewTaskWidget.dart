import 'package:cloud_firestore/cloud_firestore.dart';
import 'flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'flutter_flow_drop_down.dart';
import 'package:intl/intl.dart';


import 'NewTaskModel.dart';
export 'NewTaskModel.dart';

class NewTaskWidget extends StatefulWidget {
  const NewTaskWidget({Key? key}) : super(key: key);

  @override
  _NewTaskWidgetState createState() => _NewTaskWidgetState();
}

class _NewTaskWidgetState extends State<NewTaskWidget> {
  late NewTaskModel _model;

  String _selectedDropdownVal = 'High';

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewTaskModel());
  }
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101)
    );
    if(picked != null || picked != selectedDate)
      setState(() {
        selectedDate = picked!;
      });
  }

  void _addTasks() async {
    String taskName = taskNameController.text;
    String taskDesc = taskDescController.text;

    try {
      await _firestore.collection('tasks').add({'task':taskName,'Desc':taskDesc,'DueDate':selectedDate,
        'Priority':_selectedDropdownVal});
      Navigator.popAndPushNamed(context, '/first_page');


    }catch (e){
      print('ERROR OCCURRED WHILE SAVING DATA');
    }
  
  }


  T createModel<T>(BuildContext, T Function() modelBuilder) {
    return modelBuilder();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color.fromRGBO(118, 88, 39,1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(101, 69, 31,1),
          automaticallyImplyLeading: false,
          title: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Text(
              'Add New Task ',
              style: FlutterFlowTheme.of(context).title1.override(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 30,
                  ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body:
        Stack(
            children: <Widget>[
              Positioned(
                top: 60,
                left: 20,
                child: Icon(
                  Icons.list_alt_outlined,
                  color: Color.fromRGBO(200, 174, 125, 1),
                  size: 35,
                ),
              ),
              Positioned(
                top: 160,
                left: 20,
                child: Icon(
                  Icons.chat_bubble,
                  color: Color.fromRGBO(200, 174, 125, 1),
                  size: 35,
                ),
              ),
              Positioned(
                top:355,
                left: 20,
                child: FaIcon(
                  FontAwesomeIcons.tags,
                  color: Color.fromRGBO(200, 174, 125, 1),
                  size: 35,
                ),
              ),
              Positioned(
                top:150,
                left: 70,
                child: SizedBox(
                width: 270,

                 child: TextFormField(
                    controller: taskDescController,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(
                          color: Colors.white,
                        fontWeight: FontWeight.w600 ,
                        fontSize: 14,
                        fontFamily:"poppins"),


                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1C1D1E),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins'
                    )
                  ),
              ),
                ),

              Positioned(
                top: 50,
                left: 70,
                child: SizedBox(
                  width: 270,
                  child: TextFormField(
                    controller: taskNameController,
                    autofocus: true,
                    obscureText: false,


                    decoration: InputDecoration(
                      labelText: 'Task',
                      labelStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600 ,
                              fontSize: 14,
                              fontFamily: 'Poppins'),
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600 ,
                        fontSize: 14,
                        fontFamily: 'Poppins'),

                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1C1D1E),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1C1D1E),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).secondaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).secondaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins'
                    )
                  ),
                ),
              ),
              Positioned(
                top:255,
                left: 8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromRadius(22),
                  shape: CircleBorder(),
                  backgroundColor: Color.fromRGBO(200, 174, 125, 1),

                ),
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Icon(
                    Icons.calendar_month_outlined,

                    color: Color.fromRGBO(101, 69, 31,1),
                    size: 30,
                  ),

                )
              ),
              Positioned(
                top: 270,
                left: 80,
                  child: Text('Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                    style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600 ,
                          fontSize: 16,
                          fontFamily: 'Poppins'),
                    ),
                  ),


              Positioned(
                top: 355,
                left: 70,
                child: FlutterFlowDropDown(
                  options: ['High', 'Medium', 'Low'],
                  onChanged: (val) => setState(() => _selectedDropdownVal = val!),
                  width: 255,
                  height: 40,
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600 ,
                      fontSize: 14,
                      fontFamily: 'Poppins'),

                  hintText: 'Priority Level ',
                  fillColor: Color.fromRGBO(118, 88, 39,1),
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.black,
                    size: 24,
                  ),
                  elevation: 2,
                  borderColor: Colors.black,
                  borderWidth: 1,
                  borderRadius: 20,
                  margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                  hidesUnderline: true,
                  //isSearchable: false,
                  //isMultiSelect: false,
                ),
              ),

              Positioned(
                top: 500,
                left: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/first_page');

                  },
                  child: Text('Cancel') ,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF795C32),
                    textStyle:FlutterFlowTheme.of(context).title3.override(
                      fontFamily: 'Readex Pro',
                      color: Colors.white,
                    ),
                    elevation: 3,
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    fixedSize: Size.fromHeight(40),
                  ),
                ),
              ),
                Positioned(
                  top: 500,
                  left: 200,
                  child: ElevatedButton(
                  onPressed: _addTasks,
                    child: Text(' Save '),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF795C32),
                      textStyle:FlutterFlowTheme.of(context).title3.override(
                          fontFamily: 'Readex Pro',
                          color: Colors.white,
                      ),
                      elevation: 3,
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      fixedSize: Size.fromHeight(40),
                    ),


                  ),
                ),
    ],
    ),
      ),
    );

  }
}





