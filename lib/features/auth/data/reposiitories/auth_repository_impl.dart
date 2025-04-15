import 'package:flutter_cleanarchitecture/core/constants/constants.dart';
import 'package:flutter_cleanarchitecture/core/error/exceptions.dart';
import 'package:flutter_cleanarchitecture/core/error/failures.dart';
import 'package:flutter_cleanarchitecture/core/network/connection_checker.dart';
import 'package:flutter_cleanarchitecture/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:flutter_cleanarchitecture/core/comment/entities/user.dart';
import 'package:flutter_cleanarchitecture/features/auth/data/models/user_model.dart';
import 'package:flutter_cleanarchitecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failures, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failures('User not logged in'));
        }
        return right(
          UserModel(id: session.user.id, email: session.user.email ?? '', name: ''),
        );
      }
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failures('User not logged in'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, User>> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failures, User>> singUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failures, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failures(Constants.noConnectionErrorMessage));
      }
      final user = await fn();
      return right(user);
    }  on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
}
