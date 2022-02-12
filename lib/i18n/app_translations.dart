import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'checkingServerStatus': 'Checking server status',
          'appName': 'Crypto Tracker',
          'coinListTitle': 'Coins/Tokens',
          'warning': 'Warning',
          'issueConnectingToCoingecko':
              'There is an issue trying to connect to the server.',
          'top100': 'Top 100',
          'favorite': 'Favorite',
          'settings': 'Settings',
          'lang': 'Language',
          'ver': 'Version: %s',
          'clearData': 'Clear data',
          'ok': 'Ok',
          'cancel': 'Cancel',
          'deleteWarningMessage': 'Data will be lost forever.',
        },
        'zh_CN': {
          'checkingServerStatus': '检测服务器运行状态',
          'appName': '虚拟币跟踪器',
          'coinListTitle': '货币/代币',
          'warning': '警告',
          'issueConnectingToCoingecko': '链接服务器出现错误',
          'top100': 'Top 100',
          'favorite': '个人珍藏',
          'settings': '设置',
          'lang': '语言',
          'ver': '版本: %s',
          'clearData': '删除本地数据',
          'ok': '确认',
          'cancel': '取消',
          'deleteWarningMessage': '数据会永久丢失。',
        },
        'zh_HK': {
          'checkingServerStatus': '檢測服務器運行狀態',
          'appName': '虛擬幣跟蹤器',
          'coinListTitle': '貨幣/代幣',
          'warning': '警告',
          'issueConnectingToCoingecko': '鏈接服務器出現錯誤',
          'top100': 'Top 100',
          'favorite': '個人珍藏',
          'settings': '設置',
          'lang': '語言',
          'ver': '版本: %s',
          'clearData': '刪除本地數據',
          'ok': '確認',
          'cancel': '取消',
          'deleteWarningMessage': '數據會永久丟失。',
        }
      };
}

const localeZhCN = Locale('zh', 'CN');
const localeZhHK = Locale('zh', 'HK');
const localeEn = Locale('en');
