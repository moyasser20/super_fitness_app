import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'dart:convert';
import 'dart:io';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:super_fitness_app/core/contants/app_icons.dart';
import 'package:super_fitness_app/core/contants/app_images.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/utils/styles.dart';
import 'package:uuid/uuid.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:super_fitness_app/features/bot/data/models/chat_session.dart';

class SmartCoachScreen extends StatefulWidget {
  const SmartCoachScreen({super.key});

  @override
  State<SmartCoachScreen> createState() => _BotScreenState();
}

class _BotScreenState extends State<SmartCoachScreen> {
  bool _isLoading = false;

  static const apiKey = "AIzaSyBrEkUbIjAw8QVxXU59350f6TAkyf_uGio";

  List<types.Message> _messages = [];
  final _user = const types.User(id: 'user', firstName: 'User');
  final _bot = const types.User(
    id: 'bot',
    firstName: 'Smart Coach',
    imageUrl: 'assets/images/3ced6317c71e5111fba3771c9aff81ef8315359e.jpg',
  );

  late Box<ChatSession> _chatBox;
  ChatSession? _currentSession;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ChatSessionAdapter());
    }
    _chatBox = await Hive.openBox<ChatSession>('chat_sessions');
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
    _saveCurrentSession();
  }

  void _saveCurrentSession() {
    if (_currentSession != null) {
      try {
        _currentSession!.messagesJson =
            _messages.map((msg) => msg.toJson()).toList();
        _currentSession!.updatedAt = DateTime.now();
        _currentSession!.save();
      } catch (e) {
        debugPrint('Error saving session: $e');
      }
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        final client = http.Client();
        final request = await client.get(Uri.parse(message.uri));
        final bytes = request.bodyBytes;
        final documentsDir = (await getApplicationDocumentsDirectory()).path;
        localPath = '$documentsDir/${message.name}';

        if (!File(localPath).existsSync()) {
          final file = File(localPath);
          await file.writeAsBytes(bytes);
        }
      }
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  Future<void> _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);

    if (_currentSession != null && _currentSession!.title == 'New Chat') {
      _currentSession!.title =
          message.text.length > 30
              ? '${message.text.substring(0, 30)}...'
              : message.text;
      _currentSession!.save();
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1/models/gemini-2.5-pro:generateContent?key=$apiKey',
      );

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {
                  'text': """
You are Smart Coach — a professional fitness and gym assistant.
You only answer questions related to gym workouts, fitness, nutrition, supplements, or exercise form.
If the user asks something outside this domain, reply strictly with:
"I'm your Smart Coach and I can only answer questions about fitness, gym, or nutrition."
Keep your tone motivational and supportive, and address the user as "Athlete".
User message: ${message.text}
""",
                },
              ],
            },
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final aiResponse = data['candidates'][0]['content']['parts'][0]['text'];

        final botMessage = types.TextMessage(
          author: _bot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: aiResponse,
        );

        _addMessage(botMessage);
      } else {
        final errorMessage = types.TextMessage(
          author: _bot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: "Sorry Athlete, there was an error processing your request.",
        );

        _addMessage(errorMessage);
      }
    } catch (e) {
      final errorMessage = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: "Sorry Athlete, there was an error processing your request.",
      );

      _addMessage(errorMessage);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _loadMessages() async {
    if (!_isInitialized) {
      _isInitialized = true;
      _createNewSession();
    }
  }

  void _createNewSession() {
    final now = DateTime.now();
    final sessionId = const Uuid().v4();

    final welcomeMessage = types.TextMessage(
      author: _bot,
      createdAt: now.millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: "Hello How Can I Assist You Today ?",
    );

    final messagesList = [welcomeMessage];

    _currentSession = ChatSession(
      id: sessionId,
      title: 'New Chat',
      messagesJson: messagesList.map((msg) => msg.toJson()).toList(),
      createdAt: now,
      updatedAt: now,
    );

    _chatBox.add(_currentSession!);

    setState(() {
      _messages = messagesList;
    });
  }

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.smartCoachImage),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withValues(alpha: 0.7),
                  BlendMode.darken,
                ),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: AppColors.main,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SvgPicture.asset(AppIcons.backIcon),
                            ),
                          ),
                        ),
                        Text(
                          "Smart Coach",
                          style: balooThambi2BoldExtraLarge.copyWith(
                            fontSize: 24,
                          ),
                        ),
                        IconButton(
                          onPressed: _showPastChats,
                          icon: Image.asset(
                            AppIcons.menuIcon,
                            width: 25,
                            height: 25,
                            color: AppColors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Chat(
                      messages: _messages,
                      onMessageTap: _handleMessageTap,
                      onPreviewDataFetched: _handlePreviewDataFetched,
                      onSendPressed: _handleSendPressed,
                      showUserAvatars: true,
                      showUserNames: true,
                      user: _user,
                      timeFormat: DateFormat('h:mm a'),
                      customBottomWidget: const SizedBox.shrink(),
                      theme: DefaultChatTheme(
                        backgroundColor: Colors.transparent,
                        primaryColor: Color(0x80FF6A00),
                        secondaryColor: Color(0x80242424),
                        userAvatarNameColors: [
                          AppColors.main,
                          AppColors.main,
                          AppColors.main,
                          AppColors.main,
                        ],
                        messageBorderRadius: 20,
                        sentMessageBodyTextStyle: balooThambi2BoldExtraLarge
                            .copyWith(fontSize: 14, color: Colors.white),
                        receivedMessageBodyTextStyle: balooThambi2BoldExtraLarge
                            .copyWith(fontSize: 14, color: Colors.white),
                        sentMessageCaptionTextStyle: balooThambi2BoldExtraLarge
                            .copyWith(fontSize: 12, color: Colors.white70),
                        receivedMessageCaptionTextStyle:
                            balooThambi2BoldExtraLarge.copyWith(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                        dateDividerTextStyle: balooThambi2BoldExtraLarge
                            .copyWith(fontSize: 12, color: Colors.white),
                        inputTextColor: Colors.white,
                        inputTextStyle: const TextStyle(color: Colors.white),
                        inputTextCursorColor: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          offset: const Offset(0, -1),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _textController,
                              cursorColor: AppColors.grey,
                              decoration: InputDecoration(
                                hintStyle: balooThambi2BoldExtraLarge.copyWith(
                                  fontSize: 12,
                                  color: AppColors.grey,
                                ),
                                hintText: 'Ask for anything about fitness..',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF5F5F5),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                              ),
                              textCapitalization: TextCapitalization.sentences,
                              onSubmitted: (text) {
                                if (text.trim().isNotEmpty) {
                                  _handleCustomSend(text);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Material(
                                color: AppColors.main,
                                borderRadius: BorderRadius.circular(30),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(30),
                                  onTap:
                                      _isLoading
                                          ? null
                                          : () {
                                            if (_textController.text
                                                .trim()
                                                .isNotEmpty) {
                                              _handleCustomSend(
                                                _textController.text,
                                              );
                                            }
                                          },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    child: const Icon(
                                      Icons.send_rounded,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                              if (_isLoading)
                                const SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 5,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleCustomSend(String text) {
    _textController.clear();
    final partialText = types.PartialText(text: text);
    _handleSendPressed(partialText);
  }

  void _showPastChats() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: const Color(0x80242424),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => Container(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));

        return SlideTransition(
          position: slideAnimation,
          child: Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(20),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Previous conversations',
                              style: balooThambi2BoldExtraLarge.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child:
                            _chatBox.isEmpty
                                ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.chat_bubble_outline,
                                        size: 64,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'No past chats yet',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                )
                                : ListView.builder(
                                  itemCount: _chatBox.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return ListTile(
                                        leading: Icon(
                                          Icons.add_circle,
                                          color: AppColors.main,
                                        ),
                                        title: Text(
                                          'New Chat',
                                          style: balooThambi2BoldExtraLarge
                                              .copyWith(fontSize: 16),
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                          _createNewSession();
                                        },
                                      );
                                    }

                                    final session = _chatBox.getAt(index - 1)!;
                                    final isCurrentSession =
                                        _currentSession?.id == session.id;

                                    return ListTile(
                                      leading: Icon(
                                        Icons.arrow_back_ios,
                                        size: 16,
                                        color:
                                            isCurrentSession
                                                ? AppColors.main
                                                : Colors.grey,
                                      ),
                                      title: Text(
                                        session.title,
                                        style: balooThambi2BoldExtraLarge
                                            .copyWith(
                                              color:
                                                  isCurrentSession
                                                      ? AppColors.main
                                                      : Colors.white,
                                              fontSize: 14,
                                              fontWeight:
                                                  isCurrentSession
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                            ),
                                      ),
                                      subtitle: Text(
                                        DateFormat(
                                          'MMM dd, yyyy - h:mm a',
                                        ).format(session.updatedAt),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              isCurrentSession
                                                  ? AppColors.main
                                                  : Colors.white,
                                        ),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                            onPressed:
                                                () => _showDeleteDialog(
                                                  context,
                                                  session,
                                                  index - 1,
                                                ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _loadSession(session);
                                      },
                                      onLongPress: () {
                                        _showDeleteDialog(
                                          context,
                                          session,
                                          index - 1,
                                        );
                                      },
                                    );
                                  },
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, ChatSession session, int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Delete Chat'),
            content: Text('Are you sure you want to delete this chat?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel', style: TextStyle(color: Colors.grey)),
              ),
              TextButton(
                onPressed: () {
                  _chatBox.deleteAt(index);
                  Navigator.pop(context);
                  if (_currentSession?.id == session.id) {
                    _createNewSession();
                  }
                },
                child: Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

  void _loadSession(ChatSession session) {
    setState(() {
      _currentSession = session;

      try {
        if (session.messagesJson != null && session.messagesJson!.isNotEmpty) {
          _messages =
              session.messagesJson!.map((json) {
                final Map<String, dynamic> jsonMap = _convertMap(json);
                return types.Message.fromJson(jsonMap);
              }).toList();
          debugPrint('Loaded ${_messages.length} messages successfully');
        } else {
          _messages = [];
          debugPrint('No messages found in session');
        }
      } catch (e) {
        debugPrint('Error deserializing messages: $e');
        _messages = [];
      }
    });
  }

  Map<String, dynamic> _convertMap(dynamic map) {
    if (map is! Map) return {};

    return map.map((key, value) {
      dynamic newValue = value;

      if (value is Map) {
        newValue = _convertMap(value);
      } else if (value is List) {
        newValue =
            value.map((item) {
              if (item is Map) {
                return _convertMap(item);
              }
              return item;
            }).toList();
      }

      return MapEntry(key.toString(), newValue);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
