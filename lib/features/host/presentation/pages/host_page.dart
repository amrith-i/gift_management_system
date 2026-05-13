import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../core_import.dart';

@RoutePage()
class HostPage extends StatefulWidget {
  const HostPage({super.key});

  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  String? _scannedToken;
  bool _scanned = false;
  bool _isRedeemed = false; // track if already redeemed
  final MobileScannerController _scannerController = MobileScannerController();

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  void _resetScanner() {
    setState(() {
      _scannedToken = null;
      _scanned = false;
      _isRedeemed = false;
    });
    _scannerController.start();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GiftBloc>(),
      child: BlocListener<GiftBloc, GiftState>(
        listener: (context, state) {
          if (state is GiftLoaded) {
            // ✅ Status check came back after scanning
            if (state.gift.status == 'redeemed') {
              // Mark as redeemed so UI hides redeem button
              setState(() {
                _isRedeemed = true;
              });

              // Show error dialog immediately — don't show success at all
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.cancel, color: Colors.red, size: 80),
                      const SizedBox(height: 16),
                      const Text(
                        'Already Redeemed!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'This gift has already been redeemed.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _resetScanner();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Scan Again',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // ✅ Successfully redeemed just now via RedeemGiftEvent
            if (state.gift.status == 'redeemed' && !_isRedeemed) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 80,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Gift Redeemed!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'This gift has been successfully redeemed.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _resetScanner();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Done',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }

          if (state is GiftError) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cancel, color: Colors.red, size: 80),
                    const SizedBox(height: 16),
                    const Text(
                      'Error!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _resetScanner();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          'Scan Again',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
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
                        child: Icon(Icons.qr_code_scanner),
                      ),
                      const Text('Host Scanner'),
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

                //--------------------------------
                // SCANNER
                //--------------------------------
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _scanned
                                  ? (_isRedeemed ? Colors.red : Colors.green)
                                  : Colors.blue,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(17),
                            child: _scanned
                                ? Center(
                                    child: Icon(
                                      _isRedeemed
                                          ? Icons.cancel
                                          : Icons.qr_code,
                                      size: 80,
                                      color: _isRedeemed
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                  )
                                : MobileScanner(
                                    controller: _scannerController,
                                    onDetect: (capture) {
                                      if (_scanned) return;
                                      final token =
                                          capture.barcodes.first.rawValue;
                                      if (token != null) {
                                        setState(() {
                                          _scannedToken = token;
                                          _scanned = true;
                                        });
                                        _scannerController.stop();

                                        // ✅ Check status immediately on scan
                                        // This fires BEFORE showing any UI
                                        context.read<GiftBloc>().add(
                                          CheckGiftStatusEvent(token),
                                        );
                                      }
                                    },
                                  ),
                          ),
                        ),

                        if (!_scanned) ...[
                          Positioned(top: 20, left: 20, child: _cornerWidget()),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Transform.rotate(
                              angle: 1.5708,
                              child: _cornerWidget(),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Transform.rotate(
                              angle: -1.5708,
                              child: _cornerWidget(),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            right: 20,
                            child: Transform.rotate(
                              angle: 3.1416,
                              child: _cornerWidget(),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                //--------------------------------
                // BOTTOM SECTION
                //--------------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: BlocBuilder<GiftBloc, GiftState>(
                    builder: (context, state) {
                      // Checking status after scan
                      if (_scanned && state is GiftLoading) {
                        return const CircularProgressIndicator();
                      }

                      // ✅ Already redeemed — show error banner, NO redeem button
                      if (_scanned &&
                          state is GiftLoaded &&
                          state.gift.status == 'redeemed') {
                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.red.shade200),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'This gift has already been redeemed.',
                                      style: TextStyle(
                                        color: Colors.red.shade800,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextButton(
                              onPressed: _resetScanner,
                              child: const Text('Scan a different QR'),
                            ),
                          ],
                        );
                      }

                      // ✅ Valid and unlocked — show redeem button
                      if (_scanned &&
                          state is GiftLoaded &&
                          state.gift.status == 'unlocked') {
                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.green.shade200,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'QR Scanned — Ready to redeem',
                                      style: TextStyle(
                                        color: Colors.green.shade800,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<GiftBloc>().add(
                                    RedeemGiftEvent(
                                      qrToken: _scannedToken!,
                                      redeemedBy: "HOST001",
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: const Text(
                                  'Redeem Gift',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: _resetScanner,
                              child: const Text('Scan a different QR'),
                            ),
                          ],
                        );
                      }

                      // Default — waiting to scan
                      return const Text(
                        'Point the camera at a guest\'s QR code',
                        style: TextStyle(color: Colors.grey),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cornerWidget() {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white, width: 3),
          left: BorderSide(color: Colors.white, width: 3),
        ),
      ),
    );
  }
}
