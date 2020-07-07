import 'package:flutter/material.dart';
import 'package:note_apps/viewModels/homePageViewModel.dart';
import 'package:note_apps/views/pages/detailNote.dart';
import 'package:note_apps/views/pages/insertNote.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
      onModelReady: (model) => model.getNoteAllData,
      viewModelBuilder: () => HomePageViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Note Apps'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () => model.getNoteAllData,
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => InsertNote())),
          ),
          body: GestureDetector(
            onTap: () => model.setMoreView(id: null),
            child: ListView.builder(
              itemCount: model?.note?.length ?? 0,
              itemBuilder: (BuildContext context, int i) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  height: (model.id != i) ? 100 : 150,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Flexible(
                          flex: 3,
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailNote(id: model.note[i].id))),
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      '${model.note[i].title}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    '${model.note[i].date}',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                '${model.note[i].note}',
                                maxLines: (model.id != i) ? 3 : 6,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            height: 80,
                            width: 40,
                            child: GestureDetector(
                              onTap: () => model.setMoreView(id: i),
                              child: Icon((model.id == i)
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
