import 'package:flow_stepper_widget/flow_stepper_widget.dart';
import 'package:flutter/material.dart';

/// Demo steps for the FlowStepperWidget example
final List<FlowStep> demoSteps = [
  const FlowStep(
    id: 'step1',
    label: 'Step 1',
    icon: Icons.star,
    active: true,
  ),
  const FlowStep(
    id: 'step2',
    label: 'Step 2',
    icon: Icons.star,
  ),
  const FlowStep(
    id: 'step4',
    label: 'Step 4',
    icon: Icons.star,
  ),
  const FlowStep(
    id: 'step3',
    label: 'Step 3',
    icon: Icons.star,
    enabled: false,
  ),
];
