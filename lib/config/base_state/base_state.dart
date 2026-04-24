// import 'package:equatable/equatable.dart';

// // ignore: must_be_immutable
// class BaseState<T> extends Equatable {
//   bool? isLoading;
//   Exception? error;
//   T? data;

//   BaseState({this.isLoading = false, this.error, this.data});

//   @override
//   List<Object?> get props => [isLoading, data, error];
// }



import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  final bool isLoading;
  final Exception? error;
  final T? data;

  const BaseState({
    this.isLoading = false,
    this.error,
    this.data,
  });

  factory BaseState.initial() {
    return const BaseState(
      isLoading: false,
      error: null,
      data: null,
    );
  }

  factory BaseState.loading() {
    return const BaseState(isLoading: true);
  }

  factory BaseState.success(T data) {
    return BaseState(isLoading: false, data: data);
  }

  factory BaseState.error(Exception error) {
    return BaseState(isLoading: false, error: error);
  }

  @override
  List<Object?> get props => [isLoading, data, error];
}