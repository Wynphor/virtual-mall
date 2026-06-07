-- 商品封面图按类别原则重新分配（二次元风格）
-- 原则：
--   AI服务(101/102) → 人物肖像（冷色调/科技感）
--   AI绘画/创意(103) → 色彩鲜艳艺术画
--   AI编程(104) → 干净清新风格
--   API/网络(201/202/203) → 风景/开阔感
--   账号/会员(301/302/303) → 可爱/日常向
--   游戏/软件(304) → 色彩丰富
--   源码/项目(401) → 科技感人物
--   教程/课程(402) → 学习氛围
--   部署/搭建(403) → 清新自然
--   充值/支付(501) → 简洁可爱

-- ========== 1. AI服务与账号(101) → 人物肖像 ==========
-- ChatGPT 系列
UPDATE product SET image = 'acg_04.png' WHERE id = 1;   -- Free - 猫耳少女(清新入门感)
UPDATE product SET image = 'acg_05.png' WHERE id = 2;   -- Plus - 兔耳少女(进阶)
UPDATE product SET image = 'acg_09.png' WHERE id = 3;   -- Pro - 金发少女(高端感)
-- Claude 系列
UPDATE product SET image = 'acg_01.jpg' WHERE id = 4;   -- Free - 02水彩(入门)
UPDATE product SET image = 'acg_02.png' WHERE id = 5;   -- Pro - 花卉少年(专业)
UPDATE product SET image = 'acg_10.png' WHERE id = 6;   -- Max - 壁画少女(顶级)

-- ========== 2. AI服务与账号(102) → 人物肖像 ==========
UPDATE product SET image = 'acg_03.webp' WHERE id = 7;  -- DeepSeek - 魔女(国产之光)
UPDATE product SET image = 'acg_06.png' WHERE id = 8;   -- Kimi - 风铃(长上下文)
UPDATE product SET image = 'acg_11.png' WHERE id = 9;   -- Gemini - 樱花少女(Google)

-- ========== 3. AI绘画/音乐/视频(103) → 色彩鲜艳艺术画 ==========
UPDATE product SET image = 'acg_02.png' WHERE id = 10;  -- Midjourney - 花卉少年(绘画)
UPDATE product SET image = 'acg_10.png' WHERE id = 11;  -- SD - 壁画少女(AI艺术)
UPDATE product SET image = 'acg_12.webp' WHERE id = 12; -- Suno - 田园吉卜力(音乐)
UPDATE product SET image = 'acg_01.jpg' WHERE id = 13;  -- Runway - 02水彩(视频)

-- ========== 4. AI编程(104) → 干净清新 ==========
UPDATE product SET image = 'acg_06.png' WHERE id = 14;  -- Cursor - 风铃(简洁)
UPDATE product SET image = 'acg_08.webp' WHERE id = 15; -- Windsurf - 樱花猫(清新)

-- ========== 5. API中转(201) → 风景/开阔 ==========
UPDATE product SET image = 'acg_07.webp' WHERE id = 16; -- OpenAI API - 城市黄昏
UPDATE product SET image = 'acg_12.webp' WHERE id = 17; -- Claude API - 田园
UPDATE product SET image = 'acg_08.webp' WHERE id = 18; -- DeepSeek API - 樱花猫

-- ========== 6. API充值卡(202) → 简洁 ==========
UPDATE product SET image = 'acg_06.png' WHERE id = 19;  -- OpenAI充值 - 风铃
UPDATE product SET image = 'acg_11.png' WHERE id = 20;  -- Anthropic充值 - 樱花少女

-- ========== 7. 网络工具(203) → 开阔风景 ==========
UPDATE product SET image = 'acg_07.webp' WHERE id = 21; -- 机场月卡 - 城市黄昏
UPDATE product SET image = 'acg_12.webp' WHERE id = 22; -- 机场年卡 - 田园
UPDATE product SET image = 'acg_08.webp' WHERE id = 23; -- 机场流量包 - 樱花猫
UPDATE product SET image = 'acg_07.webp' WHERE id = 24; -- 游戏加速器 - 城市

-- ========== 8. 邮箱(301) → 可爱/日常 ==========
UPDATE product SET image = 'acg_04.png' WHERE id = 25;  -- Gmail - 猫耳少女
UPDATE product SET image = 'acg_05.png' WHERE id = 26;  -- Outlook - 兔耳少女
UPDATE product SET image = 'acg_09.png' WHERE id = 27;  -- ProtonMail - 金发少女

-- ========== 9. 社交账号(302) → 人物 ==========
UPDATE product SET image = 'acg_01.jpg' WHERE id = 28;  -- Apple ID - 02水彩
UPDATE product SET image = 'acg_03.webp' WHERE id = 29; -- Twitter/X - 魔女
UPDATE product SET image = 'acg_06.png' WHERE id = 30;  -- Telegram - 风铃

-- ========== 10. 会员订阅(303) → 色彩丰富 ==========
UPDATE product SET image = 'acg_02.png' WHERE id = 31;  -- Netflix - 花卉少年
UPDATE product SET image = 'acg_11.png' WHERE id = 32;  -- YouTube - 樱花少女
UPDATE product SET image = 'acg_12.webp' WHERE id = 33; -- Spotify - 田园

-- ========== 11. 游戏/软件(304) → 色彩丰富 ==========
UPDATE product SET image = 'acg_03.webp' WHERE id = 34; -- Steam钱包 - 魔女
UPDATE product SET image = 'acg_01.jpg' WHERE id = 35;  -- Xbox - 02水彩
UPDATE product SET image = 'acg_02.png' WHERE id = 36;  -- M365 - 花卉少年
UPDATE product SET image = 'acg_10.png' WHERE id = 37;  -- JetBrains - 壁画少女
UPDATE product SET image = 'acg_09.png' WHERE id = 38;  -- Adobe - 金发少女
UPDATE product SET image = 'acg_04.png' WHERE id = 39;  -- GitHub Pro - 猫耳少女
UPDATE product SET image = 'acg_05.png' WHERE id = 40;  -- iCloud+ - 兔耳少女

-- ========== 12. 源码/项目(401) → 科技感人物 ==========
UPDATE product SET image = 'acg_04.png' WHERE id = 41;  -- SSM项目 - 猫耳少女
UPDATE product SET image = 'acg_05.png' WHERE id = 42;  -- SpringBoot - 兔耳少女
UPDATE product SET image = 'acg_09.png' WHERE id = 43;  -- Python - 金发少女
UPDATE product SET image = 'acg_01.jpg' WHERE id = 44;  -- Vue/React - 02水彩
UPDATE product SET image = 'acg_03.webp' WHERE id = 45; -- 微信小程序 - 魔女
UPDATE product SET image = 'acg_02.png' WHERE id = 46;  -- 毕设项目 - 花卉少年

-- ========== 13. 教程/课程(402) → 学习氛围 ==========
UPDATE product SET image = 'acg_10.png' WHERE id = 47;  -- Claude Code - 壁画少女
UPDATE product SET image = 'acg_06.png' WHERE id = 48;  -- Cursor实战 - 风铃
UPDATE product SET image = 'acg_11.png' WHERE id = 49;  -- Copilot - 樱花少女
UPDATE product SET image = 'acg_12.webp' WHERE id = 50; -- Skills - 田园
UPDATE product SET image = 'acg_07.webp' WHERE id = 51; -- AI Agent - 城市黄昏
UPDATE product SET image = 'acg_08.webp' WHERE id = 52; -- AI绘画教程 - 樱花猫

-- ========== 14. 部署/搭建(403) → 清新自然 ==========
UPDATE product SET image = 'acg_08.webp' WHERE id = 53; -- OpenClaw - 樱花猫
UPDATE product SET image = 'acg_12.webp' WHERE id = 54; -- Hermes - 田园
UPDATE product SET image = 'acg_06.png' WHERE id = 55;  -- LobeChat - 风铃

-- ========== 15. 充值/支付(501) → 简洁可爱 ==========
UPDATE product SET image = 'acg_04.png' WHERE id = 56;  -- ChatGPT注册 - 猫耳少女
UPDATE product SET image = 'acg_05.png' WHERE id = 57;  -- 0元开通 - 兔耳少女
UPDATE product SET image = 'acg_09.png' WHERE id = 58;  -- 邮箱注册 - 金发少女
UPDATE product SET image = 'acg_01.jpg' WHERE id = 59;  -- USDT - 02水彩
UPDATE product SET image = 'acg_02.png' WHERE id = 60;  -- USDC - 花卉少年
UPDATE product SET image = 'acg_03.webp' WHERE id = 61; -- Binance - 魔女
UPDATE product SET image = 'acg_10.png' WHERE id = 62;  -- OKX - 壁画少女
UPDATE product SET image = 'acg_11.png' WHERE id = 63;  -- Bybit - 樱花少女
