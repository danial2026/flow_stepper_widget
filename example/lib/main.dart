import 'package:flutter/material.dart';
import 'package:flow_stepper_widget/flow_stepper_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'mock_events.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flow Stepper Widget Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<FlowStep> _steps;

  final Color _activeColor = Colors.deepPurple;
  final Color _inactiveColor = Colors.grey;
  final Color _disabledColor = Colors.grey.shade400;

  bool _isVertical = true;
  bool _showLines = true;
  bool _reverse = false;
  double _spacing = 24.0;
  double _lineThickness = 1.0;
  List<double>? _dashPattern;

  ShapeBorder _shape = const CircleBorder();
  double _iconSize = 32.0;
  double _labelFontSize = 16.0;
  double _padding = 12.0;

  IconData _selectedIcon = Icons.star;
  bool _useCustomWidget = false;
  final double _customWidgetSize = 42;
  LabelType _selectedLabelEnum = LabelType.vertical;
  LabelOrderType _selectedLabelOrderEnum = LabelOrderType.start;

  @override
  void initState() {
    super.initState();
    _steps = List<FlowStep>.from(demoSteps);
  }

  void _toggleStep(String id, bool newState) {
    setState(() {
      final index = _steps.indexWhere((step) => step.id == id);
      if (index != -1) {
        _steps[index] = _steps[index].copyWith(active: newState);
      }
    });
  }

  void _showTooltip(String id) {
    final step = _steps.firstWhere((step) => step.id == id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${step.label} is ${step.enabled ? 'enabled' : 'disabled'}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }


  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flow Stepper Widget Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Package info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Flow Stepper Widget',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'A lightweight, highly-customizable Flutter stepper/indicator widget with modern design and full styling control.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        FilledButton.icon(
                          onPressed: () => _launchUrl('https://pub.dev/packages/flow_stepper_widget'),
                          icon: const Icon(Icons.public),
                          label: const Text('pub.dev'),
                        ),
                        const SizedBox(width: 8),
                        FilledButton.icon(
                          onPressed: () => _launchUrl('https://github.com/danial2026/flow_stepper_widget'),
                          icon: const Icon(Icons.code),
                          label: const Text('GitHub'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Controls
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Controls',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        SwitchListTile(
                          title: const Text('Vertical Layout'),
                          value: _isVertical,
                          onChanged: (value) => setState(() => _isVertical = value),
                        ),
                        SwitchListTile(
                          title: const Text('Show Lines'),
                          value: _showLines,
                          onChanged: (value) => setState(() => _showLines = value),
                        ),
                        SwitchListTile(
                          title: const Text('Reverse Order'),
                          value: _reverse,
                          onChanged: (value) => setState(() => _reverse = value),
                        ),
                        SwitchListTile(
                          title: const Text('Dashed Lines'),
                          value: _dashPattern != null,
                          onChanged: (value) => setState(() => _dashPattern = value ? [4, 2] : null),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Spacing'),
                              Slider(
                                value: _spacing,
                                min: 8,
                                max: 48,
                                divisions: 5,
                                label: _spacing.round().toString(),
                                onChanged: (value) => setState(() => _spacing = value),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Line Thickness'),
                              Slider(
                                value: _lineThickness,
                                min: 1,
                                max: 4,
                                divisions: 3,
                                label: _lineThickness.round().toString(),
                                onChanged: (value) => setState(() => _lineThickness = value),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Icon Size'),
                              Slider(
                                value: _iconSize,
                                min: 16,
                                max: 64,
                                divisions: 6,
                                label: _iconSize.round().toString(),
                                onChanged: (value) => setState(() => _iconSize = value),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Label Font Size'),
                              Slider(
                                value: _labelFontSize,
                                min: 10,
                                max: 32,
                                divisions: 11,
                                label: _labelFontSize.round().toString(),
                                onChanged: (value) => setState(() => _labelFontSize = value),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Padding'),
                              Slider(
                                value: _padding,
                                min: 0,
                                max: 32,
                                divisions: 8,
                                label: _padding.round().toString(),
                                onChanged: (value) => setState(() => _padding = value),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: DropdownButtonFormField<ShapeBorder>(
                            value: _shape,
                            decoration: const InputDecoration(labelText: 'Shape'),
                            items: const [
                              DropdownMenuItem(
                                value: CircleBorder(),
                                child: Text('Circle'),
                              ),
                              DropdownMenuItem(
                                value: StadiumBorder(),
                                child: Text('Stadium'),
                              ),
                              DropdownMenuItem(
                                value: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Text('Rounded Rectangle'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) setState(() => _shape = value);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: DropdownButtonFormField<IconData>(
                            value: _selectedIcon,
                            decoration: const InputDecoration(labelText: 'Step Icon'),
                            items: const [
                              DropdownMenuItem(
                                value: Icons.star,
                                child: Text('Star'),
                              ),
                              DropdownMenuItem(
                                value: Icons.check,
                                child: Text('Check'),
                              ),
                              DropdownMenuItem(
                                value: Icons.more_horiz,
                                child: Text('More'),
                              ),
                              DropdownMenuItem(
                                value: Icons.favorite,
                                child: Text('Favorite'),
                              ),
                              DropdownMenuItem(
                                value: Icons.circle,
                                child: Text('Circle'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) setState(() => _selectedIcon = value);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: DropdownButtonFormField<LabelType>(
                            value: _selectedLabelEnum,
                            decoration: const InputDecoration(labelText: 'Label Type'),
                            items: const [
                              DropdownMenuItem(
                                value: LabelType.vertical,
                                child: Text('Vertical'),
                              ),
                              DropdownMenuItem(
                                value: LabelType.horizontal,
                                child: Text('Horizontal'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) setState(() => _selectedLabelEnum = value);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: DropdownButtonFormField<LabelOrderType>(
                            value: _selectedLabelOrderEnum,
                            decoration: const InputDecoration(labelText: 'Label Order Type'),
                            items: const [
                              DropdownMenuItem(
                                value: LabelOrderType.start,
                                child: Text('Start'),
                              ),
                              DropdownMenuItem(
                                value: LabelOrderType.end,
                                child: Text('End'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) setState(() => _selectedLabelOrderEnum = value);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: SwitchListTile(
                            title: const Text('Custom Widget Indicator'),
                            value: _useCustomWidget,
                            onChanged: (value) => setState(() => _useCustomWidget = value),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Stepper
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Stepper',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: FlowStepperWidget(
                        steps: _steps
                            .map((step) => step.copyWith(
                                  icon: _selectedIcon,
                                  iconSize: _iconSize,
                                  textStyle: TextStyle(fontSize: _labelFontSize),
                                  shape: _shape,
                                  padding: EdgeInsets.all(_padding),
                                ))
                            .toList(),
                        labelType: _selectedLabelEnum,
                        direction: _isVertical ? Axis.vertical : Axis.horizontal,
                        labelOrderType: _selectedLabelOrderEnum,
                        spacing: _spacing,
                        showLines: _showLines,
                        reverse: _reverse,
                        lineActiveColor: _activeColor,
                        lineInactiveColor: _inactiveColor,
                        lineThickness: _lineThickness,
                        dashPattern: _dashPattern,
                        activeStepColor: _activeColor,
                        inactiveStepColor: _inactiveColor,
                        disabledStepColor: _disabledColor,
                        stepIconSize: _useCustomWidget ? _customWidgetSize : _iconSize,
                        stepTextStyle: TextStyle(fontSize: _labelFontSize),
                        stepShape: _shape,
                        stepPadding: EdgeInsets.all(_padding),
                        stepAnimationDuration: const Duration(milliseconds: 300),
                        onStepTap: _toggleStep,
                        onStepLongPress: _showTooltip,
                        stepIconBuilder: _useCustomWidget
                            ? (context, active, color, size) => Icon(
                                  Icons.edit,
                                  size: _customWidgetSize,
                                  color: Colors.white,
                                )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
