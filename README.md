# Flow Stepper Widget

A lightweight, highly-customizable Flutter stepper/indicator widget with modern design and full styling control.

[![Live Demo](https://img.shields.io/badge/Live%20Demo-View%20Online-blue)](https://flow-stepper-widget.pages.dev/)

## Screenshots

| ![Demo Controls](https://raw.githubusercontent.com/danial2026/flow_stepper_widget/main/assets/demo-controls.png) | ![Demo Stepper](https://raw.githubusercontent.com/danial2026/flow_stepper_widget/main/assets/demo-stepper.png) |
|------------------------------------|------------------------------------|

## Features

- Vertical and horizontal layouts with flexible label positioning
- Customizable step indicators and labels
- Animated state transitions with configurable duration
- Dashed or solid connecting lines with adjustable thickness
- RTL/LTR support for internationalization
- Full accessibility support with semantic labels
- Material Design 3 ready
- Extensive customization options for colors, sizes, and shapes
- Support for custom builders for indicators, labels, and icons
- Custom line painter support for advanced line styling

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flow_stepper_widget: any
```

## Usage

```dart
import 'package:flow_stepper_widget/flow_stepper_widget.dart';

FlowStepperWidget(
  steps: [
    FlowStep(
      id: 'step1',
      label: 'Step 1',
      icon: Icons.check,
      active: true,
    ),
    FlowStep(
      id: 'step2',
      label: 'Step 2',
      icon: Icons.check,
      active: false,
    ),
    // Add more steps...
  ],
  direction: Axis.vertical,
  labelType: LabelType.vertical,
  labelOrderType: LabelOrderType.start,
)
```

## Customization Options

### Basic Properties

- `steps`: List of steps to display
- `direction`: Layout direction (vertical or horizontal)
- `labelType`: Label fitting type
- `labelOrderType`: Label order type
- `spacing`: Spacing between steps
- `reverse`: Whether to reverse the order of steps

### Styling

- `activeStepColor`: Color for active steps
- `inactiveStepColor`: Color for inactive steps
- `disabledStepColor`: Color for disabled steps
- `stepIconSize`: Size for step icons
- `stepTextStyle`: Text style for step labels
- `stepShape`: Shape for step containers
- `stepPadding`: Padding for step containers

### Line Customization

- `lineActiveColor`: Active color of connecting lines
- `lineInactiveColor`: Inactive color of connecting lines
- `lineThickness`: Thickness of connecting lines
- `dashPattern`: Pattern for dashed lines
- `showLines`: Whether to show connecting lines
- `linePainter`: Custom painter for connecting lines

### Callbacks

- `onStepTap`: Callback when a step is tapped
- `onStepLongPress`: Callback when a step is long-pressed

### Custom Builders

- `indicatorBuilder`: Custom builder for step indicators
- `labelBuilder`: Custom builder for step labels
- `stepIconBuilder`: Custom builder for step icons

### Animation

- `stepAnimationDuration`: Animation duration for state changes

### Localization

- `textDirection`: Text direction for RTL/LTR support

## Example

```dart
FlowStepperWidget(
  steps: [
    FlowStep(
      id: 'step1',
      label: 'First Step',
      icon: Icons.check,
      active: true,
      enabled: true,
    ),
    FlowStep(
      id: 'step2',
      label: 'Second Step',
      icon: Icons.check,
      active: false,
      enabled: true,
    ),
  ],
  direction: Axis.vertical,
  labelType: LabelType.vertical,
  labelOrderType: LabelOrderType.start,
  spacing: 24.0,
  activeStepColor: Colors.blue,
  inactiveStepColor: Colors.grey,
  stepIconSize: 32.0,
  onStepTap: (id, newState) {
    // Handle step tap
  },
)
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
