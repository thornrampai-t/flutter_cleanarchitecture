import 'package:flutter_cleanarchitecture/core/error/failures.dart';
import 'package:flutter_cleanarchitecture/core/usercase/usecase.dart';
import 'package:flutter_cleanarchitecture/core/comment/entities/user.dart';
import 'package:flutter_cleanarchitecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);
  @override
  Future<Either<Failures, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
