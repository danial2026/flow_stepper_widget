import 'package:flow_stepper_widget/src/models/label_enums.dart';
import 'package:flow_stepper_widget/src/models/label_order_enums.dart';
import 'package:flutter/material.dart';
import 'models/flow_step.dart';

/// A customizable stepper widget that displays a list of steps with connecting lines.
///
/// The widget supports both vertical and horizontal layouts, with full control over
/// styling and behavior through various callbacks and customization options.
class FlowStepperWidget extends StatelessWidget {
  /// List of steps to display
  final List<FlowStep> steps;

  /// Label fitting type
  final LabelType labelType;

  /// Label order type
  final LabelOrderType labelOrderType;

  /// Direction of the stepper (vertical or horizontal)
  final Axis direction;

  /// Spacing between steps
  final double spacing;

  /// Active color of the connecting lines
  final Color? lineActiveColor;

  /// Inactive color of the connecting lines
  final Color? lineInactiveColor;

  /// Thickness of the connecting lines
  final double? lineThickness;

  /// Pattern for dashed lines (e.g. [4, 2] for 4px dash, 2px gap)
  final List<double>? dashPattern;

  /// Whether to show connecting lines
  final bool showLines;

  /// Whether to reverse the order of steps
  final bool reverse;

  /// Color for active steps
  final Color activeStepColor;

  /// Color for inactive steps
  final Color inactiveStepColor;

  /// Color for disabled steps
  final Color disabledStepColor;

  /// Size for step icons
  final double stepIconSize;

  /// Text style for step labels
  final TextStyle stepTextStyle;

  /// Shape for step containers
  final ShapeBorder stepShape;

  /// Padding for step containers
  final EdgeInsetsGeometry stepPadding;

  /// Animation duration for state changes
  final Duration stepAnimationDuration;

  /// Text direction for RTL/LTR support
  final TextDirection textDirection;

  /// Callback when a step is tapped
  final void Function(String id, bool newState)? onStepTap;

  /// Callback when a step is long-pressed
  final void Function(String id)? onStepLongPress;

  /// Custom builder for step indicators
  final Widget Function(BuildContext, FlowStep)? indicatorBuilder;

  /// Custom builder for step labels
  final Widget Function(BuildContext, FlowStep)? labelBuilder;

  /// Custom builder for step icons
  final Widget Function(BuildContext, FlowStep, Color, double)? stepIconBuilder;

  /// Custom painter for connecting lines
  final CustomPainter? linePainter;

  /// Creates a new [FlowStepperWidget].
  const FlowStepperWidget({
    super.key,
    required this.steps,
    this.labelType = LabelType.vertical,
    this.direction = Axis.vertical,
    this.labelOrderType = LabelOrderType.start,
    this.spacing = 24.0,
    this.lineActiveColor,
    this.lineInactiveColor,
    this.lineThickness = 1.0,
    this.dashPattern,
    this.showLines = true,
    this.reverse = false,
    this.activeStepColor = Colors.blue,
    this.inactiveStepColor = Colors.grey,
    this.disabledStepColor = Colors.grey,
    this.stepIconSize = 32.0,
    this.stepTextStyle = const TextStyle(fontSize: 16),
    this.stepShape = const CircleBorder(),
    this.stepPadding = const EdgeInsets.all(12),
    this.stepAnimationDuration = const Duration(milliseconds: 300),
    this.textDirection = TextDirection.ltr,
    this.onStepTap,
    this.onStepLongPress,
    this.indicatorBuilder,
    this.labelBuilder,
    this.stepIconBuilder,
    this.linePainter,
  });

  @override
  Widget build(BuildContext context) {
    final orderedSteps = reverse ? steps.reversed.toList() : steps;

    return Directionality(
      textDirection: textDirection,
      child: direction == Axis.vertical
          ? Column(
              mainAxisSize: labelType == LabelType.vertical ? MainAxisSize.min : MainAxisSize.max,
              mainAxisAlignment: labelType == LabelType.vertical
                  ? MainAxisAlignment.center
                  : (labelOrderType == LabelOrderType.start ? MainAxisAlignment.end : MainAxisAlignment.start),
              crossAxisAlignment: labelType == LabelType.vertical
                  ? CrossAxisAlignment.center
                  : (labelOrderType == LabelOrderType.start ? CrossAxisAlignment.end : CrossAxisAlignment.start),
              children: List.generate(
                orderedSteps.length,
                (index) => buildStep(context, orderedSteps[index], index, orderedSteps.length,
                    (index < orderedSteps.length - 1 && orderedSteps[index + 1].active && orderedSteps[index].active)),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                orderedSteps.length,
                (index) => buildStep(context, orderedSteps[index], index, orderedSteps.length,
                    (index < orderedSteps.length - 1 && orderedSteps[index + 1].active && orderedSteps[index].active)),
              ),
            ),
    );
  }

  Widget buildStep(BuildContext context, FlowStep step, int index, int orderedStepsLength, bool isLineActiveColor) {
    final isLast = index == orderedStepsLength - 1;

    return direction == Axis.vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: labelType == LabelType.vertical
                ? CrossAxisAlignment.center
                : (labelOrderType == LabelOrderType.start ? CrossAxisAlignment.end : CrossAxisAlignment.start),
            children: [
              _buildStepContent(context, step),
              if (showLines && !isLast) _buildConnectingLine(isLineActiveColor),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: labelOrderType == LabelOrderType.start && labelType == LabelType.vertical
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              _buildStepContent(context, step),
              if (showLines && !isLast) _buildConnectingLine(isLineActiveColor),
            ],
          );
  }

  Widget _buildStepContent(BuildContext context, FlowStep step) {
    final effectiveColor = step.enabled
        ? (step.active ? step.activeColor ?? activeStepColor : step.inactiveColor ?? inactiveStepColor)
        : step.disabledColor ?? disabledStepColor;

    final indicator = indicatorBuilder?.call(context, step) ??
        AnimatedContainer(
          duration: step.animationDuration ?? stepAnimationDuration,
          decoration: ShapeDecoration(
            shape: step.shape ?? stepShape,
            color: effectiveColor,
          ),
          padding: step.padding ?? stepPadding,
          child: stepIconBuilder?.call(context, step, effectiveColor, step.iconSize ?? stepIconSize) ??
              Icon(
                step.icon,
                size: step.iconSize ?? stepIconSize,
                color: Colors.white,
              ),
        );

    final label = labelBuilder?.call(context, step) ??
        Text(
          step.label,
          style: (step.textStyle ?? stepTextStyle).copyWith(
            color: effectiveColor,
          ),
        );

    return labelType == LabelType.vertical
        ? Semantics(
            label: step.semanticLabel ?? step.label,
            enabled: step.enabled,
            button: true,
            child: GestureDetector(
              onTap: step.enabled ? () => onStepTap?.call(step.id, !step.active) : null,
              onLongPress: () => onStepLongPress?.call(step.id),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: labelOrderType == LabelOrderType.start
                    ? [label, const SizedBox(height: 8), indicator]
                    : [indicator, const SizedBox(height: 8), label],
              ),
            ),
          )
        : Semantics(
            label: step.semanticLabel ?? step.label,
            enabled: step.enabled,
            button: true,
            child: GestureDetector(
              onTap: step.enabled ? () => onStepTap?.call(step.id, !step.active) : null,
              onLongPress: () => onStepLongPress?.call(step.id),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: labelOrderType == LabelOrderType.start
                    ? [label, const SizedBox(width: 8), indicator]
                    : [indicator, const SizedBox(width: 8), label],
              ),
            ),
          );
  }

  Widget _buildConnectingLine(bool isLineActiveColor) {
    if (linePainter != null) {
      return CustomPaint(
        painter: linePainter,
        size: Size(
          direction == Axis.vertical ? lineThickness ?? 1.0 : spacing,
          direction == Axis.vertical ? spacing : lineThickness ?? 1.0,
        ),
      );
    }

    return Padding(
      padding: direction == Axis.vertical
          ? (labelType == LabelType.vertical
              ? (EdgeInsets.all(0))
              : (labelOrderType == LabelOrderType.start
                  ? EdgeInsets.only(right: getStepPaddingHorizontal)
                  : EdgeInsets.only(left: getStepPaddingHorizontal)))
          : (labelType == LabelType.vertical
              ? (labelOrderType == LabelOrderType.end
                  ? EdgeInsets.only(top: getStepPaddingVertical)
                  : EdgeInsets.only(bottom: getStepPaddingVertical))
              : EdgeInsets.only(top: getStepPaddingVertical)),
      child: Container(
        width: direction == Axis.vertical ? lineThickness ?? 1.0 : spacing,
        height: direction == Axis.vertical ? spacing : lineThickness ?? 1.0,
        decoration: BoxDecoration(
          color: isLineActiveColor ? lineActiveColor ?? activeStepColor : lineInactiveColor ?? inactiveStepColor,
          border: dashPattern != null
              ? Border(
                  left: BorderSide(
                    color: isLineActiveColor ? lineActiveColor ?? activeStepColor : lineInactiveColor ?? inactiveStepColor,
                    width: lineThickness ?? 1.0,
                    style: BorderStyle.solid,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  double get getStepPaddingVertical => (stepIconSize + (stepPadding.vertical)) / 2 - (lineThickness ?? 1.0);

  double get getStepPaddingHorizontal => (stepIconSize + (stepPadding.horizontal)) / 2 - (lineThickness ?? 1.0);
}
