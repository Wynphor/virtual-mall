CREATE DATABASE IF NOT EXISTS virtual_mall DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE virtual_mall;

-- ============================
-- 建表
-- ============================
CREATE TABLE IF NOT EXISTS `user` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `password` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100) DEFAULT NULL,
    `phone` VARCHAR(20) DEFAULT NULL,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `status` TINYINT DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `admin` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `password` VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `category` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `parent_id` INT DEFAULT 0,
    `sort_order` INT DEFAULT 0,
    `status` TINYINT DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `product` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(200) NOT NULL,
    `category_id` INT NOT NULL,
    `description` TEXT,
    `image` VARCHAR(255) DEFAULT NULL,
    `price` DECIMAL(10,2) NOT NULL,
    `sales` INT DEFAULT 0,
    `status` TINYINT DEFAULT 1,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_category (`category_id`),
    INDEX idx_status (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `product_sku` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `product_id` INT NOT NULL,
    `spec_name` VARCHAR(100) NOT NULL,
    `price` DECIMAL(10,2) NOT NULL,
    `stock` INT DEFAULT 0,
    `status` TINYINT DEFAULT 1,
    INDEX idx_product (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `mall_order` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `order_no` VARCHAR(32) NOT NULL UNIQUE,
    `user_id` INT DEFAULT NULL,
    `contact` VARCHAR(100) NOT NULL,
    `query_password` VARCHAR(100) DEFAULT NULL,
    `pay_method` VARCHAR(20) DEFAULT NULL,
    `total_price` DECIMAL(10,2) NOT NULL,
    `status` TINYINT DEFAULT 0,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `pay_time` DATETIME DEFAULT NULL,
    INDEX idx_user (`user_id`),
    INDEX idx_contact (`contact`),
    INDEX idx_status (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `order_item` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `sku_id` INT NOT NULL,
    `product_name` VARCHAR(200) NOT NULL,
    `spec_name` VARCHAR(100) NOT NULL,
    `price` DECIMAL(10,2) NOT NULL,
    `quantity` INT NOT NULL,
    INDEX idx_order (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `card_key` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `sku_id` INT NOT NULL,
    `content` TEXT NOT NULL,
    `status` TINYINT DEFAULT 0,
    `order_item_id` INT DEFAULT NULL,
    `add_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `sell_time` DATETIME DEFAULT NULL,
    INDEX idx_sku (`sku_id`),
    INDEX idx_status (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================
-- 管理员 & 用户
-- ============================
INSERT INTO `admin` (`username`, `password`) VALUES ('admin', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `user` (`username`, `password`, `email`, `phone`) VALUES
('testuser',   'e10adc3949ba59abbe56e057f20f883e', 'test@example.com',        '13800138000'),
('挽枫',       '6b8bde7d2a96c47cc8d26f363a63c9e4', 'maple_leaf@qq.com',       '13900139001'),
('薛梦凝',     '13b94bf5f44e1b204f0183f1b03aaba7', 'frost_dream@163.com',     '15800158002'),
('郑小rua',    '6bd9bd66cbc7bce35a0a61bae592795a', 'rua_cute@gmail.com',     '17700177003'),
('Wind',       'c6441e15f38cd5b6b39a9481d30ba727', 'breeze@outlook.com',     '18600186004'),
('xiaohong',   'efc064d0e61259bf69583f6e97708aa2', 'xiaohong@outlook.com',    NULL);

-- ============================
-- 一级分类（6大类）
-- ============================
INSERT INTO `category` (`id`, `name`, `parent_id`, `sort_order`) VALUES
(1, 'AI服务与账号',  0, 1),
(2, 'API与网络',     0, 2),
(3, '账号与会员',    0, 3),
(4, '课设与毕设',    0, 4),
(5, '知识付费',      0, 5),
(6, '工具与充值',    0, 6);

-- ============================
-- 二级分类（18个）
-- ============================
INSERT INTO `category` (`id`, `name`, `parent_id`, `sort_order`) VALUES
-- AI服务与账号
(101, 'ChatGPT / Claude',   1, 1),
(102, '国产AI / 其他AI',    1, 2),
(103, 'AI绘画 / 音乐 / 视频', 1, 3),
(104, 'AI编程助手',          1, 4),
-- API与网络
(201, 'API中转额度',         2, 1),
(202, 'SDK充值卡',           2, 2),
(203, '机场 / 加速器',       2, 3),
-- 账号与会员
(301, '邮箱 / Apple ID',     3, 1),
(302, '社交平台账号',        3, 2),
(303, '流媒体会员',          3, 3),
(304, '游戏平台',            3, 4),
(305, '办公与开发工具',      3, 5),
-- 课设与毕设
(401, 'SSM / SpringBoot 项目', 4, 1),
(402, 'Python / 前端 / 小程序', 4, 2),
(403, '比赛项目 / 大作业',   4, 3),
-- 知识付费
(501, 'AI编程工具教程',      5, 1),
(502, 'Skills / Prompt / 课程', 5, 2),
-- 工具与充值
(601, '一键部署包',          6, 1),
(602, '注册机 / 0刀卡 / 脚本', 6, 2),
(603, '区块链 / 虚拟币',     6, 3);

-- ============================
-- 商品（64个）
-- ============================
INSERT INTO `product` (`id`, `name`, `category_id`, `description`, `price`, `sales`, `status`) VALUES

-- ========== 1. AI服务与账号 ==========
(1, 'ChatGPT Free 成品号', 101,
     'OpenAI注册完成的成品账号，已过邮箱验证，可直接登录使用免费版GPT-3.5。日抛/月抛可选，适合批量使用或临时需求。',
     0.50, 15200, 1),
(2, 'ChatGPT Plus 成品号', 101,
     '已订阅Plus的ChatGPT成品号，支持GPT-4o、GPT-4、DALL·E、高级数据分析、联网搜索。日抛/月抛/季卡/年卡，土区/阿区低价开通。',
     8.00, 12800, 1),
(3, 'ChatGPT Pro 成品号', 101,
     '已订阅Pro的ChatGPT成品号，支持o1/o1-mini/o3/o4-mini等推理模型，无限制GPT-4o。月抛/季卡可选。',
     188.00, 3600, 1),
(4, 'Claude Free 成品号', 101,
     'Anthropic注册完成的Claude成品号，支持Claude 3.5 Haiku免费使用。日抛/月抛可选。',
     1.00, 8200, 1),
(5, 'Claude Pro 成品号', 101,
     '已订阅Pro的Claude成品号，支持Claude 3.5 Sonnet/Opus，5倍用量，200K上下文。月抛/季卡/年卡可选。',
     88.00, 5600, 1),
(6, 'Claude Max 成品号', 101,
     '已订阅Max的Claude成品号，全部模型最高用量。月抛/季卡可选。',
     288.00, 1200, 1),
(7, 'DeepSeek 成品号', 102,
     'DeepSeek深度求索成品号，支持V3/Chat/R1推理模型。国产之光，中文能力极强。日抛/月抛可选。',
     2.00, 9800, 1),
(8, 'Kimi (月之暗面) 成品号', 102,
     'Kimi智能助手成品号，支持200万字长上下文、联网搜索、文件分析。日抛/月抛可选。',
     3.00, 6400, 1),
(9, 'Gemini Advanced 成品号', 102,
     'Google Gemini Advanced成品号，支持Gemini 2.5 Pro/Flash，200万上下文。月抛/季卡可选。',
     18.00, 2800, 1),
(10, 'Midjourney 成品号', 103,
     'Midjourney成品号，支持V6.1模型、图生图、风格混合。AI绘画领域天花板。',
     35.00, 3200, 1),
(11, 'Stable Diffusion 云端部署', 103,
     'SD WebUI云端部署账号，预装SDXL/Flux模型。开箱即用，无需本地GPU。',
     15.00, 2400, 1),
(12, 'Suno AI 音乐生成', 103,
     'Suno AI音乐生成成品号，V4模型，每天50首完整歌曲。月抛/年卡可选。',
     18.00, 1800, 1),
(13, 'Runway Gen-3 视频生成', 103,
     'Runway Gen-3 Alpha视频生成成品号，文字转视频、图片转视频。',
     35.00, 1200, 1),
(14, 'Cursor Pro 成品号', 104,
     'Cursor Pro AI IDE成品号，GPT-4/Claude驱动代码补全、Composer多文件编辑。月抛/年卡可选。',
     28.00, 4800, 1),
(15, 'Windsurf Pro 成品号', 104,
     'Windsurf Pro成品号，Cascade多步骤Agent编程、全仓库理解。月抛可选。',
     22.00, 2600, 1),

-- ========== 2. API与网络 ==========
(16, 'OpenAI兼容 API 中转额度', 201,
     '支持GPT-4o/o1/Claude/Gemini/DeepSeek等主流模型，按Token计费，无需翻墙，低延迟高可用。',
     5.00, 18600, 1),
(17, 'Claude API 中转额度', 201,
     'Claude API中转服务，支持Claude 3.5全系列模型。高并发低延迟。',
     8.00, 8200, 1),
(18, 'DeepSeek API 额度', 201,
     'DeepSeek官方API中转额度，支持V3/Chat/Coder。国产模型性价比之王。',
     3.00, 6800, 1),
(19, 'OpenAI SDK 充值卡', 202,
     'OpenAI官方API预付费充值卡，$5/$10/$50/$100面额可选。',
     38.00, 5200, 1),
(20, 'Anthropic API 充值卡', 202,
     'Anthropic官方API预付费充值卡，$5/$10/$25/$50面额可选。',
     40.00, 3200, 1),
(21, '机场订阅 月卡', 203,
     '高速稳定机场节点，IPLC专线，Netflix/HBO/Disney+全解锁，不限速不限设备。支持Clash/V2Ray/Shadowrocket。',
     15.00, 12000, 1),
(22, '机场订阅 年卡', 203,
     '机场年卡订阅，性价比最高。IPLC专线，全解锁，不限流量。',
     128.00, 4800, 1),
(23, '机场流量包', 203,
     '机场额外流量加油包，100GB/500GB可选。即买即充，长期有效。',
     10.00, 8600, 1),
(24, '国内游戏加速器', 203,
     'Steam/Epic/EA游戏加速，UU/迅游/雷神等主流品牌。月卡/季卡/年卡。',
     8.00, 6400, 1),

-- ========== 3. 账号与会员 ==========
(25, 'Gmail 邮箱号', 301,
     'Google Gmail成品号，已验证手机号，可正常使用Google全套服务。单个/10个打包/100个打包。',
     1.50, 22000, 1),
(26, 'Outlook/Hotmail 邮箱号', 301,
     'Microsoft Outlook/Hotmail成品号，可正常使用Office Online、OneDrive等。',
     0.80, 12000, 1),
(27, 'ProtonMail 邮箱号', 301,
     'ProtonMail加密邮箱成品号，端到端加密，瑞士隐私保护。',
     2.00, 4200, 1),
(28, 'Apple ID 成品号', 301,
     'Apple ID成品号，港区/美区/土区/日区可选，可登录App Store、iCloud等全套服务。',
     3.00, 7800, 1),
(29, 'Twitter/X 账号', 302,
     'Twitter/X成品号，已验证邮箱。新号/老号/10个打包可选。',
     2.00, 5600, 1),
(30, 'Telegram 账号', 302,
     'Telegram成品号，已验证手机号。普通号/带Premium月卡可选。',
     5.00, 3400, 1),
(31, 'Netflix Premium 会员', 303,
     'Netflix高级会员，4K UHD、4设备同时在线。土耳其区/阿根廷区低价开通。',
     25.00, 4200, 1),
(32, 'YouTube Premium 会员', 303,
     'YouTube高级会员，免广告、后台播放、YouTube Music。土耳其区低价开通。',
     18.00, 3600, 1),
(33, 'Spotify Premium 会员', 303,
     'Spotify高级会员，无广告、离线下载、高音质。土耳其区低价开通。',
     15.00, 4800, 1),
(34, 'Steam 钱包充值卡', 304,
     'Steam平台钱包充值码，50/100/200元面额。全球区通用。',
     30.00, 6800, 1),
(35, 'Xbox Game Pass Ultimate', 304,
     'Xbox终极会员，含Xbox+PC+云游戏库+EA Play。土耳其区低价开通。',
     28.00, 2200, 1),
(36, 'Microsoft 365 个人版', 305,
     'M365个人订阅，含Word/Excel/PPT/Outlook + 1TB OneDrive。土耳其区低价开通。',
     35.00, 5200, 1),
(37, 'JetBrains 全家桶激活', 305,
     'JetBrains全系列IDE激活码，IDEA/WebStorm/PyCharm/GoLand/PhpStorm等。',
     45.00, 4800, 1),
(38, 'Adobe Creative Cloud 全套', 305,
     'Adobe创意云全家桶，PS/AI/PR/AE等20+应用。',
     68.00, 2200, 1),
(39, 'GitHub Pro 会员', 305,
     'GitHub Pro，含Copilot、高级代码分析、无限协作者。',
     18.00, 3400, 1),
(40, 'iCloud+ 200GB', 305,
     'Apple iCloud+ 200GB云存储，含Private Relay、隐藏邮箱。',
     12.00, 2600, 1),

-- ========== 4. 课设与毕设 ==========
(41, 'SSM 管理系统', 401,
     '基于Spring+SpringMVC+MyBatis。含完整源码、数据库SQL、需求文档、答辩PPT。图书/选课/商城/宠物医院/酒店/停车场可选。',
     19.90, 8800, 1),
(42, 'SpringBoot 管理系统', 401,
     '基于SpringBoot+MyBatis-Plus。Vue/Thymeleaf前端可选。博客/外卖/考试/论坛/医疗/人事可选。',
     24.90, 7200, 1),
(43, 'Python Web 项目', 402,
     '基于Flask/Django。Flask博客/Django电商/爬虫可视化/Flask聊天室可选。',
     14.90, 5600, 1),
(44, 'Vue/React 前端项目', 402,
     'Vue3后台管理/React电商/Vue3个人主页可选。含完整源码和部署文档。',
     19.90, 3800, 1),
(45, '微信小程序项目', 402,
     '配合SpringBoot后端。校园二手交易/外卖点餐/记账本可选。',
     24.90, 4200, 1),
(46, '蓝桥杯/比赛获奖项目', 403,
     '历年比赛获奖项目源码，Web/大数据/AI/物联网方向均有覆盖。含文档和答辩材料。',
     29.90, 2800, 1),

-- ========== 5. 知识付费 ==========
(47, 'Claude Code 从入门到精通', 501,
     'Claude Code CLI完全教程，安装配置、Hooks、MCP Server、多文件实战。附Skills模板。',
     9.90, 4200, 1),
(48, 'Cursor 实战指南', 501,
     'Cursor AI IDE完全教程，Tab补全、Chat、Composer、.cursorrules模板大全。',
     6.90, 3800, 1),
(49, 'GitHub Copilot / Codex 实战', 501,
     'Copilot和Codex编程实战教程，代码补全、Bug修复、代码审查、CI/CD集成。',
     6.90, 3200, 1),
(50, 'Skills 大全（1000+ Prompt模板）', 502,
     '精选1000+高质量Prompt/Skills模板，编程/写作/绘画/办公/数据分析/营销/教育。持续更新。',
     4.90, 12600, 1),
(51, 'AI Agent 开发实战', 502,
     'Agent从概念到落地，ReAct/Plan-and-Execute/Multi-Agent架构、LangChain/CrewAI/AutoGen实战。',
     19.90, 2200, 1),
(52, 'AI 从入门到入土——完全指南', 502,
     'AI/大模型完全学习路线。基础概念、Prompt Engineering、RAG、Agent、微调、部署。适合非科班转行。',
     19.90, 5800, 1),

-- ========== 6. 工具与充值 ==========
(53, 'OpenClaw 一键部署包', 601,
     'OpenClaw开源AI助手一键部署，Docker/Vercel/Zeabur。含配置教程。',
     5.90, 3200, 1),
(54, 'Hermes 一键部署包', 601,
     'Hermes消息推送一键部署，支持微信/钉钉/飞书/Telegram多渠道。',
     3.90, 2400, 1),
(55, 'LobeChat 一键部署包', 601,
     'LobeChat开源AI聊天框架部署，多模型接入、插件市场、知识库。Docker/Vercel可选。',
     8.90, 4600, 1),
(56, 'ChatGPT 注册机', 602,
     'ChatGPT批量注册自动化脚本，自动接码、邮箱验证、手机号绑定。单次/永久授权。',
     29.90, 4800, 1),
(57, '0刀虚拟信用卡', 602,
     '0美元预授权虚拟信用卡，可用于ChatGPT Plus等海外服务订阅验证。单张/5张/10张打包。',
     5.00, 12800, 1),
(58, '批量邮箱注册脚本', 602,
     'Gmail/Outlook/ProtonMail批量注册自动化脚本。单次/永久授权。',
     19.90, 3200, 1),
(59, 'USDT (TRC20) 充值', 603,
     'USDT泰达币TRC20链充值，小额快速到账。10/50/100 USDT。',
     10.00, 6800, 1),
(60, 'USDC (ERC20) 充值', 603,
     'USDC美元稳定币ERC20链充值。10/50 USDC。',
     10.00, 2400, 1),
(61, 'Binance 邀请码', 603,
     'Binance币安交易所邀请码，手续费20%返佣。附新手教程。',
     1.00, 9200, 1),
(62, 'OKX 邀请码', 603,
     'OKX欧易交易所邀请码，手续费返佣+新用户盲盒福利。',
     1.00, 7400, 1),
(63, 'Bybit 邀请码', 603,
     'Bybit交易所邀请码，手续费返佣+新用户奖励。',
     1.00, 3600, 1);

-- ============================
-- SKU 规格
-- ============================
INSERT INTO `product_sku` (`product_id`, `spec_name`, `price`, `stock`) VALUES
-- ChatGPT Free
(1, '日抛（24h）', 0.50, 8000), (1, '月抛', 2.00, 3000), (1, '10个打包', 4.00, 1000),
-- ChatGPT Plus
(2, '日抛（24h）', 8.00, 5000), (2, '月抛（土区）', 45.00, 2000), (2, '月抛（阿区）', 38.00, 1500), (2, '季卡', 120.00, 800), (2, '年卡', 420.00, 300),
-- ChatGPT Pro
(3, '月抛', 188.00, 500), (3, '季卡', 488.00, 200),
-- Claude Free
(4, '日抛', 1.00, 5000), (4, '月抛', 5.00, 2000),
-- Claude Pro
(5, '月抛', 88.00, 1200), (5, '季卡', 238.00, 500), (5, '年卡', 828.00, 150),
-- Claude Max
(6, '月抛', 288.00, 200), (6, '季卡', 788.00, 80),
-- DeepSeek
(7, '日抛', 2.00, 5000), (7, '月抛', 8.00, 2000), (7, '10个打包', 15.00, 500),
-- Kimi
(8, '日抛', 3.00, 3000), (8, '月抛', 12.00, 1500),
-- Gemini
(9, '月抛', 48.00, 600), (9, '季卡', 128.00, 250),
-- Midjourney
(10, 'Basic 月卡', 35.00, 600), (10, 'Standard 月卡', 55.00, 400), (10, 'Pro 月卡', 138.00, 150),
-- SD云端
(11, '基础GPU 月卡', 15.00, 500), (11, '高级GPU 月卡', 35.00, 200),
-- Suno
(12, 'Pro 月卡', 18.00, 500), (12, 'Pro 年卡', 158.00, 150),
-- Runway
(13, 'Standard 月卡', 35.00, 300), (13, 'Pro 月卡', 88.00, 100),
-- Cursor
(14, '月抛', 28.00, 1000), (14, '年卡', 248.00, 400),
-- Windsurf
(15, '月抛', 22.00, 600), (15, '年卡', 198.00, 200),
-- OpenAI中转
(16, '充值10元', 10.00, 5000), (16, '充值50元', 48.00, 2000), (16, '充值100元', 92.00, 1000), (16, '充值500元', 440.00, 300),
-- Claude中转
(17, '充值10元', 10.00, 3000), (17, '充值50元', 48.00, 1500), (17, '充值100元', 92.00, 600),
-- DeepSeek API
(18, '充值10元', 10.00, 3000), (18, '充值50元', 45.00, 1200),
-- OpenAI SDK
(19, '$5 充值卡', 38.00, 1000), (19, '$10 充值卡', 72.00, 600), (19, '$50 充值卡', 350.00, 250), (19, '$100 充值卡', 680.00, 100),
-- Anthropic SDK
(20, '$5 充值卡', 40.00, 800), (20, '$10 充值卡', 75.00, 400), (20, '$50 充值卡', 360.00, 150),
-- 机场月卡
(21, '基础版 100G/月', 15.00, 3000), (21, '标准版 300G/月', 25.00, 2000), (21, '旗舰版 不限流量', 45.00, 1000),
-- 机场年卡
(22, '基础版 100G/月', 128.00, 1000), (22, '标准版 300G/月', 198.00, 800), (22, '旗舰版 不限流量', 388.00, 400),
-- 流量包
(23, '100GB', 10.00, 5000), (23, '500GB', 35.00, 2000),
-- 加速器
(24, '月卡', 8.00, 3000), (24, '季卡', 20.00, 1500), (24, '年卡', 68.00, 600),
-- Gmail
(25, '单个', 1.50, 8000), (25, '10个打包', 12.00, 2000), (25, '100个打包', 99.00, 500),
-- Outlook
(26, '单个', 0.80, 8000), (26, '10个打包', 6.00, 2000), (26, '50个打包', 25.00, 500),
-- ProtonMail
(27, '单个', 2.00, 3000), (27, '10个打包', 16.00, 800),
-- Apple ID
(28, '港区', 3.00, 3000), (28, '美区', 3.50, 2000), (28, '土区', 2.50, 2000), (28, '日区', 3.00, 1500),
-- Twitter
(29, '新号（0粉）', 2.00, 3000), (29, '老号（100+粉）', 8.00, 800), (29, '10个打包', 15.00, 500),
-- Telegram
(30, '普通号', 5.00, 2000), (30, '带Premium月卡', 18.00, 800),
-- Netflix
(31, '标准版 月卡（1屏）', 25.00, 800), (31, '高级版 月卡（4屏4K）', 45.00, 500), (31, '高级版 季卡', 120.00, 250),
-- YouTube
(32, '个人版 月卡', 18.00, 1000), (32, '个人版 季卡', 45.00, 500), (32, '家庭版 月卡（5人）', 28.00, 300),
-- Spotify
(33, '个人版 月卡', 15.00, 1200), (33, '个人版 季卡', 38.00, 600), (33, '个人版 年卡', 128.00, 300),
-- Steam
(34, '50元面额', 46.00, 1000), (34, '100元面额', 92.00, 800), (34, '200元面额', 183.00, 400),
-- Xbox
(35, 'Ultimate 月卡', 28.00, 600), (35, 'Ultimate 季卡', 75.00, 300), (35, 'PC版 月卡', 18.00, 400),
-- M365
(36, '个人版 年卡', 168.00, 800), (36, '家庭版 年卡（6人）', 238.00, 500),
-- JetBrains
(37, '单年授权', 45.00, 800), (37, '永久授权', 199.00, 250),
-- Adobe
(38, '全套 月卡', 68.00, 400), (38, '全套 年卡', 588.00, 150), (38, '单应用 月卡（PS）', 35.00, 300),
-- GitHub
(39, 'Pro 月卡', 18.00, 800), (39, 'Pro 年卡', 168.00, 400),
-- iCloud
(40, '200GB 月卡', 12.00, 800), (40, '2TB 月卡', 35.00, 300),
-- SSM
(41, '图书管理系统', 19.90, 600), (41, '学生选课系统', 19.90, 500), (41, '在线商城系统', 24.90, 400), (41, '宠物医院系统', 19.90, 450), (41, '酒店管理系统', 19.90, 380), (41, '停车场管理系统', 19.90, 320),
-- SpringBoot
(42, '个人博客系统', 24.90, 800), (42, '外卖点餐系统', 29.90, 600), (42, '在线考试系统', 24.90, 500), (42, '社区论坛系统', 24.90, 420), (42, '在线医疗挂号', 29.90, 350), (42, '人事管理系统', 24.90, 380),
-- Python
(43, 'Flask博客系统', 14.90, 500), (43, 'Django电商平台', 19.90, 400), (43, '爬虫+数据可视化', 14.90, 600), (43, 'Flask在线聊天室', 14.90, 350),
-- 前端
(44, 'Vue3后台管理系统', 19.90, 600), (44, 'React电商前台', 19.90, 400), (44, 'Vue3个人主页', 14.90, 500),
-- 小程序
(45, '校园二手交易', 24.90, 500), (45, '外卖点餐', 29.90, 400), (45, '记账本', 19.90, 450),
-- 比赛
(46, 'Web开发类', 29.90, 300), (46, '大数据分析类', 34.90, 200), (46, 'AI应用类', 39.90, 150), (46, '物联网/嵌入式', 34.90, 120),
-- Claude Code
(47, '基础版（PDF+代码）', 9.90, 1500), (47, '完整版（PDF+代码+视频）', 19.90, 800),
-- Cursor
(48, 'PDF教程', 6.90, 1200), (48, 'PDF+视频', 14.90, 600),
-- Copilot/Codex
(49, 'PDF教程', 6.90, 1000), (49, 'PDF+视频', 14.90, 500),
-- Skills
(50, '基础版 300条', 4.90, 3000), (50, '完整版 500+条', 9.90, 2000), (50, '至尊版 1000+条', 19.90, 800),
-- AI Agent
(51, 'PDF电子书', 19.90, 500), (51, 'PDF+代码+社群', 39.90, 200),
-- AI完全指南
(52, 'PDF电子书', 19.90, 1500), (52, 'PDF+代码+社群', 39.90, 800),
-- OpenClaw
(53, 'Docker版', 5.90, 1000), (53, '全平台版含教程', 12.90, 500),
-- Hermes
(54, '基础版', 3.90, 800), (54, '完整版含教程', 8.90, 400),
-- LobeChat
(55, 'Docker版', 8.90, 1200), (55, '全平台版含插件配置', 18.90, 600),
-- 注册机
(56, '单次授权', 29.90, 800), (56, '永久授权', 99.00, 300),
-- 0刀卡
(57, '单张', 5.00, 5000), (57, '5张打包', 20.00, 2000), (57, '10张打包', 35.00, 800),
-- 批量邮箱
(58, '单次授权', 19.90, 500), (58, '永久授权', 69.00, 200),
-- USDT
(59, '10 USDT', 72.00, 3000), (59, '50 USDT', 355.00, 1000), (59, '100 USDT', 700.00, 500),
-- USDC
(60, '10 USDC', 73.00, 1000), (60, '50 USDC', 360.00, 400),
-- Binance/OKX/Bybit
(61, '邀请码 x1', 1.00, 8000),
(62, '邀请码 x1', 1.00, 6000),
(63, '邀请码 x1', 1.00, 3000);

-- ============================
-- 卡密示例
-- ============================
INSERT INTO `card_key` (`sku_id`, `content`, `status`) VALUES
(1,  'account:gpt-free-001@outlook.com | password:Gp@2026fR1e', 0),
(1,  'account:gpt-free-002@outlook.com | password:Gp@2026eE3d', 0),
(4,  'account:gpt-plus-tr-001@outlook.com | password:Pl@2026tR7k | region:TR', 0),
(4,  'account:gpt-plus-tr-002@outlook.com | password:Pl@2026tR9m | region:TR', 0),
(9,  'account:claude-pro-001@proton.me | password:Cl@2026pR1o | plan:pro', 0),
(9,  'account:claude-pro-002@proton.me | password:Cl@2026pR3p | plan:pro', 0),
(14, 'account:deepseek-001@gmail.com | password:Ds@2026aC1b', 0),
(14, 'account:deepseek-002@gmail.com | password:Ds@2026cD3e', 0),
(22, 'account:midjourney-001@outlook.com | password:Mj@2026vR1a', 0),
(27, 'account:cursor-pro-001@outlook.com | password:Cu@2026pR1o', 0),
(30, 'account:gmail-001@gmail.com | password:Gm@2026aC1b | recovery:已设置', 0),
(30, 'account:gmail-002@gmail.com | password:Gm@2026cD3e | recovery:已设置', 0),
(38, 'account:proton-001@proton.me | password:Pm@2026eN1c', 0),
(42, 'account:appleid-001@icloud.com | password:Ap@2026iD1h | region:HK', 0),
(42, 'account:appleid-002@icloud.com | password:Ap@2026iD3j | region:US', 0),
(49, 'api-key:demo-key-openai-2026xK9mN2pQrS4tU6vW | balance:10CNY', 0),
(49, 'api-key:demo-key-openai-2026aB3cD5eF7gH9iJ1k | balance:10CNY', 0),
(61, 'api-key:demo-key-anthropic-2026xK9mN2pQrS4tU6vW | balance:10CNY', 0),
(66, 'OPENAI-SDK-2026-XK9M-NP4R-S6TU-$5', 0),
(66, 'OPENAI-SDK-2026-AB3C-D5EF-G7HI-$5', 0),
(72, 'subscribe-url:https://sub.example.com/link/abc123 | 100GB', 0),
(72, 'subscribe-url:https://sub.example.com/link/def456 | 100GB', 0),
(81, 'STEAM-WALLET-2026-XK9M-NP4R-S6TU-W8VX', 0),
(81, 'STEAM-WALLET-2026-AB3C-D5EF-G7HI-J1KL', 0),
(90, 'XBOX-GPU-2026-M9N2-P4R6-T8U1-V3W5', 0),
(93, 'M365-PERSONAL-2026-KX9M-2NP4-RS4T-U6VW', 0),
(93, 'M365-PERSONAL-2026-AB3C-5D7E-F9G1-H3I5', 0),
(95, 'JET-2026-XK9M-NP4R-S6TU-W8VX-Y1ZA-B3CD', 0),
(95, 'JET-2026-EF7G-H9IJ-K1LM-N3OP-Q5RS-T7UV', 0),
(98, 'ADOBE-CC-2026-001@creative.cloud | license:ad-xk9m2np4', 0),
(123, 'REF-2026-BINANCE-XK9M2N', 0),
(123, 'REF-2026-BINANCE-AB3C5D', 0),
(128, 'download:https://pan.example.com/s/ssm-library-001 | code:km9n', 0),
(128, 'download:https://pan.example.com/s/ssm-course-001 | code:pq3r', 0),
(137, 'download:https://pan.example.com/s/springboot-blog | code:xk9m', 0),
(145, 'download:https://pan.example.com/s/flask-blog | code:ab3c', 0),
(163, 'download:https://pan.example.com/s/claude-code-basic | code:ef7g', 0),
(171, 'download:https://pan.example.com/s/skills-500 | code:hj1k', 0),
(186, 'card-number:4532-XXXX-XXXX-7890 | cvv:123 | exp:12/28 | balance:$0', 0),
(186, 'card-number:4532-XXXX-XXXX-3456 | cvv:456 | exp:03/29 | balance:$0', 0);

-- ============================
-- 示例订单
-- ============================
INSERT INTO `mall_order` (`id`, `order_no`, `user_id`, `contact`, `query_password`, `pay_method`, `total_price`, `status`, `create_time`, `pay_time`) VALUES
(1,  '202606010915300001', 1, '13800138000', 'abc123', 'wechat',  8.00,   2, '2026-06-01 09:15:30', '2026-06-01 09:16:05'),
(2,  '202606011422000002', 2, 'maple_leaf@qq.com', 'def456', 'alipay',  45.00,  2, '2026-06-01 14:22:00', '2026-06-01 14:23:10'),
(3,  '202606021030450003', 3, '15800158002', 'ghi789', 'wechat',  28.00,  2, '2026-06-02 10:30:45', '2026-06-02 10:31:20'),
(4,  '202606021800000004', 1, '13800138000', 'jkl012', 'alipay',  88.00,  1, '2026-06-02 18:00:00', '2026-06-02 18:01:30'),
(5,  '202606030845000005', 4, 'rua_cute@gmail.com', NULL, NULL, 19.90,  0, '2026-06-03 08:45:00', NULL),
(6,  '202606031100000006', 5, 'breeze@outlook.com', 'mno345', 'wechat', 128.00,  2, '2026-06-03 11:00:00', '2026-06-03 11:02:15'),
(7,  '202606040920000007', 6, 'xiaohong@outlook.com', NULL, NULL,  24.90,  3, '2026-06-04 09:20:00', NULL);

INSERT INTO `order_item` (`order_id`, `product_id`, `sku_id`, `product_name`, `spec_name`, `price`, `quantity`) VALUES
(1, 2,  4,  'ChatGPT Plus 成品号', '日抛（24h）',          8.00,   1),
(2, 10, 22, 'Midjourney 成品号',   'Basic 月卡',           45.00,  1),
(3, 14, 27, 'Cursor Pro 成品号',   '月抛',                 28.00,  1),
(4, 5,  9,  'Claude Pro 成品号',   '月抛',                 88.00,  1),
(5, 41, 128,'SSM 管理系统',        '在线商城系统',          24.90,  1),
(5, 47, 163,'Claude Code 从入门到精通','基础版（PDF+代码）',  9.90,  1),
(6, 22, 72, '机场订阅 年卡',       '基础版 100G/月',       128.00, 1),
(7, 42, 137,'SpringBoot 管理系统',  '个人博客系统',          24.90,  1);

-- 更新已卖出的卡密状态及关联订单明细
-- order_item 1: sku_id=4 (ChatGPT Plus 日抛) → 卡密 id=3
UPDATE `card_key` SET `status` = 1, `order_item_id` = 1, `sell_time` = '2026-06-01 09:16:05' WHERE `id` = 3;
-- order_item 2: sku_id=22 (Midjourney Basic 月卡) → 卡密 id=9
UPDATE `card_key` SET `status` = 1, `order_item_id` = 2, `sell_time` = '2026-06-01 14:23:10' WHERE `id` = 9;
-- order_item 3: sku_id=27 (Cursor Pro 月抛) → 卡密 id=10
UPDATE `card_key` SET `status` = 1, `order_item_id` = 3, `sell_time` = '2026-06-02 10:31:20' WHERE `id` = 10;
-- order_item 4: sku_id=9 (Claude Pro 月抛) → 卡密 id=5
UPDATE `card_key` SET `status` = 1, `order_item_id` = 4, `sell_time` = '2026-06-02 18:01:30' WHERE `id` = 5;

-- 更新商品销量（已示例订单中涉及的商品）
UPDATE `product` SET `sales` = `sales` + 1 WHERE `id` IN (2, 5, 10, 14, 22, 41, 42, 47);
