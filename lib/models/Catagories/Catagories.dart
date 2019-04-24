import 'package:scoped_model/scoped_model.dart';

class Categories extends Model {
  List<int> categoriesId = [];
  List<String> categoriesName = [];

  Categories({this.categoriesId, this.categoriesName});

  factory Categories.fromJson(Map<String, dynamic> json) {
    List<int> _id = [];
    List<String> _name = [];

    var loc = json['categories'];

    for (int i = 0; i < loc.length; i++) {
      _id.add(loc.asMap()[i]['categories']['id']);
      _name.add(loc.asMap()[i]['categories']['name']);
    }

    _id.removeAt(3);
    _name.removeAt(3);
    _id.removeAt(3);
    _name.removeAt(3);

    return Categories(
      categoriesId: _id,
      categoriesName: _name,
    );
  }
}
