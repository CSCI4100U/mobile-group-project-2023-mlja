enum Equipment {
  adjustableBench(string: 'Adjustable Bench'),
  barbell(string: 'Barbell'),
  cableMachine(string: 'Cable Machine'),
  curlBar(string: 'Curl Bar'),
  dumbbells(string: 'Dumbbells'),
  exerciseBall(string: 'Exercise Ball'),
  flatBench(string: 'Flat Bench'),
  kettlebell(string: 'Kettlebell'),
  medicineBall(string: 'Medicine Ball'),
  powerRack(string: 'Power Rack'),
  pullUpBar(string: 'Pull Up Bar'),
  specializedMachine(string: 'Specialized Machine'),
  other(string: 'Other');

  final String string;

  const Equipment({required this.string});
}
