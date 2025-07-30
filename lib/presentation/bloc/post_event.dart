abstract class PostEvent {}

class FetchPostEvent extends PostEvent {
  final int postId;
  FetchPostEvent(this.postId);
}

class FetchAllPostsEvent extends PostEvent {}
