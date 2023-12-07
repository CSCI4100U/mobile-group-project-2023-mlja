import 'package:flutter/material.dart';

/// A page that allows users to view and submit details about their run.
class RunPage extends StatefulWidget {
  const RunPage({Key? key}) : super(key: key);

  @override
  _RunPageState createState() => _RunPageState();
}

class _RunPageState extends State<RunPage> {
  // Run rating and comments controller for user feedback
  double runRating = 3.0;
  TextEditingController commentsController = TextEditingController();

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
              // Header with the title of the run summary
              Center(
                child: Text(
                  'Your Run Summary',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 16),

              // Section displaying run details and user inputs
              _buildRunDetails(context),
              const SizedBox(height: 16),

              // Button to submit run details
              ElevatedButton(
                onPressed: () {
                  // Handle the submission of run details
                  _submitRunDetails();
                },
                child: const Text('Submit Run Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build the section displaying run details
  Widget _buildRunDetails(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Run information such as distance, duration, pace, etc.
            _buildRunInfo(context, 'Distance', '5.0 km'),
            _buildRunInfo(context, 'Duration', '30 minutes'),
            _buildRunInfo(context, 'Pace', '6:00 min/km'),
            _buildRunInfo(context, 'Calories Burned', '300 kcal'),
            _buildRunInfo(context, 'Average Heart Rate', '150 bpm'),
            _buildRunInfo(context, 'Start Time', '08:00 AM'),
            _buildRunInfo(context, 'End Time', '08:30 AM'),
            const SizedBox(height: 16),

            // Widget displaying the run map (image)
            _buildRunMap(),
            const SizedBox(height: 16),

            // Widget for user feedback on the run
            _buildRunFeelings(context),
          ],
        ),
      ),
    );
  }

  // Widget to build individual run information row
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

  // Widget to display the run map (image)
  Widget _buildRunMap() {
    return Image.network(
      'https://www.google.com/maps/d/u/0/thumbnail?mid=1T0PVvwSyrRZYDhM5FObXXupuEvo&hl=en',
      fit: BoxFit.cover,
      height: 250,
      width: double.infinity,
    );
  }

  // Widget to gather user feedback on the run
  Widget _buildRunFeelings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text field for user comments on the run
        Text(
          'How did you feel about your run?',
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: commentsController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Enter your comments...',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),

        // Slider for user to rate the run
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

        // Additional details section (weather, temperature, shoes worn)
        _buildAdditionalDetails(context),
      ],
    );
  }

  // Widget to display additional details section
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

        // Individual detail fields (weather conditions, temperature, shoes worn)
        _buildDetailField(context, 'Weather Conditions', 'Sunny'),
        _buildDetailField(context, 'Temperature', '25°C'),
        _buildDetailField(context, 'Shoes Worn', 'Nike Zoom Pegasus 38'),
      ],
    );
  }

  // Widget to build individual detail field row
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

  // Method to handle the submission of run details
  void _submitRunDetails() {
    print('Run details submitted!');
  }
}
