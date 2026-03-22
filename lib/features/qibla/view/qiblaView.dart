import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';



/// And This Page's Last Update From Antigravity
/// And This Page's Last Update From Antigravity
/// And This Page's Last Update From Antigravity
/// And This Page's Last Update From Antigravity
/// And This Page's Last Update From Antigravity
/// And This Page's Last Update From Antigravity
/// And This Page's Last Update From Antigravity
/// And This Page's Last Update From Antigravity
/// And This Page's Last Update From Antigravity
/// And This Page's Last Update From Antigravity
/// And This Page's Last Update From Antigravity
/// And This Page's Last Update From Antigravity
/// And This Page's Last Update From Antigravity
/// And This Page's Last Update From Antigravity
/// And This Page's Last Update From Antigravity

// ─────────────────────────────────────────────
//  ENTRY POINT
// ─────────────────────────────────────────────
class QiblaView extends StatefulWidget {
  const QiblaView({super.key});

  @override
  State<QiblaView> createState() => _QiblaViewState();
}

class _QiblaViewState extends State<QiblaView> {
  late Future<LocationStatus> _locationFuture;

  @override
  void initState() {
    super.initState();
    _locationFuture = FlutterQiblah.checkLocationStatus();
  }

  void _retry() =>
      setState(() => _locationFuture = FlutterQiblah.checkLocationStatus());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A1628),
        body: FutureBuilder<LocationStatus>(
          future: _locationFuture,
          builder: (ctx, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const _LoadingView(msg: 'جاري التحقق من الموقع...');
            }
            final status = snap.data;
            final granted = status != null &&
                status.enabled &&
                (status.status == LocationPermission.always ||
                    status.status == LocationPermission.whileInUse);

            if (!granted) {
              return _PermissionView(onRetry: _retry, status: status);
            }
            return const _CompassScreen();
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  LOADING
// ─────────────────────────────────────────────
class _LoadingView extends StatelessWidget {
  final String msg;
  const _LoadingView({required this.msg});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const CircularProgressIndicator(color: Color(0xFF4ECDC4)),
          const SizedBox(height: 16),
          Text(msg, style: const TextStyle(color: Colors.white70, fontSize: 15)),
        ]),
      );
}

// ─────────────────────────────────────────────
//  PERMISSION SCREEN
// ─────────────────────────────────────────────
class _PermissionView extends StatelessWidget {
  final VoidCallback onRetry;
  final LocationStatus? status;
  const _PermissionView({required this.onRetry, this.status});

  @override
  Widget build(BuildContext context) {
    final denied =
        status?.status == LocationPermission.deniedForever || status?.enabled == false;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF4ECDC4), width: 2),
              color: const Color(0xFF0F2240),
            ),
            child: const Icon(Icons.location_off_rounded,
                size: 44, color: Color(0xFF4ECDC4)),
          ),
          const SizedBox(height: 24),
          const Text('الموقع مطلوب',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(
            denied
                ? 'قم بتفعيل إذن الموقع من إعدادات التطبيق'
                : 'يحتاج التطبيق إذن الموقع لتحديد اتجاه القبلة',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white54, fontSize: 14, height: 1.6),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () async {
                if (denied) {
                  await Geolocator.openLocationSettings();
                } else {
                  await Geolocator.requestPermission();
                }
                onRetry();
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('السماح بالوصول',
                  style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4ECDC4),
                foregroundColor: const Color(0xFF0A1628),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  MAIN COMPASS SCREEN
// ─────────────────────────────────────────────
class _CompassScreen extends StatelessWidget {
  const _CompassScreen();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QiblahDirection>(
      stream: FlutterQiblah.qiblahStream,
      builder: (ctx, snap) {
        if (!snap.hasData) {
          return const _LoadingView(msg: 'جاري تحميل البوصلة...');
        }
        if (snap.hasError) {
          return Center(
              child: Text('خطأ: ${snap.error}',
                  style: const TextStyle(color: Colors.red)));
        }

        final q = snap.data!;

        // ┌──────────────────────────────────────────────────────────┐
        // │  CORRECT COMPASS LOGIC (STATIC BACKGROUND)               │
        // ├──────────────────────────────────────────────────────────┤
        // │ 1. Compass Rose: STATIC (User sees N/S/E/W in fixed pos) │
        // │ 2. Needle: Rotates by -direction (Points to North)       │
        // │ 3. Qibla Marker: Rotates by qiblah-direction             │
        // └──────────────────────────────────────────────────────────┘

        double diff = ((q.qiblah - q.direction) % 360 + 360) % 360;
        if (diff > 180) diff -= 360; // now in -180..+180

        final bool aligned = diff.abs() <= 5;

        // Angles in Radians
        final double northAngle = (-q.direction) * (math.pi / 180);
        final double qiblaAngle = (q.qiblah - q.direction) * (math.pi / 180);

        // Debug prints to console
        debugPrint('Qibla Update: Heading: ${q.direction.toStringAsFixed(1)}°, Qiblah: ${q.qiblah.toStringAsFixed(1)}°, Diff: ${diff.toStringAsFixed(1)}°');

        return SafeArea(
          child: Column(
            children: [
              _AppBar(aligned: aligned),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      _InstructionCard(aligned: aligned, diff: diff),
                      const SizedBox(height: 28),

                      // ── COMPASS STACK ──
                      _CompassWidget(
                        northAngle: northAngle,
                        qiblaAngle: qiblaAngle,
                        aligned: aligned,
                      ),

                      const SizedBox(height: 24),
                      if (!aligned)
                        _TurnGuide(diff: diff)
                      else
                        _AlignedBadge(),

                      const SizedBox(height: 24),
                      _StatsBar(q: q),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
//  APP BAR
// ─────────────────────────────────────────────
class _AppBar extends StatelessWidget {
  final bool aligned;
  const _AppBar({required this.aligned});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 16, 0),
      child: Row(children: [
        IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white70, size: 20),
        ),
        const Expanded(
          child: Text(
            '🕋  Qibla Finder',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: aligned ? const Color(0xFF4ECDC4) : Colors.white24,
            boxShadow: aligned
                ? [
                    BoxShadow(
                        color: const Color(0xFF4ECDC4).withOpacity(0.8),
                        blurRadius: 10)
                  ]
                : [],
          ),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────
//  INSTRUCTION CARD
// ─────────────────────────────────────────────
class _InstructionCard extends StatelessWidget {
  final bool aligned;
  final double diff;

  const _InstructionCard({required this.aligned, required this.diff});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: aligned
              ? [const Color(0xFF1B5E4F), const Color(0xFF0F3D33)]
              : [const Color(0xFF1A2744), const Color(0xFF0F1E38)],
        ),
        border: Border.all(
          color: aligned
              ? const Color(0xFF4ECDC4).withOpacity(0.6)
              : Colors.white12,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(
              aligned ? Icons.check_circle : Icons.info_outline_rounded,
              color: aligned ? const Color(0xFF4ECDC4) : const Color(0xFFFFD700),
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              aligned ? 'أنت تواجه القبلة الآن!' : 'كيف تجد القبلة؟',
              style: TextStyle(
                color: aligned ? const Color(0xFF4ECDC4) : const Color(0xFFFFD700),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ]),
          const SizedBox(height: 8),
          Text(
            aligned
                ? '✅ ثبّت الهاتف — أنت الآن تواجه الكعبة المشرفة.'
                : '📱 أمسك الهاتف بشكل أفقي (موازي للأرض).\n'
                    '🔄 دوّر جسمك ببطء ${diff > 0 ? "نحو اليمين ◀" : "نحو اليسار ▶"} حتى يتوجه سهم الكعبة للأعلى.',
            style: const TextStyle(
                color: Colors.white70, fontSize: 13, height: 1.7),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  COMPASS WIDGET
// ─────────────────────────────────────────────
class _CompassWidget extends StatelessWidget {
  final double northAngle;
  final double qiblaAngle;
  final bool aligned;

  const _CompassWidget({
    required this.northAngle,
    required this.qiblaAngle,
    required this.aligned,
  });

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width * 0.76;

    return Stack(
      alignment: Alignment.center,
      children: [
        // ── 1. STATIC BACKGROUND ──
        SvgPicture.asset(
          'assets/compass.svg',
          width: size,
          height: size,
        ),

        // ── 2. NORTH NEEDLE ──
        // This needle points at the Magnetic North
        Transform.rotate(
          angle: northAngle,
          child: SvgPicture.asset(
            'assets/needle.svg',
            width: size * 0.6,
            height: size * 0.6,
            fit: BoxFit.contain,
          ),
        ),

        // ── 3. QIBLA MARKER (KAABA) ──
        // This rotates independently to point at Qibla
        Transform.rotate(
          angle: qiblaAngle,
          child: Transform.translate(
            offset: Offset(0, -(size * 0.4)), // Position at edge of compass
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedScale(
                  scale: aligned ? 1.4 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: Image.asset(
                    'assets/qibla/qiblaKaaba.png',
                    width: 44,
                    height: 44,
                  ),
                ),
                if (aligned)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4ECDC4),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('QIBLA', 
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10)),
                  ),
              ],
            ),
          ),
        ),

        // ── 4. CENTER HUB ──
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 1)
            ]
          ),
        ),

        // ── 5. TOP TARGET (FIXED) ──
        Positioned(
          top: 0,
          child: Container(
            width: 4,
            height: 20,
            color: aligned ? const Color(0xFF4ECDC4) : Colors.white24,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  OTHER WIDGETS
// ─────────────────────────────────────────────

class _TurnGuide extends StatelessWidget {
  final double diff;
  const _TurnGuide({required this.diff});

  @override
  Widget build(BuildContext context) {
    final bool right = diff > 0;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xFF0F2240),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_back_ios_rounded, color: right ? Colors.white10 : const Color(0xFF4ECDC4)),
          const SizedBox(width: 16),
          Column(
            children: [
              Text(
                'توجه ${right ? "يميناً" : "يساراً"}',
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'تبقى ${diff.abs().round()}° درجة',
                style: const TextStyle(color: Color(0xFF4ECDC4), fontSize: 14),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Icon(Icons.arrow_forward_ios_rounded, color: right ? const Color(0xFF4ECDC4) : Colors.white10),
        ],
      ),
    );
  }
}

class _AlignedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xFF1B5E4F),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, color: Color(0xFF4ECDC4), size: 32),
          SizedBox(width: 12),
          Text('أنت تواجه القبلة الآن!',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _StatsBar extends StatelessWidget {
  final QiblahDirection q;
  const _StatsBar({required this.q});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xFF0F2240),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _Stat(label: 'Heading', val: '${q.direction.round()}°'),
          _Stat(label: 'Qiblah', val: '${q.qiblah.round()}°'),
          _Stat(label: 'Offset', val: '${q.offset.round()}°'),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label, val;
  const _Stat({required this.label, required this.val});
  @override
  Widget build(BuildContext context) => Column(children: [
        Text(val, style: const TextStyle(color: Color(0xFF4ECDC4), fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 12)),
      ]);
}

typedef qiblaView = QiblaView;