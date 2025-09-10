import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/posts_repository.dart';
import 'posts_event.dart';
import 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository _postsRepository;

  PostsBloc(this._postsRepository) : super(PostsInitial()) {
    on<PostsFetchRequested>(_onPostsFetchRequested);
    on<PostsRefreshRequested>(_onPostsRefreshRequested);
  }

  void _onPostsFetchRequested(PostsFetchRequested event, Emitter<PostsState> emit) async {
    emit(PostsLoading());
    try {
      final posts = await _postsRepository.fetchPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }

  void _onPostsRefreshRequested(PostsRefreshRequested event, Emitter<PostsState> emit) async {
    if (state is PostsLoaded) {
      emit(PostsRefreshing((state as PostsLoaded).posts));
    }
    try {
      final posts = await _postsRepository.fetchPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }
}
