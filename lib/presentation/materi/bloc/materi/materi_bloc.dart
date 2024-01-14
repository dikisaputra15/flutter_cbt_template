// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_cbt_app/data/datasources/materi_remote_datasource.dart';

import '../../../../data/models/responses/materi_response_model.dart';

part 'materi_bloc.freezed.dart';
part 'materi_event.dart';
part 'materi_state.dart';

class MateriBloc extends Bloc<MateriEvent, MateriState> {
  final MateriRemoteDatasoutce materiRemoteDatasoutce;
  MateriBloc(
    this.materiRemoteDatasoutce,
  ) : super(const _Initial()) {
    on<MateriEvent>((event, emit) async{
      emit(const MateriState.loading());
      final response = await materiRemoteDatasoutce.getAllmateri(); 
      response.fold(
        (l) => emit(MateriState.error(l)),
        (r) => emit(MateriState.success(r)),
      );
    });
  }
}
