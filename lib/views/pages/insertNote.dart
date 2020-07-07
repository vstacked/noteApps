import 'package:flutter/material.dart';
import 'package:note_apps/viewModels/insertNoteViewModel.dart';
import 'package:note_apps/views/widgets/loading.dart';
import 'package:stacked/stacked.dart';

class InsertNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InsertNoteViewModel>.reactive(
      viewModelBuilder: () => InsertNoteViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          key: model.scaffoldKey,
          appBar: AppBar(
            title: Text('New Note'),
            actions: <Widget>[
              (!model.isLoading)
                  ? IconButton(
                      icon: Icon(Icons.add,
                          color: (model.isNoNull) ? Colors.white : Colors.grey),
                      onPressed: () =>
                          (model.isNoNull) ? model.insertNote : null,
                    )
                  : Loading()
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (v) => model.setTitle(v),
                    onSubmitted: (v) => model.setTitle(v),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title..',
                    ),
                  ),
                  TextField(
                    onSubmitted: (v) => model.setNote(v),
                    maxLines: 25,
                    onChanged: (v) => model.setNote(v),
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write some notes..',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
