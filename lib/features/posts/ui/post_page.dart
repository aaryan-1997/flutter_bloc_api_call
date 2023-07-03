import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_api_call/features/posts/bloc/bloc/post_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostBloc postBloc = PostBloc();
  @override
  void initState() {
    postBloc.add(PostInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PostPage'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          postBloc.add(PostAddevent());
        },
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<PostBloc, PostState>(
        bloc: postBloc,
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is! PostActionState,
        listener: (context, state) {
          if (state is PostAddSuccessState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("New Post added")));
          }else if(state is PostAddErrorState){
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Post not added!")));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostLoadingSate:
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.amberAccent,
                ),
              );
            case PostErrorSate:
              return const Center(
                child: Text(
                  "Some error occured!",
                ),
              );
            case PostFetchingSuccessState:
              var successState = state as PostFetchingSuccessState;
              return ListView.builder(
                itemCount: successState.postList.length,
                itemBuilder: (context, index) => Container(
                  color: Colors.grey.shade200,
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(successState.postList[index].title),
                      Text(successState.postList[index].body),
                    ],
                  ),
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
