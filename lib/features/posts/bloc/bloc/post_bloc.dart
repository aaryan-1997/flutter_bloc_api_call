import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_api_call/features/posts/models/post_data_model.dart';
import 'package:flutter_bloc_api_call/features/posts/repository/posts_repo.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostInitialFetchEvent>(postInitialFetchEvent);
    on<PostAddevent>(postAddevent);
  }

  FutureOr<void> postInitialFetchEvent(
      PostInitialFetchEvent event, Emitter<PostState> emit) async {
    emit(PostLoadingSate());
    List<PostDataModel> posts = await PostsRepo.getPosts();
    emit(PostFetchingSuccessState(postList: posts));
  }

  FutureOr<void> postAddevent(
      PostAddevent event, Emitter<PostState> emit) async {
    bool success = await PostsRepo.addPosts();
    if(success){
      emit(PostAddSuccessState());
    }else{
      emit(PostAddErrorState());
    }
    
  }
}
