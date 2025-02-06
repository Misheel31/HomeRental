part of 'property_bloc.dart';

class PropertyState extends Equatable {
  final List<PropertyEntity> properties;
  final bool isLoading;
  final String? error;

  const PropertyState({
    required this.properties,
    required this.isLoading,
    this.error,
  });

  factory PropertyState.initial() {
    return const PropertyState(
      properties: [],
      isLoading: false,
    );
  }

  PropertyState copyWith({
    List<PropertyEntity>? properties,
    bool? isLoading,
    String? error,
  }) {
    return PropertyState(
      properties: properties ?? this.properties,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [properties, isLoading, error];
}
