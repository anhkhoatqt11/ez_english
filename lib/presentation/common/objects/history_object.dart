class HistoryObject {
  DateTime createdAt = DateTime.now();
  int testId;
  int score;
  bool isComplete;
  String userId;

  HistoryObject(
      this.createdAt, this.testId, this.score, this.isComplete, this.userId);
}
