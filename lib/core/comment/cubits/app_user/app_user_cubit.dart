import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cleanarchitecture/core/comment/entities/user.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(AppUserInitial());
    } else{
      emit(AppUserLoggedIn(user));
    }
  }
}
