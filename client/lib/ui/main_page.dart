import 'package:client/data/functions/open_url.dart';
import 'package:client/data/functions/verify_signature.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/data/services/grpc_service.dart';
import 'package:client/data/ui_services/user_service.dart';
import 'package:client/domain/src/phonebook.pb.dart';
import 'package:client/ui/custom.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}
/// MainPage with all the widgets
class _MainPageState extends ConsumerState<MainPage> {
  TextEditingController controller = TextEditingController();

    final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    textController.text = ref.read(grpcServiceProvider).baseUrl;
  }

  @override
  Widget build(BuildContext context) {
    // provider to interact with gRPC and liten changes
    final grpc = ref.watch(grpcServiceProvider);
    // provider to store user data
    final user = ref.watch(userProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:16.0),
            child: Stack(
              children: [
                // top bar with ip and status
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "ip:",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            " ${grpc.baseUrl}"
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("status:", style: TextStyle(fontWeight: FontWeight.w500)),
                                                      Text(
                            " ${grpc.isConnected ? "connected" : "disconnected"}",
                            style: TextStyle(
                              color: grpc.isConnected ? green : Colors.red,
                            ),
                          ),
                                  
                        ],
                      ),
                    ],
                  ),
                ),
                // settings to change ip
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                          icon: Icon(Icons.settings, color: black),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    backgroundColor: white,
                                    title: Text("Change IP address", style: TextStyle(fontWeight: FontWeight.bold),),
                                    content:   Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: TextField(
                                                                    cursorColor: green,
                                                                    controller: textController,
                                                                    decoration: InputDecoration(
                                                                      focusColor: green,
                                                                      labelStyle: TextStyle(color: black, fontWeight: FontWeight.w500),
                                      
                                                                      labelText: 'IP Address',
                                                                      hintText: 'xxx.xxx.xxx.xxx',
                                                                      hintStyle: TextStyle(color: grey),
                                                                      border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide(color: green),
                                                                      ),
                                                                    ),
                                                                  ),
                                    ),
                                    
          
                                    actions: [
                                   
                                         TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        ref.watch(grpcServiceProvider).baseUrl =
                                            textController.text;
                                        controller.clear();
                                        user.clear();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Apply",
                                        style: TextStyle(color: green),
                                      ),
                                    ),
                                   
                                    ],
                                  ),
                            );
                          },
                        ),
                ),
                // search bar and search button
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Enter full name:",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15)),
                    TextField(
                      cursorColor: green,
                      controller: controller,
                      decoration: InputDecoration(
                        focusColor: green,
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.clear();
                            user.clear();
                          },
                          icon: Icon(Icons.clear),
                        ),
                        hintText: 'Darko Bozhinoski',
                        hintStyle: TextStyle(color: grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: green),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15)),
          
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(green),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        final response = await grpc
                            .phonebookService
                            .phonebookServiceClient
                            .getNumberByName(NameRequest(name: controller.text));
                        user.addUser(response);
                        user.verify(
                          verifySignature(
                            response.name,
                            response.number,
                            response.found,
                            response.signature,
                          ),
                        );
                        if (!user.isExist) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error! The user is not found.'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                'assets/icons/inno_logo_white.png',
                              ),
                              width: 15,
                              height: 15,
                            ),
                            Padding(padding: EdgeInsets.only(left: 15)),
                            Text(
                              "Find",
                              style: TextStyle(fontSize: 20, color: white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 25)),
                    // appears when user is found
                    if (user.isExist) ...[
                      Container(
                        decoration: BoxDecoration(
                          color: lightGrey,
                          border: Border.all(color: grey, width: 1),
          
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Text(
                              user.name,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 15)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SelectableText(
                                  user.phone,
                                  style: TextStyle(fontSize: 20),
                                ),
                                Padding(padding: EdgeInsets.only(left: 15)),
                                IconButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(text: user.phone),
                                    );
          
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Text is copied!'),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.copy, color: black),
                                ),
                                Padding(padding: EdgeInsets.only(left: 15)),
          
                                InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    openUrl(
                                      'https://t.me/${user.phone.substring(1)}',
                                    );
                                  },
                                  child: Image(
                                    image: AssetImage(
                                      'assets/icons/telegram.png',
                                    ),
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user.isVerified ? "✅" : "❌",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Padding(padding: EdgeInsets.only(left: 5)),
                                Text(
                                  user.isVerified
                                      ? "Verified by a server "
                                      : "Not verified by a server",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
