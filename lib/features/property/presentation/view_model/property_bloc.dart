import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:home_rental/features/property/domain/entity/property_entity.dart';
import 'package:home_rental/features/property/domain/use_case/create_property_usecase.dart';
import 'package:home_rental/features/property/domain/use_case/delete_property_usecase.dart';
import 'package:home_rental/features/property/domain/use_case/get_all_property_usecase.dart';

part 'property_event.dart';
part 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final CreatePropertyUseCase _createPropertyUseCase;
  final GetAllPropertyUsecase _getAllPropertiesUseCase;
  final DeletePropertyUsecase _deletePropertyUseCase;

  PropertyBloc({
    required CreatePropertyUseCase createPropertyUseCase,
    required GetAllPropertyUsecase getAllPropertiesUseCase,
    required DeletePropertyUsecase deletePropertyUseCase,
  })  : _getAllPropertiesUseCase = getAllPropertiesUseCase,
        _createPropertyUseCase = createPropertyUseCase,
        _deletePropertyUseCase = deletePropertyUseCase,
        super(PropertyState.initial()) {
    on<LoadProperties>(_onLoadProperties);
    on<AddProperty>(_onAddProperty);
    on<DeleteProperty>(_onDeleteProperty);
    add(LoadProperties());
  }

  Future<void> _onLoadProperties(
      LoadProperties event, Emitter<PropertyState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllPropertiesUseCase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (properties) =>
          emit(state.copyWith(isLoading: false, properties: properties)),
    );
  }

  Future<void> _onAddProperty(
      AddProperty event, Emitter<PropertyState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createPropertyUseCase.call(CreatePropertyParams(
      title: event.property.title,
      description: event.property.description,
      pricePerNight: event.property.pricePerNight.toString(),
      location: event.property.location,
      state: event.property.state,
      city: event.property.city,
      country: event.property.country,
      image: event.property.image,
      bedCount: event.property.bedCount,
      bedroomCount: event.property.bedroomCount,
      bathroomCount: event.property.bathroomCount,
      amenities: event.property.amenities,
      available: event.property.available,
      guestCount: event.property.guestCount,
    ));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadProperties());
      },
    );
  }

  Future<void> _onDeleteProperty(
      DeleteProperty event, Emitter<PropertyState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deletePropertyUseCase
        .call(DeletePropertyParams(propertyId: event.propertyId));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadProperties());
      },
    );
  }
}
