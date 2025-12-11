import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/notification.dart';

class NotificationScreen extends StatefulWidget {
  final User currentUser;

  NotificationScreen({required this.currentUser});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Mock 데이터
  List<NotificationModel> notifications = [
    NotificationModel(
      id: 1,
      userId: 1,
      title: 'AI 챗봇 개발 프로젝트 참여 승인',
      message: '프로젝트에 참여가 승인되었습니다',
      isRead: false,
      createdAt: DateTime.now().subtract(Duration(minutes: 5)),
    ),
    NotificationModel(
      id: 2,
      userId: 1,
      title: '쇼핑몰 플랫폼 구축 신청',
      message: '새로운 참여 신청이 있습니다',
      isRead: false,
      createdAt: DateTime.now().subtract(Duration(hours: 1)),
    ),
    NotificationModel(
      id: 3,
      userId: 1,
      title: '모바일 앱 프로젝트 참여 거절',
      message: '아쉽게도 이번에는 선발되지 못했습니다',
      isRead: true,
      createdAt: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return '방금 전';
    if (diff.inHours < 1) return '${diff.inMinutes}분 전';
    if (diff.inDays < 1) return '${diff.inHours}시간 전';
    return '${diff.inDays}일 전';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('알림')),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    '알림이 없습니다',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final noti = notifications[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: noti.isRead ? Colors.grey : Colors.blue,
                    child: Icon(Icons.notifications, color: Colors.white),
                  ),
                  title: Text(
                    noti.title,
                    style: TextStyle(
                      fontWeight: noti.isRead
                          ? FontWeight.normal
                          : FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(noti.message),
                  trailing: Text(
                    _formatDate(noti.createdAt),
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    setState(() {
                      notifications[index] = NotificationModel(
                        id: noti.id,
                        userId: noti.userId,
                        title: noti.title,
                        message: noti.message,
                        isRead: true,
                        createdAt: noti.createdAt,
                      );
                    });
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('알림을 읽었습니다')));
                  },
                );
              },
            ),
    );
  }
}
