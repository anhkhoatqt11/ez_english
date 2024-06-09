class HistoryRequest {
  DateTime createdAt = DateTime.now();
  int testId;
  int score;
  bool isComplete;
  String userId;

  HistoryRequest(
      this.createdAt, this.testId, this.score, this.isComplete, this.userId);
  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'test_id': testId,
      'score': score,
      'is_complete': isComplete,
      'by_uuid': userId,
    };
  }
}
