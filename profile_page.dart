import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../auth/login_page.dart';
import '../profile/profile_settings_page.dart';
import '../vip/vip_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController _scrollController = ScrollController();
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // 初始设置状态栏为亮色
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final scrollPosition = _scrollController.position.pixels;
    final threshold = 60.0;
    
    if (scrollPosition <= threshold) {
      final newOpacity = 1.0 - (scrollPosition / threshold);
      if (newOpacity != _opacity) {
        setState(() {
          _opacity = newOpacity.clamp(0.0, 1.0);
        });
        // 根据滚动位置切换状态栏样式
        if (newOpacity > 0.5) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
        } else {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        }
      }
    } else if (_opacity != 0.0) {
      setState(() {
        _opacity = 0.0;
      });
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
  }

  Widget _buildVipCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          VipPage.route(),
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        height: 100,
        width: double.infinity,
        child: Stack(
          children: [
            // 底部VIP背景
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/image/vip.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // 上层矩形图片
            Positioned(
              top: 35,
              left: -16,
              right: -16,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/image/juxin.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      children: [
                        const Text(
                          '我的会员权益 4/4',
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            // TODO: 处理领取记录点击事件
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '领取记录',
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Color(0xFF333333),
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // 左上角图标
            Positioned(
              top: -10,
              left: 8,
              child: Image.asset(
                'assets/images/image/cips.png',
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
            ),
            // 顶部装饰图片
            Positioned(
              top: 2,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/image/zs1.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 12),
                  Image.asset(
                    'assets/images/image/zs2.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 12),
                  Image.asset(
                    'assets/images/image/zs3.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            // 续费按钮
            Positioned(
              top: 4,
              right: 6,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    VipPage.route(),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '立即开通',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivilegeSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildPrivilegeItem(Icons.card_giftcard, '月享礼券'),
          _buildPrivilegeItem(Icons.cake, '生日福利'),
          _buildPrivilegeItem(Icons.support_agent, '专属客服'),
          _buildPrivilegeItem(Icons.discount, '专属折扣'),
        ],
      ),
    );
  }

  Widget _buildPrivilegeItem(IconData icon, String label) {
    return SizedBox(
      width: 65,
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 24,
              color: const Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF333333),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildToolsSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '必备工具',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          // 第一行按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildToolButton('活动中心', Icons.celebration),
              _buildToolButton('邀请好友', Icons.person_add),
              _buildToolButton('卡包', Icons.credit_card),
              _buildToolButton('聊天室', Icons.chat),
            ],
          ),
          const SizedBox(height: 12),
          // 第二行按钮
          Row(
            children: [
              _buildToolButton('月度报表', Icons.bar_chart),
              const SizedBox(width: 12),
              _buildToolButton('用户等级', Icons.stars),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton(String label, IconData icon) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: const Color(0xFF666666),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<AppTheme>().primaryColor;
    final screenWidth = MediaQuery.of(context).size.width;
    final headerHeight = MediaQuery.of(context).size.height * 0.25;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 背景容器
          Container(
            height: headerHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.7, 1.0],
                colors: [
                  Color.lerp(Colors.white, themeColor, _opacity) ?? Colors.white,
                  Color.lerp(Colors.white, themeColor, _opacity) ?? Colors.white,
                  Colors.white,
                ],
              ),
            ),
          ),
          // 内容区域
          SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 44), // 为顶部栏预留空间
                  // 移除原有的返回按钮
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // 头像和信息区域
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // 头像
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfileSettingsPage(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/default_avatar.png',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.person,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // 昵称和会员信息
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const LoginPage(),
                                              ),
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.white.withOpacity(0.2),
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            minimumSize: Size.zero,
                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          ),
                                          child: const Text(
                                            '点击登录',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        // 会员信息
                                        const Text(
                                          '恭喜你，你已经是我们的至尊会员',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFED9A4),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Text(
                                          '分享码',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: const Offset(0, -8),
                                        child: IconButton(
                                          onPressed: () {
                                            // TODO: 处理二维码点击事件
                                          },
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          iconSize: 24,
                                          icon: const Icon(
                                            Icons.qr_code_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // 会员卡片
                  _buildVipCard(),
                  _buildPrivilegeSection(),
                  _buildToolsSection(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '我的频道',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // 第一行按钮
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildToolButton('我的账户', Icons.account_circle),
                            _buildToolButton('我的主页', Icons.home),
                            _buildToolButton('我的勋章', Icons.military_tech),
                            _buildToolButton('我的推广', Icons.share),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // 第二行按钮
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildToolButton('我的收藏', Icons.favorite),
                            _buildToolButton('我的评论', Icons.comment),
                            _buildToolButton('我的关注', Icons.group),
                            _buildToolButton('我的粉丝', Icons.people),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // 第三行按钮
                        Row(
                          children: [
                            _buildToolButton('我的点赞', Icons.thumb_up),
                            const SizedBox(width: 12),
                            _buildToolButton('小黑屋', Icons.block),
                            const SizedBox(width: 12),
                            _buildToolButton('黑名单', Icons.person_off),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '排行榜',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildToolButton('粉丝排行', Icons.people_outline),
                            _buildToolButton('等级排行', Icons.military_tech_outlined),
                            _buildToolButton('分享排行', Icons.share_outlined),
                            _buildToolButton('礼物排行', Icons.card_giftcard_outlined),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '平台设置',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // 第一行按钮
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildToolButton('站内信', Icons.mail_outline),
                            _buildToolButton('联系客服', Icons.support_agent_outlined),
                            _buildToolButton('关于我们', Icons.info_outline),
                            _buildToolButton('意见反馈', Icons.feedback_outlined),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // 第二行按钮
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildToolButton('清除缓存', Icons.cleaning_services_outlined),
                            _buildToolButton('下载APP', Icons.download_outlined),
                            _buildToolButton('举报记录', Icons.report_outlined),
                            _buildToolButton('切换平台', Icons.swap_horiz_outlined),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // 底部留白
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          // 固定的顶部栏
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              decoration: BoxDecoration(
                color: Color.lerp(Colors.transparent, themeColor, 1.0 - _opacity),
              ),
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // 返回按钮
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          '个人中心',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    // 为了保持对称，添加一个占位的 SizedBox
                    const SizedBox(width: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 