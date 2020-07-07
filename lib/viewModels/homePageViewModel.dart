import 'package:note_apps/models/note.dart';
import 'package:note_apps/services/databaseServices.dart';
import 'package:stacked/stacked.dart';

class HomePageViewModel extends BaseViewModel {
  DatabaseServices _databaseServices = DatabaseServices();

  List<Note> _note;
  List<Note> get note => _note;

  int _id;
  int get id => _id;
  void setMoreView({int id}) {
    _id = id;
    notifyListeners();
  }

  Future _getNoteAllData() async {
    _note = await _databaseServices.getNoteAllData();
    notifyListeners();
  }

  Future get getNoteAllData => _getNoteAllData();
}
