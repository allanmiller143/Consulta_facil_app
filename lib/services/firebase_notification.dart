// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;



Future<void> handleBackgroundMessage(RemoteMessage message) async{
  print('Title: ${message.notification?.title}');
  print('Title: ${message.notification?.body}');
  print('Title: ${message.data}');

}

class FirebaseNotification {

  MyGlobalController myGlobalController = Get.find();
  late String FCMToken;
  final firebaseMessaging = FirebaseMessaging.instance;


  Future<void> initNotications() async {
    await firebaseMessaging.requestPermission();
    FCMToken = (await firebaseMessaging.getToken())!;
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    myGlobalController.token = FCMToken;
    print(FCMToken);
  }

  Future<void> sendNotificationToUser(String recipientToken, String title, String body) async {
    const String serverKey = 'AAAAB_4GQcs:APA91bH9B8FCXiQlX3Y3926Miyjl8yyYEcKot9OG7wXZEIKEeJBwnRmQEVBymi87-C4PKklFRw4fvC0DsO4HD8gKr2YxDc9S57Fh40aufTTM44gDl7L_h5SJQDVVxigbfXm_Lih2xTBP'; // Substitua pelo seu servidor Firebase Cloud Messaging (FCM) Key

    final Uri url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final Map<String, dynamic> notification = {
      'title': title,
      'body': body,
    };

    final Map<String, dynamic> data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK', // Adapte conforme necessário
      'data': {
        // Adicione dados adicionais, se necessário
        'key1': 'value1',
        'key2': 'value2',
      },
    };

    final Map<String, dynamic> requestBody = {
      'to': recipientToken,
      'notification': notification,
      'data': data,
      'priority': 'high',
    };

    final http.Response response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Error: ${response.reasonPhrase}');
    }
  }

  Future<void> send(token,titulo,corpo) async {
    String recipientToken = token;
    String title = titulo;
    String body = corpo;
    await sendNotificationToUser(recipientToken, title, body);
  }


} 

