enum MuscleGroup {
  neck(string: 'Neck'),
  shoulders(string: 'Shoulders'),
  triceps(string: 'Triceps'),
  biceps(string: 'Biceps'),
  forearms(string: 'Forearms'),
  chest(string: 'Chest'),
  upperBack(string: 'Upper Back'),
  lats(string: 'Lats'),
  core(string: 'Core'),
  lowerBack(string: 'Lower Back'),
  glutes(string: 'Glutes'),
  hamstrings(string: 'Hamstrings'),
  quadriceps(string: 'Quadriceps'),
  calves(string: 'Calves'),
  other(string: 'Other');

  final String string;

  const MuscleGroup({required this.string});
}
