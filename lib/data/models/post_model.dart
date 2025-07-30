import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:network_caching/domain/entities/post.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
abstract class PostModel with _$PostModel {
  @JsonSerializable(explicitToJson: true)
  const factory PostModel({
    required int id,
    required String title,
    required String body,
    @Default('') String? fetchedAt,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'body': body,
  //     'fetchedAt': fetchedAt.toIso8601String(),
  //   };
  // }

  // factory PostModel.fromJson(Map<String, dynamic> json) {
  //   return PostModel(
  //     id: json['id'] as int,
  //     title: (json['title'] ?? '') as String,
  //     body: (json['body'] ?? '') as String,
  //     fetchedAt: json['fetchedAt'] == null
  //         ? DateTime.now()
  //         : DateTime.parse(json['fetchedAt'] as String),
  //   );
  // }

  //   factory PostModel.fromDomain(Post post) {
  //     return PostModel(
  //       id: post.id,
  //       title: post.title,
  //       body: post.body,
  //       fetchedAt: post.fetchedAt,
  //     );
  //   }

  //   // Disk deserialization
  //   static PostModel fromDb(Map<String, dynamic> map) {
  //     return PostModel(
  //       id: map['id'] as int,
  //       title: (map['title'] ?? '') as String,
  //       body: (map['body'] ?? '') as String,
  //       fetchedAt: DateTime.parse(map['fetchedAt'] as String),
  //     );
  //   }
  // }

  // extension PostModelDomainMapper on PostModel {
  //   Post toDomain() {
  //     return Post(id: id, title: title, body: body, fetchedAt: fetchedAt);
  //   }
  // }
}
