class SkillResponse {
  int id;
  String skillType;

  SkillResponse(this.id, this.skillType);

  // Deserialization: Convert from JSON to SkillResponse object
  factory SkillResponse.fromJson(Map<String, dynamic> json) {
    return SkillResponse(
      json['id'] as int,
      json['skill_type'] as String,
    );
  }

  // Serialization: Convert SkillResponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'skill_type': skillType,
    };
  }
}
