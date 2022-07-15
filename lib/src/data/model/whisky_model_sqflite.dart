class WhiskySqflite {
  final int id;
  final String name;

  WhiskySqflite({required this.id,required this.name});
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
  @override 
  String toString() {
    return 'Whisky{id: $id, name: $name}';
  }
}