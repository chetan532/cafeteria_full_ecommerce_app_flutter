import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'total_reviews_event.dart';

part 'total_reviews_state.dart';

class TotalReviewsBloc extends Bloc<TotalReviewsEvent, TotalReviewsState> {
  TotalReviewsBloc() : super(TotalReviewsInitial()) {
    on<TotalReviewWriteReviewClickEvent>(totalReviewWriteReviewClickEvent);
  }

  FutureOr<void> totalReviewWriteReviewClickEvent(
      TotalReviewWriteReviewClickEvent event, Emitter<TotalReviewsState> emit) {
    emit(TotalReviewWriteReviewClickState());
  }
}
