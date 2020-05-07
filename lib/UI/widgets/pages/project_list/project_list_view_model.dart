import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/project_list/create_project_page.dart';
import 'package:flutter_drag_and_drop/home_page.dart';


class ProjectListViewModel with ChangeNotifier {
  Future<void> projectPressed(BuildContext context, int i) async {
    if (i == 0) {
     await showDialog(
        context: context,
        builder: (context) {
          return CreateProjectPage(createProject: createProject);
        },
      );
    }
    else{

    }
    moveToBuilding(context);
  }
  void projectSelect(){
    
  }
  void createProject(String name) {
    print(name);
    //TODO:Implement Create Project Here

    
  }
    void moveToBuilding(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_)=>DragDrop())
    );
  }
}
