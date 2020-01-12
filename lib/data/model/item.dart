import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Item extends Equatable {
  final int id;
  final String name;
  final int unit;

  const Item({
    @required this.id,
    @required this.name,
    @required this.unit,
  });

  @override
  List<Object> get props => [
        this.id,
        this.name,
        this.unit,
      ];

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['Id'],
      name: json['Name'],
      unit: json['Unit'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Unit'] = this.unit;
    return data;
  }
}
