import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/auth_remote_datasource.dart';
import '../../../../data/models/request/login_request_model.dart';
import '../../../../data/models/responses/auth_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(_Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());
      final response = await AuthRemoteDatasource().login(event.data);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
