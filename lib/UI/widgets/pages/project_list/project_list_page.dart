import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/project_list/project_list_view_model.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';

class ProjectListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<ProjectListViewModel>(
      create: (context) => ProjectListViewModel(),
      child: Consumer<ProjectListViewModel>(builder: (context, viewModel, _) {
        return Scaffold(
          backgroundColor: neuBackground,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: true,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  "All Projects",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: size.width,
                height: size.height * 0.75,
                alignment: Alignment.center,
                child: StreamBuilder<QuerySnapshot>(
                    stream: viewModel.getAllProject(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        viewModel.convert(context, snapshot.data);
                        return SingleChildScrollView(
                          child: Wrap(
                            alignment: WrapAlignment.spaceAround,
                            runAlignment: WrapAlignment.spaceEvenly,
                            children: List<Widget>.generate(
                                viewModel.projects.length + 1,
                                (index) => ProjectTile(
                                      size: size,
                                      index: index,
                                      viewModel: viewModel,
                                    )),
                          ),
                        );
                      }
                      if(snapshot.hasError){
                        return Text("Error Occured");
                      }
                      return CircularProgressIndicator();
                    }),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ProjectTile extends StatelessWidget {
  const ProjectTile({
    Key key,
    @required this.size,
    this.viewModel,
    this.index,
  }) : super(key: key);

  final Size size;
  final ProjectListViewModel viewModel;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        viewModel.projectPressed(context, index);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: NeuCard(
          curveType: CurveType.flat,
          width: size.longestSide * 0.15,
          height: size.longestSide * 0.15,
          bevel: 10,
          color: neuBackground,
          decoration: NeumorphicDecoration(
              color: neuBackground, borderRadius: BorderRadius.circular(25)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: neuBackground,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Container(
                    color: neuBackground,
                    height: size.longestSide * 0.1,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(2.0),
                    child: index == 0
                        ? Icon(
                            Icons.add,
                            color: green,
                            size: size.longestSide * 0.05,
                          )
                        : Text(viewModel.projects[index - 1].projectName,
                            // "Project Name $index",
                            textAlign: TextAlign.center,
                            maxLines: 4,
                            style: Theme.of(context).textTheme.headline6),
                  ),
                ),
                // SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    index == 0
                        ? "Add New"
                        : formatDate(viewModel.projects[index - 1].createdAt,
                            [dd, "/", MM, "/", yyyy]), //"$index-02-2020",
                    style: Theme.of(context).textTheme.bodyText1,
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
