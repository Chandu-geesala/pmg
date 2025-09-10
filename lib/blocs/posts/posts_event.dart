import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostsFetchRequested extends PostsEvent {}

class PostsRefreshRequested extends PostsEvent {}
