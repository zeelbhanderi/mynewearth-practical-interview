import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../domain/entities/offering.dart';
import '../controllers/offering_controller.dart';

class AddEditOfferingPage extends StatefulWidget {
  final Offering? offering;

  const AddEditOfferingPage({super.key, this.offering});

  @override
  State<AddEditOfferingPage> createState() => _AddEditOfferingPageState();
}

class _AddEditOfferingPageState extends State<AddEditOfferingPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _practitionerNameController;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;

  String _selectedCategory = AppStrings.categories.first;
  String _selectedDuration = AppStrings.durations.first;
  String _selectedType = AppStrings.inPerson;

  bool get isEditing => widget.offering != null;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    if (isEditing) {
      _populateFields();
    }
  }

  void _initializeControllers() {
    _practitionerNameController = TextEditingController();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
  }

  void _populateFields() {
    final offering = widget.offering!;
    _practitionerNameController.text = offering.practitionerName;
    _titleController.text = offering.title;
    _descriptionController.text = offering.description;
    _priceController.text = offering.price.toString();
    _selectedCategory = offering.category;
    _selectedDuration = offering.duration;
    _selectedType = offering.type;
  }

  @override
  void dispose() {
    _practitionerNameController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OfferingController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? AppStrings.editOffering : AppStrings.addOffering,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.text),
        ),
      ),
      body: Obx(() {
        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      label: AppStrings.practitionerName,
                      hintText: 'Enter practitioner name',
                      controller: _practitionerNameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter practitioner name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      label: AppStrings.title,
                      hintText: 'Enter offering title',
                      controller: _titleController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      label: AppStrings.description,
                      hintText: 'Enter offering description',
                      controller: _descriptionController,
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildDropdownField(
                      label: AppStrings.category,
                      value: _selectedCategory,
                      items: AppStrings.categories,
                      onChanged: (value) => setState(() => _selectedCategory = value!),
                    ),
                    const SizedBox(height: 24),
                    _buildDropdownField(
                      label: AppStrings.duration,
                      value: _selectedDuration,
                      items: AppStrings.durations,
                      onChanged: (value) => setState(() => _selectedDuration = value!),
                    ),
                    const SizedBox(height: 24),
                    _buildTypeSelector(),
                    const SizedBox(height: 24),
                    CustomTextField(
                      label: AppStrings.price,
                      hintText: 'Enter price (USD)',
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if (double.parse(value) < 0) {
                          return 'Price must be positive';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value ? null : _saveOffering,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.text,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          AppStrings.save,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            if (controller.isLoading.value)
              Container(
                color: AppColors.description,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(color: AppColors.text),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textLight),
              dropdownColor: AppColors.surface,
              style: const TextStyle(color: AppColors.text, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.type,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildTypeOption(AppStrings.inPerson),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTypeOption(AppStrings.online),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeOption(String type) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              type == AppStrings.inPerson ? Icons.location_on : Icons.video_call,
              color: AppColors.text,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              type,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveOffering() {
    if (!_formKey.currentState!.validate()) return;

    final controller = Get.find<OfferingController>();
    final offering = Offering(
      id: isEditing ? widget.offering!.id : null,
      practitionerName: _practitionerNameController.text.trim(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _selectedCategory,
      duration: _selectedDuration,
      type: _selectedType,
      price: double.parse(_priceController.text.trim()),
      createdAt: isEditing ? widget.offering!.createdAt : DateTime.now(),
    );

    if (isEditing) {
      controller.updateExistingOffering(offering);
    } else {
      controller.addNewOffering(offering);
    }
  }
}