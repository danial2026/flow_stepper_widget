import 'package:flutter/material.dart';

/// A model class representing a single step in the flow stepper.
///
/// Each step has a unique identifier, label, icon, and various styling options
/// that can be customized individually or inherited from the parent widget.
class FlowStep {
  /// Unique identifier for the step
  final String id;

  /// Text label displayed for the step
  final String label;

  /// Icon displayed for the step
  final IconData? icon;

  /// Whether this step is currently active
  final bool active;

  /// Whether this step can be interacted with
  final bool enabled;

  /// Custom color for the active state
  final Color? activeColor;

  /// Custom color for the inactive state
  final Color? inactiveColor;

  /// Custom color for the disabled state
  final Color? disabledColor;

  /// Custom size for the step's icon
  final double? iconSize;

  /// Custom text style for the step's label
  final TextStyle? textStyle;

  /// Custom shape for the step's container
  final ShapeBorder? shape;

  /// Custom padding for the step's container
  final EdgeInsetsGeometry? padding;

  /// Custom animation duration for state changes
  final Duration? animationDuration;

  /// Custom semantic label for accessibility
  final String? semanticLabel;

  /// Creates a new [FlowStep].
  ///
  /// The [id], [label], and [icon] parameters are required.
  /// All other parameters are optional and will inherit from the parent widget if not specified.
  const FlowStep({
    required this.id,
    required this.label,
    this.icon,
    this.active = false,
    this.enabled = true,
    this.activeColor,
    this.inactiveColor,
    this.disabledColor,
    this.iconSize,
    this.textStyle,
    this.shape,
    this.padding,
    this.animationDuration,
    this.semanticLabel,
  });

  /// Creates a copy of this [FlowStep] with the given fields replaced with the new values.
  FlowStep copyWith({
    String? id,
    String? label,
    IconData? icon,
    bool? active,
    bool? enabled,
    Color? activeColor,
    Color? inactiveColor,
    Color? disabledColor,
    double? iconSize,
    TextStyle? textStyle,
    ShapeBorder? shape,
    EdgeInsetsGeometry? padding,
    Duration? animationDuration,
    String? semanticLabel,
  }) {
    return FlowStep(
      id: id ?? this.id,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      active: active ?? this.active,
      enabled: enabled ?? this.enabled,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      disabledColor: disabledColor ?? this.disabledColor,
      iconSize: iconSize ?? this.iconSize,
      textStyle: textStyle ?? this.textStyle,
      shape: shape ?? this.shape,
      padding: padding ?? this.padding,
      animationDuration: animationDuration ?? this.animationDuration,
      semanticLabel: semanticLabel ?? this.semanticLabel,
    );
  }
}
