import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../data/services/location_service.dart';

class LocationBottomSheet extends StatefulWidget {
  final LocationResult currentLocation;
  final Function(LocationResult) onLocationSelected;

  const LocationBottomSheet({
    super.key,
    required this.currentLocation,
    required this.onLocationSelected,
  });

  static Future<void> show({
    required BuildContext context,
    required LocationResult currentLocation,
    required Function(LocationResult) onLocationSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LocationBottomSheet(
        currentLocation: currentLocation,
        onLocationSelected: onLocationSelected,
      ),
    );
  }

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  final LocationService _locationService = LocationService();
  final TextEditingController _pincodeController = TextEditingController();

  bool _isDetectingLocation = false;
  bool _isSearchingPincode = false;
  String? _searchError;
  List<LocationResult> _searchResults = [];

  @override
  void dispose() {
    _pincodeController.dispose();
    super.dispose();
  }

  Future<void> _handleDetectCurrentLocation() async {
    setState(() {
      _isDetectingLocation = true;
      _searchError = null;
    });

    try {
      final result = await _locationService.fetchCurrentLocation();
      if (mounted) {
        widget.onLocationSelected(result);
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _searchError = 'Unable to detect location. Please enter a pincode.';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDetectingLocation = false;
        });
      }
    }
  }

  Future<void> _handlePincodeSearch(String pincode) async {
    final cleanPin = pincode.trim();
    if (cleanPin.length != 6 || int.tryParse(cleanPin) == null) {
      setState(() {
        _searchError = 'Please enter a valid 6-digit pincode';
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isSearchingPincode = true;
      _searchError = null;
      _searchResults = [];
    });

    try {
      final results = await _locationService.fetchLocalitiesByPincode(cleanPin);
      if (mounted) {
        if (results.isEmpty) {
          setState(() {
            _searchError = 'No localities found for pincode $cleanPin';
          });
        } else {
          setState(() {
            _searchResults = results;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _searchError = 'Failed to search pincode. Please try again.';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSearchingPincode = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.p20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Handle Bar
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Header Title + Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Delivery Location',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            AppSizes.hGap12,

            // Detect Current Location Button (Unboxed with Red-Orange SVG icon before text)
            InkWell(
              onTap: _isDetectingLocation ? null : _handleDetectCurrentLocation,
              borderRadius: BorderRadius.circular(8.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
                child: Row(
                  children: [
                    _isDetectingLocation
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFFF3D00)),
                          )
                        : SvgPicture.asset(
                            'assets/icons/ic_current_location.svg',
                            width: 22,
                            height: 22,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFFFF3D00), // Vibrant Red-Orange Color
                              BlendMode.srcIn,
                            ),
                          ),
                    AppSizes.wGap12,
                    Expanded(
                      child: Text(
                        'Use My Current Location',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: const Color(0xFFFF3D00),
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            AppSizes.hGap8,

            // Pincode Search Box (Automatic on 6 digits with thin border line)
            TextField(
              controller: _pincodeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              onChanged: (val) {
                if (val.length == 6) {
                  _handlePincodeSearch(val);
                } else if (val.length < 6 && (_searchResults.isNotEmpty || _searchError != null)) {
                  setState(() {
                    _searchResults = [];
                    _searchError = null;
                  });
                }
              },
              decoration: InputDecoration(
                hintText: 'Enter 6-digit Pincode (e.g. 625006)',
                counterText: '',
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                prefixIcon: const Icon(Icons.pin_drop_outlined, size: 20, color: Colors.grey),
                suffixIcon: _isSearchingPincode
                    ? const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.lightPrimary),
                        ),
                      )
                    : _pincodeController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18, color: Colors.grey),
                            onPressed: () {
                              _pincodeController.clear();
                              setState(() {
                                _searchResults = [];
                                _searchError = null;
                              });
                            },
                          )
                        : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.lightPrimary, width: 1.0),
                ),
              ),
            ),

            // Search Error Message
            if (_searchError != null) ...[
              AppSizes.hGap8,
              Text(
                _searchError!,
                style: const TextStyle(color: Colors.redAccent, fontSize: 12.5),
              ),
            ],

            AppSizes.hGap16,

            // Search Results List
            if (_searchResults.isNotEmpty) ...[
              Text(
                'Select Locality',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              AppSizes.hGap8,
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 220),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _searchResults.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = _searchResults[index];
                    final isSelected = widget.currentLocation.displayLocation == item.displayLocation;

                    return ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      title: Text(
                        item.locality,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? AppColors.lightPrimary : Colors.black87,
                          fontSize: 14.0,
                        ),
                      ),
                      subtitle: Text(
                        item.fullAddress,
                        style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: AppColors.lightPrimary, size: 20)
                          : const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
                      onTap: () {
                        widget.onLocationSelected(item);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],

            AppSizes.hGap12,
          ],
        ),
      ),
    );
  }
}
