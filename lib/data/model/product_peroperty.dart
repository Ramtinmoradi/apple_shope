class Peroperty {
  String title;
  String value;

  Peroperty(this.title, this.value);

  factory Peroperty.fromJson(Map<String, dynamic> jsonObject) {
    return Peroperty(
      jsonObject['title'],
      jsonObject['value'],
    );
  }
}
