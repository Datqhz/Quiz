class MyCard{
  late String term;
  late String defination;
  MyCard({required this.term, required this.defination});

  @override
  String toString() {
    return 'MyCard{term: $term, defination: $defination}';
  }
}