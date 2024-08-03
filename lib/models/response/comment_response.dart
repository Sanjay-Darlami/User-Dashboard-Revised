class CommentResponse {
  int? userId;
  String? comment;
  String? postId;
  int? id;

  CommentResponse(this.userId, this.comment, this.postId, this.id);

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'comment': comment,
      'postId': postId,
      'id': id,
    };
  }

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return CommentResponse(
      json['userId'] as int?,
      json['comment'] as String?,
      json['postId'] as String?,
      json['id'] as int?,
    );
  }

  CommentResponse copyWith({
    int? userId,
    String? comment,
    String? postId,
    int? id,
  }) {
    return CommentResponse(
      userId ?? this.userId,
      comment ?? this.comment,
      postId ?? this.postId,
      id ?? this.id,
    );
  }
}
