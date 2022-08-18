part of 'gifts_bloc.dart';

abstract class GiftsState extends Equatable {
  const GiftsState();

  @override
  List<Object> get props => [];
}

class GiftsLoading extends GiftsState {}

class GiftsLoaded extends GiftsState {
  final List<GiftModel> gifts;

  const GiftsLoaded({required this.gifts});

  @override
  List<Object> get props => [gifts];
}

class GiftsLoadFailure extends GiftsState {}

class GiftSendingFailure extends GiftsState {}

class GiftAdded extends GiftsState {}
