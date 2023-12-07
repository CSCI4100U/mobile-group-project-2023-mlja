import 'package:flutter/material.dart';

class RunPage extends StatefulWidget {
  const RunPage({Key? key}) : super(key: key);

  @override
  _RunPageState createState() => _RunPageState();
}

class _RunPageState extends State<RunPage> {
  double runRating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Run Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Your Run Summary',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              _buildRunDetails(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRunDetails(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRunInfo(context, 'Distance', '5.0 km'),
            _buildRunInfo(context, 'Duration', '30 minutes'),
            _buildRunInfo(context, 'Pace', '6:00 min/km'),
            _buildRunInfo(context, 'Calories Burned', '300 kcal'),
            _buildRunInfo(context, 'Average Heart Rate', '150 bpm'),
            _buildRunInfo(context, 'Start Time', '08:00 AM'),
            _buildRunInfo(context, 'End Time', '08:30 AM'),
            const SizedBox(height: 16),
            _buildRunMap(),
            const SizedBox(height: 16),
            _buildRunFeelings(context),
          ],
        ),
      ),
    );
  }

  Widget _buildRunInfo(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }

  Widget _buildRunMap() {
    return Image.network(
      'https://www.google.com/maps/d/u/0/thumbnail?mid=1T0PVvwSyrRZYDhM5FObXXupuEvo&hl=en',
      fit: BoxFit.cover,
      height: 250,
      width: double.infinity,
    );
  }

  Widget _buildRunFeelings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How did you feel about your run?',
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Enter your comments...',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Rate your run:',
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 8),
        Slider(
          value: runRating,
          min: 1.0,
          max: 5.0,
          divisions: 4,
          onChanged: (value) {
            setState(() {
              runRating = value;
            });
          },
          label: 'Rating: ${runRating.round()}',
        ),
        const SizedBox(height: 16),
        _buildAdditionalDetails(context),
      ],
    );
  }

  Widget _buildAdditionalDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Details:',
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 8),
        _buildDetailField(context, 'Weather Conditions', 'Sunny'),
        _buildDetailField(context, 'Temperature', '25°C'),
        _buildDetailField(context, 'Shoes Worn', 'Nike Zoom Pegasus 38'),
      ],
    );
  }

  Widget _buildDetailField(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RunPage(),
  ));
}
