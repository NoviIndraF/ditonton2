import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final int id;
  final String name;

  const Genre({
    required this.id,
    required this.name,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
  ];
}