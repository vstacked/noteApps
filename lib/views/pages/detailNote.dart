import 'package:flutter/material.dart';
import 'package:note_apps/viewModels/detailNoteViewModel.dart';
import 'package:note_apps/views/pages/homePage.dart';
import 'package:note_apps/views/widgets/loading.dart';
import 'package:stacked/stacked.dart';

class DetailNote extends StatefulWidget {
  final int id;
  DetailNote({@required this.id});
  @override
  _DetailNoteState createState() => _DetailNoteState();
}

class _DetailNoteState extends State<DetailNote> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailNoteViewModel>.reactive(
      viewModelBuilder: () => DetailNoteViewModel(),
      onModelReady: (model) => model.getNoteById(id: widget.id),
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (Route<dynamic> route) => false);
            return false;
          },
          child: Scaffold(
            key: model.scaffoldKey,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) => false),
              ),
              title: (!model.isEditable)
                  ? Text('${model?.note?.title}')
                  : TextField(
                      controller: model.titleController,
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
              actions: (!model.isLoading)
                  ? <Widget>[
                      IconButton(
                        icon:
                            Icon((!model.isEditable) ? Icons.edit : Icons.save),
                        onPressed: () => (!model.isEditable)
                            ? model.setIsEditable(true)
                            : model.updateNote,
                      ),
                      IconButton(
                        icon: Icon(
                            (!model.isEditable) ? Icons.delete : Icons.close),
                        onPressed: () => (!model.isEditable)
                            ? model.deleteNote
                            : model.setIsEditable(false),
                      ),
                    ]
                  : [Loading()],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: (model.note != null)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('${model.note.date}',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ),
                          SizedBox(height: 10),
                          (!model.isEditable)
                              ? Text('${model.note.note}')
                              : TextField(
                                  maxLines: 25,
                                  controller: model.noteController,
                                  textInputAction: TextInputAction.newline,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Write some notes..',
                                  ),
                                )
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
