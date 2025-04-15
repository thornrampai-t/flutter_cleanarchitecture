import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cleanarchitecture/core/comment/widgets/loader.dart';
import 'package:flutter_cleanarchitecture/core/theme/app_pallete.dart';
import 'package:flutter_cleanarchitecture/core/utils/show_snackbar.dart';
import 'package:flutter_cleanarchitecture/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_cleanarchitecture/features/blog/presentation/pages/add_new_blog.dart';
import 'package:flutter_cleanarchitecture/features/blog/presentation/widgets/blog_card.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlogPage.route());
            },
            icon: Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnakBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return Loader();
          }
          if (state is BlogDisploySuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogCard(
                  blog: blog,
                  color:
                      index % 3 == 0
                          ? AppPallete.gradient1
                          : index % 3 == 1
                          ? AppPallete.gradient2
                          : AppPallete.gradient3,
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
