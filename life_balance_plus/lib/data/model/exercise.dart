import 'package:life_balance_plus/data/enums/equipment.dart';
import 'package:life_balance_plus/data/enums/muscle_group.dart';

class Exercise {
  String name;
  String description;
  List<MuscleGroup> muscleGroups;
  List<Equipment> requiredEquipment;

  Exercise({
    required this.name,
    required this.description,
    List<MuscleGroup>? muscleGroups,
    List<Equipment>? requiredEquipment,
  })
    : this.muscleGroups = muscleGroups??[],
      this.requiredEquipment = requiredEquipment??[];
}
