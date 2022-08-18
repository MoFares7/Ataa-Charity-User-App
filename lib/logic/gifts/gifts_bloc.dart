import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charity_management_system/data/content/gift_services.dart';
import 'package:charity_management_system/data/model/get_gift.dart';
import 'package:equatable/equatable.dart';

part 'gifts_event.dart';
part 'gifts_state.dart';

class GiftsBloc extends Bloc<GiftsEvent, GiftsState> {
  final GiftServices _giftsServices;

  GiftsBloc()
      : _giftsServices = GiftServices(),
        super(GiftsLoading()) {
    on<GetGifts>(_onGetGifts);
    on<SendGift>(_onSendGift);
  }

  Future<void> _onGetGifts(
    GetGifts event,
    Emitter<GiftsState> emit,
  ) async {
    emit(GiftsLoading());
    List<GiftModel>? gifts = await _giftsServices.getGiftService();
    if (gifts == null) {
      emit(GiftsLoadFailure());
    } else {
      emit(GiftsLoaded(gifts: gifts));
    }
  }

  Future<void> _onSendGift(
    SendGift event,
    Emitter<GiftsState> emit,
  ) async {
    emit(GiftsLoading());
    bool sent = await _giftsServices.addGiftService(event.giftModel);
    if (sent) {
      emit(GiftAdded());
      List<GiftModel>? gifts = await _giftsServices.getGiftService();
      if (gifts == null) {
        emit(GiftsLoadFailure());
      } else {
        emit(GiftsLoaded(gifts: gifts));
      }
    } else {
      emit(GiftSendingFailure());
    }
  }
}
