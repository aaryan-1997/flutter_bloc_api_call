part of 'post_bloc.dart';

@immutable
abstract class PostState {}

abstract class PostActionState extends PostState {}

class PostInitial extends PostState {}

class PostLoadingSate extends PostState {}

class PostErrorSate extends PostState {}

class PostFetchingSuccessState extends PostState {
  final List<PostDataModel> postList;

  PostFetchingSuccessState({required this.postList});
}

class PostAddSuccessState extends PostActionState {}

class PostAddErrorState extends PostActionState {}
