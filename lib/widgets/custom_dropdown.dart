// import 'package:flutter/material.dart';
// import 'package:qcms/core/colors.dart';

// class CustomDropdown extends StatefulWidget {
//   final String? value;
//   final String hintText;
//   final List<String> items;
//   final void Function(String?)? onChanged;
//   final String? Function(String?)? validator;
//   final FocusNode? focusNode;

//   const CustomDropdown({
//     Key? key,
//     this.value,
//     required this.hintText,
//     required this.items,
//     this.onChanged,
//     this.validator,
//     this.focusNode,
//   }) : super(key: key);

//   @override
//   State<CustomDropdown> createState() => _CustomDropdownState();
// }

// class _CustomDropdownState extends State<CustomDropdown> {
//   bool _isOpen = false;
//   final LayerLink _layerLink = LayerLink();
//   OverlayEntry? _overlayEntry;

//   @override
//   void dispose() {
//     _closeDropdown();
//     super.dispose();
//   }

//   void _toggleDropdown() {
//     if (_isOpen) {
//       _closeDropdown();
//     } else {
//       _openDropdown();
//     }
//   }

//   void _openDropdown() {
//     _overlayEntry = _createOverlayEntry();
//     Overlay.of(context).insert(_overlayEntry!);
//     setState(() {
//       _isOpen = true;
//     });
//   }

//   void _closeDropdown() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//     setState(() {
//       _isOpen = false;
//     });
//   }

//   OverlayEntry _createOverlayEntry() {
//     RenderBox renderBox = context.findRenderObject() as RenderBox;
//     var size = renderBox.size;

//     return OverlayEntry(
//       builder: (context) => Positioned(
//         width: size.width,
//         child: CompositedTransformFollower(
//           link: _layerLink,
//           showWhenUnlinked: false,
//           offset: Offset(0.0, size.height),
//           child: Material(
//             elevation: 4.0,
//             borderRadius: BorderRadius.circular(4.0),
//             child: Container(
//               constraints: BoxConstraints(
//                 maxHeight: 200, // Limit dropdown height
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(4.0),
//                 border: Border.all(color: Colors.grey.shade400, width: 1.0),
//               ),
//               child: ListView.builder(
//                 padding: EdgeInsets.zero,
//                 shrinkWrap: true,
//                 itemCount: widget.items.length,
//                 itemBuilder: (context, index) {
//                   final item = widget.items[index];
//                   return InkWell(
//                     onTap: () {
//                       widget.onChanged?.call(item);
//                       _closeDropdown();
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 12,
//                       ),
//                       decoration: BoxDecoration(
//                         border: index < widget.items.length - 1
//                             ? Border(
//                                 bottom: BorderSide(
//                                   color: Colors.grey.shade200,
//                                   width: 1.0,
//                                 ),
//                               )
//                             : null,
//                       ),
//                       child: Text(
//                         item,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CompositedTransformTarget(
//       link: _layerLink,
//       child: GestureDetector(
//         onTap: _toggleDropdown,
//         child: Container(
//           decoration: BoxDecoration(
//             color: const Color(0xFFE8E4F3),
//             border: Border(
//               bottom: BorderSide(color: Appcolors.kbordercolor, width: 1.5),
//             ),
//           ),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     widget.value ?? widget.hintText,
//                     style: TextStyle(
//                       fontSize: widget.value != null ? 16 : 15,
//                       color: widget.value != null
//                           ? Colors.black87
//                           : const Color.fromARGB(255, 108, 106, 106),
//                     ),
//                   ),
//                 ),
//                 Icon(
//                   _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
//                   color: Colors.grey.shade600,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//////////////////////////
import 'package:flutter/material.dart';
import 'package:qcms/core/colors.dart';

class CustomDropdown extends StatefulWidget {
  final String? value;
  final String hintText;
  final List<String> items;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  const CustomDropdown({
    Key? key,
    this.value,
    required this.hintText,
    required this.items,
    this.onChanged,
    this.validator,
    this.focusNode,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool _isOpen = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    // Fix: Clean up without calling setState
    _overlayEntry?.remove();
    _overlayEntry = null;
    // Don't call _closeDropdown() here as it contains setState
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    if (mounted) {  // Fix: Check if widget is still mounted
      setState(() {
        _isOpen = true;
      });
    }
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {  // Fix: Check if widget is still mounted before setState
      setState(() {
        _isOpen = false;
      });
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(4.0),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 200, // Limit dropdown height
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Colors.grey.shade400, width: 1.0),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  return InkWell(
                    onTap: () {
                      widget.onChanged?.call(item);
                      _closeDropdown();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: index < widget.items.length - 1
                            ? Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade200,
                                  width: 1.0,
                                ),
                              )
                            : null,
                      ),
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE8E4F3),
            border: Border(
              bottom: BorderSide(color: Appcolors.kbordercolor, width: 1.5),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.value ?? widget.hintText,
                    style: TextStyle(
                      fontSize: widget.value != null ? 16 : 15,
                      color: widget.value != null
                          ? Colors.black87
                          : const Color.fromARGB(255, 108, 106, 106),
                    ),
                  ),
                ),
                Icon(
                  _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}