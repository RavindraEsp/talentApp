class AuditionPropertyModel {
  int? id;
  String title;
  bool isSelect;

  AuditionPropertyModel(
    this.title,
    this.isSelect, {
    this.id = 0,
  });
}
