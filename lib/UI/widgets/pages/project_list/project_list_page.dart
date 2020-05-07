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
                padding:  EdgeInsets.only(left:15.0),
                child: Text(
                  "All Projects",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: size.width,
                height: size.height*0.75,
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    runAlignment: WrapAlignment.spaceEvenly,
                    children: List<Widget>.generate(
                        20,
                        (index) => InkWell(
                              onTap: () {
                                viewModel.projectPressed(context, index);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: NeuCard(
                                  curveType: CurveType.flat,
                                  width: size.longestSide * 0.15,
                                  height: size.longestSide * 0.15,
                                  bevel: 10,
                                  color: neuBackground,
                                  decoration: NeumorphicDecoration(
                                      color: neuBackground,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: neuBackground,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                                                : Text(
                                                    "Project Name ${(index - 1) % 2 == 0 ? "" : "with Long Text Name and Veery LLOONNGG  Long Text Name and Veery LLOONNGG  Long Text Name and Veery LLOONNGG"}",
                                                    textAlign: TextAlign.center,
                                                    maxLines: 4,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6),
                                          ),
                                        ),
                                        // SizedBox(height: 10),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 10.0),
                                          child: Text(
                                            index == 0 ? "Add New" : "12-02-2020",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }


}
