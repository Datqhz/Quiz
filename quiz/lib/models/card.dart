class MyCard {
  int cardId;
  String term;
  String definition;
  MyCard({required this.cardId, required this.term, required this.definition});

  factory MyCard.fromJson(Map<String, dynamic> json) => MyCard(
      cardId: json['id'], term: json['term'], definition: json['definition']);
  CardModify mapToCardModify(){
    return CardModify(cardId: cardId, term: term, definition: definition, option: 3);
  }
}

class CardModify{
  int cardId;
  String term;
  String definition;
  int option;
  CardModify({required this.cardId, required this.term, required this.definition, required this.option});
  @override
  String toString() {
    return '$cardId - $term - $definition - $option';
  }
}