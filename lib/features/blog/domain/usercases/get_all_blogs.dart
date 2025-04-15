import 'package:flutter_cleanarchitecture/core/error/failures.dart';
import 'package:flutter_cleanarchitecture/core/usercase/usecase.dart';
import 'package:flutter_cleanarchitecture/features/blog/domain/entities/blog.dart';
import 'package:flutter_cleanarchitecture/features/blog/domain/repositories/blog_respository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRespository blogRespository;
  GetAllBlogs(this.blogRespository);
  @override
  Future<Either<Failures, List<Blog>>> call(NoParams params) async {
    return await blogRespository.getAllBlogs();
  }
}
