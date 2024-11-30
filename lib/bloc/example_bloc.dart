import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/auth_repo.dart';

class ExampleEvent {}

class ExampleRefreshEvent extends ExampleEvent {
  String? username;
  String code;

  ExampleRefreshEvent(this.username, this.code);
}

class ExampleState {}

class ExampleInitialState extends ExampleState {}

class ExampleLoadingState extends ExampleState {}

class ExampleSuccessState extends ExampleState {
  ExampleSuccessState();
}

class ExampleErrorState extends ExampleState {
  ExampleErrorState();
}

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  AuthRepo authRepository;

  ExampleBloc(this.authRepository) : super(ExampleInitialState());

  @override
  Stream<ExampleState> mapEventToState(ExampleEvent event) async* {
    try {
      if (event is ExampleRefreshEvent) {
        yield ExampleLoadingState();
        if (true) {
          yield ExampleSuccessState();
        } else {
          yield ExampleErrorState();
        }
      }
    } catch (e, stacktrace) {
      print("$e : $stacktrace");
      yield ExampleErrorState();
    }
  }
}
