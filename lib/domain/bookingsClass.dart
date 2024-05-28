class ReservedTable {
  num? guests;
  String? date;
  String? time;
  String? type;
  String? food;
  String? branch;
  String imageUrl = '';
  int tablesNum;

  ReservedTable(this.guests, this.date, this.time, this.type, this.food,
      this.branch, this.tablesNum) {
    this.imageUrl = "assets/${food?.toLowerCase()}.png";
  }
}
