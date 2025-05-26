import 'package:flow_stepper_widget/flow_stepper_widget.dart';

/// Demo steps for the FlowStepperWidget example
final List<FlowStep> demoSteps = [
  const FlowStep(
    id: 'step1',
    label: 'Welcome to the Journey',
    active: true,
  ),
  const FlowStep(
    id: 'step2',
    label: 'Explore',
  ),
  const FlowStep(
    id: 'step3',
    label: 'Adventure Awaits',
    enabled: false,
  ),
  const FlowStep(
    id: 'step4',
    label: 'Options',
  ),
  const FlowStep(
    id: 'step5',
    label: 'Final Destination',
  ),
];
