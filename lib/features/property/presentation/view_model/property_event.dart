part of 'property_bloc.dart';


@immutable
sealed class PropertyEvent extends Equatable {
  const PropertyEvent();

  @override
  List<Object> get props => [];
}

final class LoadProperties extends PropertyEvent {}

final class AddProperty extends PropertyEvent {
  final PropertyEntity property;
  const AddProperty(this.property);

  @override
  List<Object> get props => [property];
}

final class DeleteProperty extends PropertyEvent {
  final String propertyId;

  const DeleteProperty(this.propertyId);

  @override
  List<Object> get props => [propertyId];
}
