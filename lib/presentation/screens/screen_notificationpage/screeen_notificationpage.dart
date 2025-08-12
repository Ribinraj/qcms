import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:qcms/core/colors.dart';
import 'package:qcms/core/constants.dart';
import 'package:qcms/widgets/custom_routes.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: "Order Successfull",
      message: "Your orer placed successfully !!",
      time: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
      type: NotificationType.message,
    ),
    NotificationItem(
      title: "Payment successful",
      message: "Your Payment will be completed",
      time: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: true,
      type: NotificationType.payment,
    ),
    NotificationItem(
      title: "New update available",
      message: "Version 2.0.1 is now available for download",
      time: DateTime.now().subtract(const Duration(hours: 8)),
      isRead: true,
      type: NotificationType.update,
    ),
  ];
  @override
  void initState() {
    super.initState();
    // context.read<FetchNotificationBloc>().add(FetchNotificationInitailEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            CustomNavigation.pop(context);
          },
          icon: Icon(Icons.chevron_left, size: 30),
        ),
        title: TextStyles.subheadline(
          text: 'Notifications',
          color: Appcolors.kprimarycolor,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return notifications.isEmpty
              ? _buildEmptyState()
              : _buildNotificationCard(context, notifications[index]);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            "No notifications yet",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "We'll notify you when something arrives",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    NotificationItem notification,
  ) {
    return Card(
      margin: const EdgeInsets.only(right: 16, left: 16, top: 10),
      elevation: 0,
      color: Appcolors.kwhitecolor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: const Icon(
          Icons.notifications_active_outlined,
          color: Appcolors.kprimarycolor,
          size: 24,
        ),
        // title: TextStyles.body(
        //   text: notification.title,
        //   weight: notification.isRead ? FontWeight.normal : FontWeight.bold,
        //   color: Appcolors.kblackColor,
        // ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification.message,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              _formatTime(notification.time),
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 7) {
      return DateFormat('MMM d, yyyy').format(time);
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
}

enum NotificationType { message, payment, update, social, reminder }

class NotificationItem {
  final String title;
  final String message;
  final DateTime time;
  final bool isRead;
  final NotificationType type;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
    required this.type,
  });
}
