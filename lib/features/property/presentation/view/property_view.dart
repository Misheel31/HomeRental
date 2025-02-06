import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_rental/features/property/presentation/view_model/property_bloc.dart';
import 'package:home_rental/features/property/presentation/view_model/property_cubit.dart';

class PropertyView extends StatefulWidget {
  const PropertyView({super.key});

  @override
  _PropertyViewState createState() => _PropertyViewState();
}

class _PropertyViewState extends State<PropertyView> {
  @override
  void initState() {
    super.initState();
    context.read<PropertyCubit>().getAllProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Property Listings"),
      ),
      body: BlocBuilder<PropertyCubit, PropertyState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.properties.isNotEmpty) {
            return ListView.builder(
              itemCount: state.properties.length,
              itemBuilder: (context, index) {
                final property = state.properties[index];
                return ListTile(
                  title: Text(property.title),
                  subtitle: Text(property.location),
                );
              },
            );
          } else if (state.error != null) {
            Future.delayed(Duration.zero, () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error!),
                  backgroundColor: Colors.red,
                ),
              );
            });
            return const Center(child: Text("Something went wrong"));
          } else {
            return const Center(child: Text("No properties available"));
          }
        },
      ),
    );
  }
}
