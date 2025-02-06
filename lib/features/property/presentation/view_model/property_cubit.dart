import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_rental/features/property/domain/use_case/get_all_property_usecase.dart';
import 'package:home_rental/features/property/presentation/view_model/property_bloc.dart';


class PropertyCubit extends Cubit<PropertyState> {
  final GetAllPropertyUsecase getAllPropertyUsecase;

  PropertyCubit({required this.getAllPropertyUsecase})
      : super(PropertyState.initial());

  Future<void> getAllProperties() async {
    emit(state.copyWith(
        isLoading: true)); 
    final result = await getAllPropertyUsecase();

    result.fold(
      (failure) => emit(state
          .copyWith(properties: [], error: failure.message, isLoading: false)),
      (properties) =>
          emit(state.copyWith(properties: properties, isLoading: false)),
    );
  }
}
