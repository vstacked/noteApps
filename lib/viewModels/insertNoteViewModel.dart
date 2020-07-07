import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_apps/services/databaseServices.dart';
import 'package:note_apps/views/pages/homePage.dart';
import 'package:stacked/stacked.dart';
import 'package:note_apps/models/note.dart';

class InsertNoteViewModel extends BaseViewModel {
  DatabaseServices _databaseServices = DatabaseServices();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  String _date = DateFormat('H:m:s dd-MM-yyyy').format(DateTime.now());

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isNoNull = false;
  bool get isNoNull => _isNoNull;

  String _title;
  String _note;
  String get title => _title;
  String get note => _note;

  void setTitle(val) {
    _title = val;
    notifyListeners();
  }

  void setNote(val) {
    _note = val;
    if (_note != '')
      _isNoNull = true;
    else
      _isNoNull = false;
    notifyListeners();
  }

  Future _insertNote() async {
    _isLoading = true;
    notifyListeners();

    await _databaseServices
        .insert(Note(
            id: null,
            title:
                _title ?? (_note.length >= 25) ? _note.substring(0, 25) : _note,
            note: _note,
            date: _date))
        .whenComplete(() => Navigator.pushAndRemoveUntil(
            _scaffoldKey.currentContext,
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false));
  }

  Future get insertNote => _insertNote();
}
