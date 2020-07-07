import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_apps/models/note.dart';
import 'package:note_apps/services/databaseServices.dart';
import 'package:note_apps/views/pages/homePage.dart';
import 'package:stacked/stacked.dart';

class DetailNoteViewModel extends BaseViewModel {
  DatabaseServices _databaseServices = DatabaseServices();

  Note _note;
  Note get note => _note;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  get scaffoldKey => _scaffoldKey;

  TextEditingController _noteController;
  TextEditingController _titleController;
  TextEditingController get noteController => _noteController;
  TextEditingController get titleController => _titleController;

  String _date = DateFormat('H:m:s dd-MM-yyyy').format(DateTime.now());

  bool _isEditable = false;
  bool get isEditable => _isEditable;
  setIsEditable(value) {
    _isEditable = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future getNoteById({@required int id}) async {
    _note = await _databaseServices.getNoteOrderById(id);
    if (_note != null) {
      _titleController = TextEditingController(text: _note.title);
      _noteController = TextEditingController(text: _note.note);
    }
    notifyListeners();
  }

  Future _updateNote() async {
    _isLoading = true;
    notifyListeners();

    await _databaseServices
        .update(Note(
            id: _note.id,
            title: _titleController.text,
            note: _noteController.text,
            date: _date))
        .whenComplete(() {
      getNoteById(id: _note.id);
      _isLoading = false;
      _isEditable = false;
      notifyListeners();
    });
  }

  Future get updateNote => _updateNote();

  Future _deleteNote() async {
    _isLoading = true;
    notifyListeners();

    await _databaseServices.delete(_note.id).whenComplete(() {
      _isLoading = false;
      notifyListeners();
      Navigator.pushAndRemoveUntil(
          _scaffoldKey.currentContext,
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> round) => false);
    });
  }

  Future get deleteNote => _deleteNote();
}
