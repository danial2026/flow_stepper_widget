# Flow Stepper Widget

A lightweight, highly-customizable Flutter stepper/indicator widget with modern design and full styling control.

## Features

- Vertical and horizontal layouts
- Customizable step indicators and labels
- Animated state transitions
- Dashed or solid connecting lines
- RTL/LTR support
- Full accessibility support
- Material Design 3 ready
- Extensive customization options

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flow_stepper_widget: ^0.0.1
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:flow_stepper_widget/flow_stepper_widget.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlowStepperWidget(
      steps: [
        FlowStep(
          id: 'profile',
          label: 'Complete profile',
          icon: Icons.person,
          active: true,
        ),
        FlowStep(
          id: 'staff',
          label: 'Add staff (min. 1)',
          icon: Icons.group_add,
        ),
        FlowStep(
          id: 'services',
          label: 'Add services',
          icon: Icons.build,
        ),
        FlowStep(
          id: 'schedule',
          label: 'Set working days',
          icon: Icons.schedule,
        ),
        FlowStep(
          id: 'payment',
          label: 'Add payment (IBAN)',
          icon: Icons.payment,
          enabled: false,
        ),
      ],
      direction: Axis.vertical,
      spacing: 24,
      lineColor: Colors.grey.shade300,
      lineThickness: 1,
      dashPattern: [4, 2],
      activeStepColor: Colors.pink,
      inactiveStepColor: Colors.grey,
      disabledStepColor: Colors.grey.shade400,
      stepIconSize: 32,
      stepTextStyle: TextStyle(fontSize: 16),
      stepShape: CircleBorder(),
      stepPadding: EdgeInsets.all(12),
      stepAnimationDuration: Duration(milliseconds: 300),
      onStepTap: (id, active) => print('$id is now $active'),
      onStepLongPress: (id) => showTooltipFor(id),
    );
  }
}
```

## Customization

### Step Properties

Each step can be customized individually:

```dart
FlowStep(
  id: 'unique_id',
  label: 'Step Label',
  icon: Icons.star,
  active: true,
  enabled: true,
  activeColor: Colors.blue,
  inactiveColor: Colors.grey,
  disabledColor: Colors.grey.shade400,
  iconSize: 32,
  textStyle: TextStyle(fontSize: 16),
  shape: CircleBorder(),
  padding: EdgeInsets.all(12),
  animationDuration: Duration(milliseconds: 300),
  semanticLabel: 'Accessibility label',
)
```

### Widget Properties

The main widget supports various customization options:

```dart
FlowStepperWidget(
  steps: [...],
  direction: Axis.vertical,  // or Axis.horizontal
  labelType: LabelType.vertical,  // or LabelType.horizontal
  labelOrderType: LabelOrderType.start,  // or LabelOrderType.end
  spacing: 24,
  lineColor: Colors.grey,
  lineThickness: 1,
  dashPattern: [4, 2],  // for dashed lines
  showLines: true,
  reverse: false,
  activeStepColor: Colors.blue,
  inactiveStepColor: Colors.grey,
  disabledStepColor: Colors.grey.shade400,
  stepIconSize: 32,
  stepTextStyle: TextStyle(fontSize: 16),
  stepShape: CircleBorder(),
  stepPadding: EdgeInsets.all(12),
  stepAnimationDuration: Duration(milliseconds: 300),
  textDirection: TextDirection.ltr,
  onStepTap: (id, active) => print('$id is now $active'),
  onStepLongPress: (id) => showTooltipFor(id),
  indicatorBuilder: (context, step) => CustomIndicator(step),
  labelBuilder: (context, step) => CustomLabel(step),
  stepIconBuilder: (context, isActive, color, size) => CustomIcon(isActive, color, size),
  linePainter: CustomLinePainter(),
)
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
