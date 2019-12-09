class DiaryItem {
  String id;
  String time;
  String category;
  String glucose;

  String carbohydrates;
  String bolus;
  String basal;
  String notes;
  String drugs_bolus;
  String drugs_basal;

  bool isExpanded;

  DiaryItem({
    this.id,
    this.time,
    this.category,
    this.glucose,
    this.carbohydrates,
    this.bolus,
    this.basal,
    this.notes,
    this.drugs_bolus,
    this.drugs_basal,
    this.isExpanded = false,
  });
}
