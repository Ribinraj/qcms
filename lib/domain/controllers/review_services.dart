
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewManager {
  static const String _complaintCountKey = 'complaint_submission_count';
  static const String _lastReviewKey = 'last_review_request';
  static const String _reviewDismissedKey = 'review_permanently_dismissed';
  
  static final InAppReview _inAppReview = InAppReview.instance;
  
  /// Call this method after successful complaint submission
  static Future<void> onComplaintSuccess(
    BuildContext context, {
    int triggerAfterCount = 3,
    int daysBetweenPrompts = 30,
    String? appStoreId,
    String? microsoftStoreId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Check if user permanently dismissed review
      final isPermanentlyDismissed = prefs.getBool(_reviewDismissedKey) ?? false;
      if (isPermanentlyDismissed) return;
      
      // Increment complaint submission count
      int complaintCount = prefs.getInt(_complaintCountKey) ?? 0;
      complaintCount++;
      await prefs.setInt(_complaintCountKey, complaintCount);
      
      print('Complaint count: $complaintCount');
      
      // Check if we should show review
      if (complaintCount >= triggerAfterCount) {
        await _maybeShowReview(
          context,
          daysBetweenPrompts: daysBetweenPrompts,
          appStoreId: appStoreId,
          microsoftStoreId: microsoftStoreId,
        );
      }
    } catch (e) {
      print('Error in ReviewManager.onComplaintSuccess: $e');
    }
  }
  
  static Future<void> _maybeShowReview(
    BuildContext context, {
    required int daysBetweenPrompts,
    String? appStoreId,
    String? microsoftStoreId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Check if review is available
      final isAvailable = await _inAppReview.isAvailable();
      if (!isAvailable) {
        print('In-app review not available');
        return;
      }
      
      // Check if enough time has passed since last prompt
      final lastPrompt = prefs.getInt(_lastReviewKey) ?? 0;
      final now = DateTime.now().millisecondsSinceEpoch;
      final daysSinceLastPrompt = (now - lastPrompt) / (1000 * 60 * 60 * 24);
      
      if (daysSinceLastPrompt < daysBetweenPrompts) {
        print('Not enough time passed since last review prompt');
        return;
      }
      
      // Show custom dialog first
      final reviewAction = await _showCustomReviewDialog(context);
      
      if (reviewAction == ReviewAction.rate) {
        await prefs.setInt(_lastReviewKey, now);
        await _requestReview(appStoreId: appStoreId, microsoftStoreId: microsoftStoreId);
      } else if (reviewAction == ReviewAction.neverAsk) {
        await prefs.setBool(_reviewDismissedKey, true);
      }
      // For ReviewAction.later, we do nothing and will ask again later
      
    } catch (e) {
      print('Error in _maybeShowReview: $e');
    }
  }
  
  static Future<ReviewAction?> _showCustomReviewDialog(BuildContext context) async {
    return showDialog<ReviewAction>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withAlpha(33),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.star_border_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Enjoying our service?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'We\'re glad to see you\'re actively using our complaint system! Your feedback helps us improve our services.',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              const Text(
                'Would you like to rate us on the app store?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  for (int i = 0; i < 5; i++)
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18,
                    ),
                  const SizedBox(width: 8),
                  const Text(
                    'Rate us',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(ReviewAction.neverAsk),
              child: Text(
                'Don\'t ask again',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(ReviewAction.later),
              child: Text(
                'Maybe later',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(ReviewAction.rate),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
              child: const Text(
                'Rate Now',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        );
      },
    );
  }
  
  static Future<void> _requestReview({
    String? appStoreId,
    String? microsoftStoreId,
  }) async {
    try {
      await _inAppReview.requestReview();
      print('In-app review requested successfully');
    } catch (e) {
      print('Error requesting review: $e');
      // Fallback to opening store listing
      await openStoreListing(
        appStoreId: appStoreId,
        microsoftStoreId: microsoftStoreId,
      );
    }
  }
  
  /// Force open store listing (can be called from settings or about page)
  static Future<void> openStoreListing({
    String? appStoreId,
    String? microsoftStoreId,
  }) async {
    try {
      await _inAppReview.openStoreListing(
        appStoreId: appStoreId ?? '',
        microsoftStoreId: microsoftStoreId ?? '',
      );
      print('Store listing opened successfully');
    } catch (e) {
      print('Error opening store listing: $e');
    }
  }
  
  /// Reset review preferences (useful for testing)
  static Future<void> resetReviewPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_complaintCountKey);
    await prefs.remove(_lastReviewKey);
    await prefs.remove(_reviewDismissedKey);
    print('Review preferences reset');
  }
  
  /// Get current review statistics (useful for debugging)
  static Future<ReviewStats> getReviewStats() async {
    final prefs = await SharedPreferences.getInstance();
    return ReviewStats(
      complaintCount: prefs.getInt(_complaintCountKey) ?? 0,
      lastReviewRequest: prefs.getInt(_lastReviewKey) ?? 0,
      isPermanentlyDismissed: prefs.getBool(_reviewDismissedKey) ?? false,
    );
  }
}

enum ReviewAction {
  rate,
  later,
  neverAsk,
}

class ReviewStats {
  final int complaintCount;
  final int lastReviewRequest;
  final bool isPermanentlyDismissed;
  
  const ReviewStats({
    required this.complaintCount,
    required this.lastReviewRequest,
    required this.isPermanentlyDismissed,
  });
  
  DateTime? get lastReviewDate {
    if (lastReviewRequest == 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(lastReviewRequest);
  }
  
  @override
  String toString() {
    return 'ReviewStats(complaints: $complaintCount, lastReview: $lastReviewDate, dismissed: $isPermanentlyDismissed)';
  }
}