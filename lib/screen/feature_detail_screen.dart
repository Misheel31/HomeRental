import 'package:flutter/material.dart';

class FeatureDetailScreen extends StatelessWidget {
  final String title;
  final String image;
  final String description;

  const FeatureDetailScreen({
    super.key,
    required this.title,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image Section
              image.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 300,
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text(
                          'Image not available',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
              const SizedBox(height: 16),
              // Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Description
              Text(
                description.isNotEmpty
                    ? description
                    : 'No description available',
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Property Features
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildFeatureIcon(Icons.bed, '4 Beds'),
                  _buildFeatureIcon(Icons.chair, '2 Sofas'),
                  _buildFeatureIcon(Icons.directions_car, 'Parking'),
                  _buildFeatureIcon(Icons.pool, 'Swimming Pool'),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build feature icons
  Widget _buildFeatureIcon(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blueAccent.withOpacity(0.2),
          child: Icon(
            icon,
            size: 30,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}


// import 'package:flutter/material.dart';

// class FeatureDetailScreen extends StatelessWidget {
//   const FeatureDetailScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Description')),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.asset('assets/images/image.png'),
//             const Text(
//               'Modern Family House',
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const Row(
//               children: [
//                 Icon(Icons.location_on, size: 18),
//                 Text('Colorado, USA'),
//                 Spacer(),
//                 Icon(Icons.star, color: Colors.amber),
//                 Text('4.3'),
//               ],
//             ),
//             const SizedBox(height: 10),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Column(children: [Icon(Icons.bed), Text('Bed')]),
//                 Column(children: [Icon(Icons.chair), Text('Sofa')]),
//                 Column(children: [Icon(Icons.car_repair), Text('Parking')]),
//                 Column(children: [Icon(Icons.pool), Text('Swimming')]),
//               ],
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'This house is suitable for people who have a large family... [Read More]',
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
