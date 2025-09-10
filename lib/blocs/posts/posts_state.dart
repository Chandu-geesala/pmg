import 'package:equatable/equatable.dart';
import '../../models/post.dart';

abstract class PostsState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsRefreshing extends PostsState {
  final List<Post> oldPosts;

  PostsRefreshing(this.oldPosts);

  @override
  List<Object> get props => [oldPosts];
}

class PostsLoaded extends PostsState {
  final List<Post> posts;

  PostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostsError extends PostsState {
  final String message;

  PostsError(this.message);

  @override
  List<Object> get props => [message];
}
