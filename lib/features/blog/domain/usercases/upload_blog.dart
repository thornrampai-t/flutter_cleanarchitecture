import 'dart:io';

import 'package:flutter_cleanarchitecture/core/error/failures.dart';
import 'package:flutter_cleanarchitecture/core/usercase/usecase.dart';
import 'package:flutter_cleanarchitecture/features/blog/domain/entities/blog.dart';
import 'package:flutter_cleanarchitecture/features/blog/domain/repositories/blog_respository.dart';
import 'package:fpdart/src/either.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRespository blogRespository;
  UploadBlog(this.blogRespository);

  @override
  Future<Either<Failures, Blog>> call(UploadBlogParams params) async {
    return await blogRespository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}
