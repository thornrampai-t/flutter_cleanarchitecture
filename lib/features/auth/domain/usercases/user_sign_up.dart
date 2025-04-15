import 'package:flutter_cleanarchitecture/core/error/failures.dart';
import 'package:flutter_cleanarchitecture/core/usercase/usecase.dart';
import 'package:flutter_cleanarchitecture/core/comment/entities/user.dart';
import 'package:flutter_cleanarchitecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserSignUp implements UseCase<User, UserSingUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);
  @override
  Future<Either<Failures, User>> call(UserSingUpParams params) async {
  return await authRepository.singUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
    
  }
  
}

class UserSingUpParams {
  final String email;
  final String password;
  final String name;

  UserSingUpParams({required this.email,required this.password,required this.name});
}
