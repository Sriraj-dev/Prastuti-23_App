
class ChoiceChipData {
  final String label;
  final bool isSelected;

  ChoiceChipData({
    required this.label,
    required this.isSelected,
  });

  ChoiceChipData copy({
    required String label,
    required bool isSelected,
  }) =>
      ChoiceChipData(
        label: label,
        isSelected: isSelected,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChoiceChipData &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          isSelected == other.isSelected;

  @override
  int get hashCode => label.hashCode ^ isSelected.hashCode;
}

class ChoiceChips {
  static final all = <ChoiceChipData>[
    ChoiceChipData(
      label: 'App Development',
      isSelected: false,
    ),
    ChoiceChipData(
      label: 'Web Development',
      isSelected: false,
    ),
    ChoiceChipData(
      label: 'Machine Learning',
      isSelected: false,
    ),
    ChoiceChipData(
      label: 'Analog',
      isSelected: false,
    ),
    ChoiceChipData(
      label: 'Digital',
      isSelected: false,
    ),
    ChoiceChipData(
      label: 'Computer Vision',
      isSelected: false,
    ),
    ChoiceChipData(
      label: 'AI',
      isSelected: false,
    ),
    // ChoiceChipData(
    //   label: '2:00pm - 3:00pm',
    //   isSelected: false,
    // ),
    // ChoiceChipData(
    //   label: '3:00pm - 4:00pm',
    //   isSelected: true,
    // ),
    // ChoiceChipData(
    //   label: '4:00pm - 5:00pm',
    //   isSelected: false,
    // ),
  ];
}
