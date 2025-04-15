import 'dart:io';

import 'package:flutter_cleanarchitecture/core/constants/constants.dart';
import 'package:flutter_cleanarchitecture/core/error/exceptions.dart';
import 'package:flutter_cleanarchitecture/core/error/failures.dart';
import 'package:flutter_cleanarchitecture/core/network/connection_checker.dart';
import 'package:flutter_cleanarchitecture/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:flutter_cleanarchitecture/features/blog/data/datasources/blog_rermote_data_sources.dart';
import 'package:flutter_cleanarchitecture/features/blog/data/models/blog_model.dart';
import 'package:flutter_cleanarchitecture/features/blog/domain/entities/blog.dart';
import 'package:flutter_cleanarchitecture/features/blog/domain/repositories/blog_respository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRespositoryImpl implements BlogRespository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;
  BlogRespositoryImpl(
    this.blogRemoteDataSource,
    this.blogLocalDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failures, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failures(Constants.noConnectionErrorMessage));
      }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );
      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );
      print('Image uploaded. URL: $imageUrl');
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final uploadBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadBlog);
    } on ServerException catch (e) {
      return left(Failures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<Blog>>> getAllBlogs() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }
      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadLocalBlogs(blogs: blogs);

      return right(blogs);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
}
