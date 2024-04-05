class Transcation{
  final String amount;
  final String references;
  final String currency;
  final String email;

  Transcation(this.amount, this.references, this.currency, this.email);
  factory Transcation.fromJson(Map<String, dynamic>json){
    return Transcation(
      json['amount'],
      json['references'],
      json['currency'],
      json['email'],
    );
  }
}