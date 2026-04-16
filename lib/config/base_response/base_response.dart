import '../base_state/base_state.dart';

sealed class BaseResponse<T> {}

class SuccessResponse<T> extends BaseResponse<T> {
  final T data;
  SuccessResponse({required this.data});
}

class ErrorResponse<T> extends BaseResponse<T> {
  final Exception error;
  ErrorResponse({required this.error});
}

extension BaseResponseMapper<T> on BaseResponse<T> {
  R map<R>({
    required R Function(SuccessResponse<T> value) success,
    required R Function(ErrorResponse<T> error) failure,
  }) {
    return switch (this) {
      SuccessResponse<T>() => success(this as SuccessResponse<T>),
      ErrorResponse<T>() => failure(this as ErrorResponse<T>),
    };
  }

  BaseState<T> toBaseState() {
    return switch (this) {
      SuccessResponse<T>() => BaseState(
        data: (this as SuccessResponse<T>).data,
      ),
      ErrorResponse<T>() => BaseState(error: (this as ErrorResponse<T>).error),
    };
  }
}
