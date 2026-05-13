import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../../../core_import.dart';

@RoutePage()
class GuestPage extends StatefulWidget {
  final String userId;

  const GuestPage({super.key, required this.userId});

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
  final GlobalKey _qrKey = GlobalKey();

  Future<void> _shareQrImage(String qrToken) async {
    try {
      // Capture the QR widget as image
      final RenderRepaintBoundary boundary =
          _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData == null) return;

      final Uint8List pngBytes = byteData.buffer.asUint8List();

      // Save to temp file
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/gift_qr.png');
      await file.writeAsBytes(pngBytes);

      // Share the image file
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Here is my Gift QR Code! Scan this to redeem the gift.',
        subject: 'Gift QR Code',
      );
    } catch (e) {
      debugPrint('Share error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GiftBloc>()..add(GetGiftEvent(widget.userId)),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<GiftBloc, GiftState>(
            builder: (context, state) {
              if (state is GiftLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GiftLoaded) {
                final gift = state.gift;

                return Column(
                  children: [
                    //--------------------------------
                    // HEADER
                    //--------------------------------
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            child: Icon(Icons.person),
                          ),

                          const Text('Guest Gift'),

                          CircleAvatar(
                            radius: 24,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.logout),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(gift.eventName),

                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: gift.status == 'locked'
                            ? Colors.orange
                            : gift.status == 'unlocked'
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(gift.status.toUpperCase()),
                    ),

                    const SizedBox(height: 40),

                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: gift.status == 'redeemed'
                              ? Colors.red
                              : Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: gift.status == 'locked'
                          ? Scratcher(
                              brushSize: 50,
                              threshold: 50,
                              color: Colors.blue,
                              onThreshold: () {
                                context.read<GiftBloc>().add(
                                  UnlockGiftEvent(
                                    gift.giftId,
                                    widget.userId,
                                  ), // pass userId
                                );
                              },
                              child: const Center(child: Text('Scratch Here')),
                            )
                          : gift.status == 'unlocked'
                          ? RepaintBoundary(
                              key: _qrKey,
                              child: Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(16),
                                child: PrettyQrView.data(data: gift.qrToken),
                              ),
                            )
                          : const Center(
                              child: Icon(
                                Icons.error,
                                size: 100,
                                color: Colors.red,
                              ),
                            ),
                    ),

                    const SizedBox(height: 30),

                    //--------------------------------
                    // TEXTS
                    //--------------------------------
                    if (gift.status == 'locked') ...[
                      const Text('A Special Gift Awaits You'),
                      const SizedBox(height: 10),
                      const Text('Scratch the card to Unlock Your QRCode'),
                    ],

                    if (gift.status == 'unlocked') ...[
                      const Text('Share your gifts with QR Code'),
                      const SizedBox(height: 10),
                      const Text('Enjoy Your Gift with happily'),
                    ],

                    if (gift.status == 'redeemed') ...[
                      const Text('Your Reward Already Redeemed'),
                    ],

                    const SizedBox(height: 30),

                    //--------------------------------
                    // SHARE BUTTON
                    //--------------------------------
                    if (gift.status == 'unlocked')
                      CircleAvatar(
                        radius: 30,
                        child: IconButton(
                          onPressed: () => _shareQrImage(gift.qrToken),
                          icon: const Icon(Icons.share),
                        ),
                      ),
                  ],
                );
              }

              if (state is GiftError) {
                return Center(child: Text(state.message));
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
