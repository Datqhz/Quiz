class MyCard {
  int cardId;
  String term;
  String definition;
  MyCard({required this.cardId, required this.term, required this.definition});

  factory MyCard.fromJson(Map<String, dynamic> json) => MyCard(
      cardId: json['id'], term: json['term'], definition: json['definition']);
}
