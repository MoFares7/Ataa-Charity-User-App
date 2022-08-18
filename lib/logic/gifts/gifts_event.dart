part of 'gifts_bloc.dart';

abstract class GiftsEvent extends Equatable {
  const GiftsEvent();

  @override
  List<Object> get props => [];
}

class GetGifts extends GiftsEvent {}

class SendGift extends GiftsEvent {
  final GiftModel giftModel;

  const SendGift({required this.giftModel});

  @override
  List<Object> get props => [giftModel];
}
