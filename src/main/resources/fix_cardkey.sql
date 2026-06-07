USE virtual_mall;

-- ========== AI成品号 ==========
INSERT INTO card_key (sku_id, content, status) VALUES
-- ChatGPT Free 月抛 (sku 2)
(2, 'account:gpt-free-m01@outlook.com | password:Gf@2026m01a', 0),
(2, 'account:gpt-free-m02@outlook.com | password:Gf@2026m02b', 0),
-- ChatGPT Free 10个打包 (sku 3)
(3, 'account:gpt-free-p01@gmail.com | password:Gp@2026p01x', 0),
(3, 'account:gpt-free-p02@gmail.com | password:Gp@2026p02y', 0),
(3, 'account:gpt-free-p03@gmail.com | password:Gp@2026p03z', 0),
(3, 'account:gpt-free-p04@gmail.com | password:Gp@2026p04a', 0),
(3, 'account:gpt-free-p05@gmail.com | password:Gp@2026p05b', 0),
-- ChatGPT Plus 月抛土区 (sku 5)
(5, 'account:gpt-plus-mtr01@outlook.com | password:Pt@2026m01 | region:TR', 0),
(5, 'account:gpt-plus-mtr02@outlook.com | password:Pt@2026m02 | region:TR', 0),
-- ChatGPT Plus 月抛阿区 (sku 6)
(6, 'account:gpt-plus-mar01@outlook.com | password:Pa@2026m01 | region:AR', 0),
(6, 'account:gpt-plus-mar02@outlook.com | password:Pa@2026m02 | region:AR', 0),
-- ChatGPT Plus 季卡 (sku 7)
(7, 'account:gpt-plus-q01@proton.me | password:Pq@2026q01 | plan:quarterly | region:TR', 0),
(7, 'account:gpt-plus-q02@proton.me | password:Pq@2026q02 | plan:quarterly | region:TR', 0),
-- ChatGPT Plus 年卡 (sku 8)
(8, 'account:gpt-plus-y01@proton.me | password:Py@2026y01 | plan:yearly | region:TR', 0),
(8, 'account:gpt-plus-y02@proton.me | password:Py@2026y02 | plan:yearly | region:TR', 0),
-- ChatGPT Pro 季卡 (sku 10)
(10, 'account:gpt-pro-q01@proton.me | password:Pq@2026q01x | plan:pro | plan:quarterly', 0),
(10, 'account:gpt-pro-q02@proton.me | password:Pq@2026q02y | plan:pro | plan:quarterly', 0),
-- Claude Free 日抛 (sku 11)
(11, 'account:claude-free-d01@outlook.com | password:Cf@2026d01', 0),
(11, 'account:claude-free-d02@outlook.com | password:Cf@2026d02', 0),
-- Claude Free 月抛 (sku 12)
(12, 'account:claude-free-m01@gmail.com | password:Cm@2026m01', 0),
(12, 'account:claude-free-m02@gmail.com | password:Cm@2026m02', 0),
-- Claude Pro 季卡 (sku 14)
(14, 'account:claude-pro-q01@outlook.com | password:Cp@2026q01 | plan:pro | plan:quarterly', 0),
(14, 'account:claude-pro-q02@outlook.com | password:Cp@2026q02 | plan:pro | plan:quarterly', 0),
-- Claude Pro 年卡 (sku 15)
(15, 'account:claude-pro-y01@gmail.com | password:Cy@2026y01 | plan:pro | plan:yearly', 0),
(15, 'account:claude-pro-y02@gmail.com | password:Cy@2026y02 | plan:pro | plan:yearly', 0),
-- Claude Max 月抛 (sku 16)
(16, 'account:claude-max-m01@proton.me | password:Cx@2026m01 | plan:max', 0),
(16, 'account:claude-max-m02@proton.me | password:Cx@2026m02 | plan:max', 0),
-- Claude Max 季卡 (sku 17)
(17, 'account:claude-max-q01@proton.me | password:Cx@2026q01 | plan:max | plan:quarterly', 0),
(17, 'account:claude-max-q02@proton.me | password:Cx@2026q02 | plan:max | plan:quarterly', 0),
-- DeepSeek 日抛 (sku 18)
(18, 'account:deepseek-d01@qq.com | password:Ds@2026d01', 0),
(18, 'account:deepseek-d02@qq.com | password:Ds@2026d02', 0),
-- DeepSeek 月抛 (sku 19)
(19, 'account:deepseek-m01@gmail.com | password:Dm@2026m01', 0),
(19, 'account:deepseek-m02@gmail.com | password:Dm@2026m02', 0),
-- DeepSeek 10个打包 (sku 20)
(20, 'account:deepseek-p01@outlook.com | password:Dp@2026p01', 0),
(20, 'account:deepseek-p02@outlook.com | password:Dp@2026p02', 0),
(20, 'account:deepseek-p03@outlook.com | password:Dp@2026p03', 0),
-- Kimi 月抛 (sku 22)
(22, 'account:kimi-m01@qq.com | password:Km@2026m01', 0),
(22, 'account:kimi-m02@qq.com | password:Km@2026m02', 0),
-- Gemini 月抛 (sku 23)
(23, 'account:gemini-m01@gmail.com | password:Gm@2026m01 | region:TR', 0),
(23, 'account:gemini-m02@gmail.com | password:Gm@2026m02 | region:TR', 0),
-- Gemini 季卡 (sku 24)
(24, 'account:gemini-q01@gmail.com | password:Gq@2026q01 | plan:quarterly | region:TR', 0),
(24, 'account:gemini-q02@gmail.com | password:Gq@2026q02 | plan:quarterly | region:TR', 0),
-- Midjourney Standard月卡 (sku 26)
(26, 'account:mj-standard-001@gmail.com | password:Mj@2026s01 | plan:standard', 0),
(26, 'account:mj-standard-002@gmail.com | password:Mj@2026s02 | plan:standard', 0),
-- Midjourney Pro月卡 (sku 27)
(27, 'account:mj-pro-001@gmail.com | password:Mj@2026p01 | plan:pro', 0),
(27, 'account:mj-pro-002@gmail.com | password:Mj@2026p02 | plan:pro', 0),
-- SD 基础GPU月卡 (sku 28)
(28, 'account:sd-basic-001@outlook.com | password:Sd@2026b01 | gpu:basic', 0),
(28, 'account:sd-basic-002@outlook.com | password:Sd@2026b02 | gpu:basic', 0),
-- SD 高级GPU月卡 (sku 29)
(29, 'account:sd-advanced-001@gmail.com | password:Sd@2026a01 | gpu:advanced', 0),
(29, 'account:sd-advanced-002@gmail.com | password:Sd@2026a02 | gpu:advanced', 0),
-- Suno Pro年卡 (sku 31)
(31, 'account:suno-pro-y01@outlook.com | password:Sy@2026y01 | plan:pro | plan:yearly', 0),
(31, 'account:suno-pro-y02@outlook.com | password:Sy@2026y02 | plan:pro | plan:yearly', 0),
-- Runway Standard月卡 (sku 32)
(32, 'account:runway-std-001@gmail.com | password:Rw@2026s01 | plan:standard', 0),
(32, 'account:runway-std-002@gmail.com | password:Rw@2026s02 | plan:standard', 0),
-- Runway Pro月卡 (sku 33)
(33, 'account:runway-pro-001@gmail.com | password:Rw@2026p01 | plan:pro', 0),
(33, 'account:runway-pro-002@gmail.com | password:Rw@2026p02 | plan:pro', 0),
-- Cursor 年卡 (sku 35)
(35, 'account:cursor-y01@gmail.com | password:Cu@2026y01 | plan:pro | plan:yearly', 0),
(35, 'account:cursor-y02@gmail.com | password:Cu@2026y02 | plan:pro | plan:yearly', 0),
-- Windsurf 月抛 (sku 36)
(36, 'account:windsurf-m01@outlook.com | password:Wf@2026m01 | plan:pro', 0),
(36, 'account:windsurf-m02@outlook.com | password:Wf@2026m02 | plan:pro', 0),
-- Windsurf 年卡 (sku 37)
(37, 'account:windsurf-y01@gmail.com | password:Wy@2026y01 | plan:pro | plan:yearly', 0),
(37, 'account:windsurf-y02@gmail.com | password:Wy@2026y02 | plan:pro | plan:yearly', 0);

-- ========== API与网络 ==========
INSERT INTO card_key (sku_id, content, status) VALUES
-- OpenAI API 充值50元 (sku 39)
(39, 'api-key:demo-key-openai-2026mN2pQrS4tU6vWxK9 | balance:50CNY', 0),
(39, 'api-key:demo-key-openai-2026aB3cD5eF7gH9iJ1 | balance:50CNY', 0),
-- OpenAI API 充值100元 (sku 40)
(40, 'api-key:demo-key-openai-2026pQrS4tU6vWxK9mN | balance:100CNY', 0),
(40, 'api-key:demo-key-openai-2026cD5eF7gH9iJ1kL2 | balance:100CNY', 0),
-- OpenAI API 充值500元 (sku 41)
(41, 'api-key:demo-key-openai-2026tU6vWxK9mN2pQrS | balance:500CNY', 0),
(41, 'api-key:demo-key-openai-2026eF7gH9iJ1kL2mN3 | balance:500CNY', 0),
-- Claude API 充值50元 (sku 43)
(43, 'api-key:demo-key-anthropic-2026mN2pQrS4tU6vWxK9 | balance:50CNY', 0),
(43, 'api-key:demo-key-anthropic-2026aB3cD5eF7gH9iJ1 | balance:50CNY', 0),
-- Claude API 充值100元 (sku 44)
(44, 'api-key:demo-key-anthropic-2026pQrS4tU6vWxK9mN | balance:100CNY', 0),
(44, 'api-key:demo-key-anthropic-2026cD5eF7gH9iJ1kL2 | balance:100CNY', 0),
-- DeepSeek API 充值10元 (sku 45)
(45, 'api-key:ds-2026mN2pQrS4tU6vWxK9 | balance:10CNY', 0),
(45, 'api-key:ds-2026aB3cD5eF7gH9iJ1 | balance:10CNY', 0),
-- DeepSeek API 充值50元 (sku 46)
(46, 'api-key:ds-2026pQrS4tU6vWxK9mN | balance:50CNY', 0),
(46, 'api-key:ds-2026cD5eF7gH9iJ1kL2 | balance:50CNY', 0),
-- OpenAI SDK $5 (sku 47)
(47, 'GIFT-OPENAI-2026-XK9M-NP4R-S6TU-V8WX | value:$5', 0),
(47, 'GIFT-OPENAI-2026-AB3C-D5EF-G7HI-J1KL | value:$5', 0),
-- OpenAI SDK $10 (sku 48)
(48, 'GIFT-OPENAI-2026-M9N2-P4R6-T8U1-V3W5 | value:$10', 0),
(48, 'GIFT-OPENAI-2026-X7K8-L2M3-N5P4-Q6R7 | value:$10', 0),
-- OpenAI SDK $50 (sku 49)
(49, 'GIFT-OPENAI-2026-EF7G-H9IJ-K1LM-N3OP | value:$50', 0),
(49, 'GIFT-OPENAI-2026-Q5RS-T7UV-W1XY-Z3AB | value:$50', 0),
-- OpenAI SDK $100 (sku 50)
(50, 'GIFT-OPENAI-2026-C4DE-F5GH-I6JK-L7MN | value:$100', 0),
(50, 'GIFT-OPENAI-2026-O8PQ-R9ST-U0VW-X1YZ | value:$100', 0),
-- Anthropic SDK $5 (sku 51)
(51, 'GIFT-ANTHROPIC-2026-XK9M-NP4R-S6TU | value:$5', 0),
(51, 'GIFT-ANTHROPIC-2026-AB3C-D5EF-G7HI | value:$5', 0),
-- Anthropic SDK $10 (sku 52)
(52, 'GIFT-ANTHROPIC-2026-M9N2-P4R6-T8U1 | value:$10', 0),
(52, 'GIFT-ANTHROPIC-2026-X7K8-L2M3-N5P4 | value:$10', 0),
-- Anthropic SDK $50 (sku 53)
(53, 'GIFT-ANTHROPIC-2026-EF7G-H9IJ-K1LM | value:$50', 0),
(53, 'GIFT-ANTHROPIC-2026-Q5RS-T7UV-W1XY | value:$50', 0),
-- 机场月卡标准版300G (sku 55)
(55, 'subscribe-url:https://sub.example.com/link/m300a | traffic:300GB | expire:30days', 0),
(55, 'subscribe-url:https://sub.example.com/link/m300b | traffic:300GB | expire:30days', 0),
-- 机场月卡旗舰版不限 (sku 56)
(56, 'subscribe-url:https://sub.example.com/link/u001a | traffic:unlimited | expire:30days', 0),
(56, 'subscribe-url:https://sub.example.com/link/u001b | traffic:unlimited | expire:30days', 0),
-- 机场年卡基础版100G (sku 57)
(57, 'subscribe-url:https://sub.example.com/link/y100a | traffic:100GB | expire:365days', 0),
(57, 'subscribe-url:https://sub.example.com/link/y100b | traffic:100GB | expire:365days', 0),
-- 机场年卡标准版300G (sku 58)
(58, 'subscribe-url:https://sub.example.com/link/y300a | traffic:300GB | expire:365days', 0),
(58, 'subscribe-url:https://sub.example.com/link/y300b | traffic:300GB | expire:365days', 0),
-- 机场年卡旗舰版不限 (sku 59)
(59, 'subscribe-url:https://sub.example.com/link/yu01a | traffic:unlimited | expire:365days', 0),
(59, 'subscribe-url:https://sub.example.com/link/yu01b | traffic:unlimited | expire:365days', 0),
-- 机场流量500GB (sku 61)
(61, 'traffic-add:https://sub.example.com/link/t500a | add:500GB', 0),
(61, 'traffic-add:https://sub.example.com/link/t500b | add:500GB', 0),
-- 加速器月卡 (sku 62)
(62, 'account:accel-m01@qq.com | password:Ac@2026m01 | brand:UU | months:1', 0),
(62, 'account:accel-m02@qq.com | password:Ac@2026m02 | brand:迅游 | months:1', 0),
-- 加速器季卡 (sku 63)
(63, 'account:accel-q01@qq.com | password:Ac@2026q01 | brand:UU | months:3', 0),
(63, 'account:accel-q02@qq.com | password:Ac@2026q02 | brand:雷神 | months:3', 0),
-- 加速器年卡 (sku 64)
(64, 'account:accel-y01@qq.com | password:Ac@2026y01 | brand:UU | months:12', 0),
(64, 'account:accel-y02@qq.com | password:Ac@2026y02 | brand:迅游 | months:12', 0);

-- ========== 账号与会员 ==========
INSERT INTO card_key (sku_id, content, status) VALUES
-- Gmail 10个打包 (sku 66)
(66, 'account:gmail-b10-01@gmail.com | password:Gb@202601 | recovery:已设置', 0),
(66, 'account:gmail-b10-02@gmail.com | password:Gb@202602 | recovery:已设置', 0),
(66, 'account:gmail-b10-03@gmail.com | password:Gb@202603 | recovery:已设置', 0),
-- Gmail 100个打包 (sku 67)
(67, 'account:gmail-b100-01@gmail.com | password:Gx@202601 | recovery:已设置 | batch:100', 0),
(67, 'account:gmail-b100-02@gmail.com | password:Gx@202602 | recovery:已设置 | batch:100', 0),
-- Outlook 单个 (sku 68)
(68, 'account:outlook-001@outlook.com | password:Ol@2026001 | recovery:已设置', 0),
(68, 'account:outlook-002@outlook.com | password:Ol@2026002 | recovery:已设置', 0),
-- Outlook 10个打包 (sku 69)
(69, 'account:outlook-b10-01@outlook.com | password:Ob@202601', 0),
(69, 'account:outlook-b10-02@outlook.com | password:Ob@202602', 0),
-- Outlook 50个打包 (sku 70)
(70, 'account:outlook-b50-01@outlook.com | password:Ox@202601 | batch:50', 0),
(70, 'account:outlook-b50-02@outlook.com | password:Ox@202602 | batch:50', 0),
-- ProtonMail 10个打包 (sku 72)
(72, 'account:proton-b10-01@proton.me | password:Pb@202601', 0),
(72, 'account:proton-b10-02@proton.me | password:Pb@202602', 0),
-- Apple ID 美区 (sku 74)
(74, 'account:appleid-us01@icloud.com | password:Au@202601 | region:US | phone:已绑定', 0),
(74, 'account:appleid-us02@icloud.com | password:Au@202602 | region:US | phone:已绑定', 0),
-- Apple ID 土区 (sku 75)
(75, 'account:appleid-tr01@icloud.com | password:At@202601 | region:TR | phone:已绑定', 0),
(75, 'account:appleid-tr02@icloud.com | password:At@202602 | region:TR | phone:已绑定', 0),
-- Apple ID 日区 (sku 76)
(76, 'account:appleid-jp01@icloud.com | password:Aj@202601 | region:JP | phone:已绑定', 0),
(76, 'account:appleid-jp02@icloud.com | password:Aj@202602 | region:JP | phone:已绑定', 0),
-- Twitter 老号 (sku 78)
(78, 'account:tw-old-001@outlook.com | password:To@2026001 | followers:150 | verified:email', 0),
(78, 'account:tw-old-002@outlook.com | password:To@2026002 | followers:200 | verified:email', 0),
-- Twitter 10个打包 (sku 79)
(79, 'account:tw-b10-01@gmail.com | password:Tb@202601 | followers:0', 0),
(79, 'account:tw-b10-02@gmail.com | password:Tb@202602 | followers:0', 0),
-- Telegram 带Premium (sku 81)
(81, 'account:+8613800139003 | code:TG-2026-P1A2B3 | phone:verified | premium:30days', 0),
(81, 'account:+8613800139004 | code:TG-2026-P4C5D6 | phone:verified | premium:30days', 0),
-- Netflix 标准版月卡 (sku 82)
(82, 'account:nf-standard-001@gmail.com | password:Ns@2026001 | plan:standard | region:TR', 0),
(82, 'account:nf-standard-002@gmail.com | password:Ns@2026002 | plan:standard | region:TR', 0),
-- Netflix 高级版季卡 (sku 84)
(84, 'account:nf-premium-q01@gmail.com | password:Np@2026q01 | plan:premium | region:TR | 4K:yes', 0),
(84, 'account:nf-premium-q02@gmail.com | password:Np@2026q02 | plan:premium | region:TR | 4K:yes', 0),
-- YouTube 季卡 (sku 86)
(86, 'account:yt-premium-q01@gmail.com | password:Yq@2026q01 | plan:personal | region:TR', 0),
(86, 'account:yt-premium-q02@gmail.com | password:Yq@2026q02 | plan:personal | region:TR', 0),
-- YouTube 家庭版月卡 (sku 87)
(87, 'account:yt-family-001@gmail.com | password:Yf@2026001 | plan:family | members:5 | region:TR', 0),
(87, 'account:yt-family-002@gmail.com | password:Yf@2026002 | plan:family | members:5 | region:TR', 0),
-- Spotify 季卡 (sku 89)
(89, 'account:spotify-q01@gmail.com | password:Sq@2026q01 | plan:personal | region:TR', 0),
(89, 'account:spotify-q02@gmail.com | password:Sq@2026q02 | plan:personal | region:TR', 0),
-- Spotify 年卡 (sku 90)
(90, 'account:spotify-y01@gmail.com | password:Sx@2026y01 | plan:personal | region:TR', 0),
(90, 'account:spotify-y02@gmail.com | password:Sx@2026y02 | plan:personal | region:TR', 0),
-- Steam 100元 (sku 92)
(92, 'STEAM-WALLET-2026-M9N2-P4R6-T8U1-V3W5 | balance:100CNY', 0),
(92, 'STEAM-WALLET-2026-X7K8-L2M3-N5P4-Q6R7 | balance:100CNY', 0),
-- Steam 200元 (sku 93)
(93, 'STEAM-WALLET-2026-EF7G-H9IJ-K1LM-N3OP | balance:200CNY', 0),
(93, 'STEAM-WALLET-2026-Q5RS-T7UV-W1XY-Z3AB | balance:200CNY', 0),
-- Xbox 季卡 (sku 95)
(95, 'XBOX-GPU-2026-C4DE-F5GH-I6JK-L7MN | plan:ultimate | months:3', 0),
(95, 'XBOX-GPU-2026-O8PQ-R9ST-U0VW-X1YZ | plan:ultimate | months:3', 0),
-- Xbox PC版月卡 (sku 96)
(96, 'XBOX-PC-2026-A1B2-C3D4-E5F6-G7H8 | plan:pc | months:1', 0),
(96, 'XBOX-PC-2026-I9J0-K1L2-M3N4-O5P6 | plan:pc | months:1', 0),
-- M365 家庭版年卡 (sku 98)
(98, 'M365-FAMILY-2026-Q7R8-S9T0-U1V2-W3X4 | plan:family | members:6 | months:12', 0),
(98, 'M365-FAMILY-2026-Y5Z6-A7B8-C9D0-E1F2 | plan:family | members:6 | months:12', 0),
-- JetBrains 永久授权 (sku 100)
(100, 'JET-PERM-2026-G3H4-I5J6-K7L8-M9N0 | product:all | plan:permanent', 0),
(100, 'JET-PERM-2026-O1P2-Q3R4-S5T6-U7V8 | product:all | plan:permanent', 0),
-- Adobe 全套年卡 (sku 102)
(102, 'ADOBE-CC-2026-W9X0-Y1Z2-A3B4-C5D6 | license:full | months:12', 0),
(102, 'ADOBE-CC-2026-E7F8-G9H0-I1J2-K3L4 | license:full | months:12', 0),
-- Adobe 单应用PS月卡 (sku 103)
(103, 'ADOBE-PS-2026-M5N6-O7P8-Q9R0-S1T2 | license:photoshop | months:1', 0),
(103, 'ADOBE-PS-2026-U3V4-W5X6-Y7Z8-A9B0 | license:photoshop | months:1', 0),
-- GitHub Pro 年卡 (sku 105)
(105, 'account:gh-pro-y01@outlook.com | password:Gy@2026y01 | plan:pro | plan:yearly', 0),
(105, 'account:gh-pro-y02@outlook.com | password:Gy@2026y02 | plan:pro | plan:yearly', 0),
-- iCloud 200GB月卡 (sku 106)
(106, 'account:icloud-200-01@icloud.com | password:Ic@2026001 | storage:200GB | months:1', 0),
(106, 'account:icloud-200-02@icloud.com | password:Ic@2026002 | storage:200GB | months:1', 0),
-- iCloud 2TB月卡 (sku 107)
(107, 'account:icloud-2tb-01@icloud.com | password:Ix@2026001 | storage:2TB | months:1', 0),
(107, 'account:icloud-2tb-02@icloud.com | password:Ix@2026002 | storage:2TB | months:1', 0);

-- ========== 课设与毕设 ==========
INSERT INTO card_key (sku_id, content, status) VALUES
-- SSM 图书管理 (sku 108)
(108, 'download:https://pan.example.com/s/ssm-library | code:sl01 | readme:included', 0),
-- SSM 学生选课 (sku 109)
(109, 'download:https://pan.example.com/s/ssm-course | code:sc01 | readme:included', 0),
-- SSM 宠物医院 (sku 111)
(111, 'download:https://pan.example.com/s/ssm-pet | code:sp01 | readme:included', 0),
-- SSM 酒店管理 (sku 112)
(112, 'download:https://pan.example.com/s/ssm-hotel | code:sh01 | readme:included', 0),
-- SSM 停车场 (sku 113)
(113, 'download:https://pan.example.com/s/ssm-parking | code:sk01 | readme:included', 0),
-- SpringBoot 外卖 (sku 115)
(115, 'download:https://pan.example.com/s/sb-takeout | code:st01 | readme:included', 0),
-- SpringBoot 考试 (sku 116)
(116, 'download:https://pan.example.com/s/sb-exam | code:se01 | readme:included', 0),
-- SpringBoot 论坛 (sku 117)
(117, 'download:https://pan.example.com/s/sb-forum | code:sf01 | readme:included', 0),
-- SpringBoot 医疗 (sku 118)
(118, 'download:https://pan.example.com/s/sb-medical | code:sm01 | readme:included', 0),
-- SpringBoot 人事 (sku 119)
(119, 'download:https://pan.example.com/s/sb-hr | code:sh02 | readme:included', 0),
-- Python Django电商 (sku 121)
(121, 'download:https://pan.example.com/s/py-django | code:pd01 | readme:included', 0),
-- Python 爬虫可视化 (sku 122)
(122, 'download:https://pan.example.com/s/py-crawler | code:pc01 | readme:included', 0),
-- Python Flask聊天室 (sku 123)
(123, 'download:https://pan.example.com/s/py-chat | code:pf01 | readme:included', 0),
-- Vue3后台管理 (sku 124)
(124, 'download:https://pan.example.com/s/vue3-admin | code:va01 | readme:included', 0),
-- React电商 (sku 125)
(125, 'download:https://pan.example.com/s/react-shop | code:rs01 | readme:included', 0),
-- Vue3个人主页 (sku 126)
(126, 'download:https://pan.example.com/s/vue3-portfolio | code:vp01 | readme:included', 0),
-- 小程序 校园二手 (sku 127)
(127, 'download:https://pan.example.com/s/mp-trade | code:mt01 | readme:included', 0),
-- 小程序 外卖点餐 (sku 128)
(128, 'download:https://pan.example.com/s/mp-takeout | code:mt02 | readme:included', 0),
-- 小程序 记账本 (sku 129)
(129, 'download:https://pan.example.com/s/mp-book | code:mb01 | readme:included', 0),
-- 比赛 Web (sku 130)
(130, 'download:https://pan.example.com/s/comp-web | code:cw01 | readme:included', 0),
-- 比赛 大数据 (sku 131)
(131, 'download:https://pan.example.com/s/comp-data | code:cd01 | readme:included', 0),
-- 比赛 AI (sku 132)
(132, 'download:https://pan.example.com/s/comp-ai | code:ca01 | readme:included', 0),
-- 比赛 物联网 (sku 133)
(133, 'download:https://pan.example.com/s/comp-iot | code:ci01 | readme:included', 0);

-- ========== 知识付费 ==========
INSERT INTO card_key (sku_id, content, status) VALUES
-- Claude Code 完整版 (sku 135)
(135, 'download:https://pan.example.com/s/claude-code-full | code:cc01 | format:pdf+code+video', 0),
-- Cursor PDF教程 (sku 136)
(136, 'download:https://pan.example.com/s/cursor-pdf | code:cp01 | format:pdf', 0),
-- Cursor PDF+视频 (sku 137)
(137, 'download:https://pan.example.com/s/cursor-full | code:cf01 | format:pdf+video', 0),
-- Copilot PDF教程 (sku 138)
(138, 'download:https://pan.example.com/s/copilot-pdf | code:co01 | format:pdf', 0),
-- Copilot PDF+视频 (sku 139)
(139, 'download:https://pan.example.com/s/copilot-full | code:cf02 | format:pdf+video', 0),
-- Skills 基础版300条 (sku 140)
(140, 'download:https://pan.example.com/s/skills-300 | code:sk01 | format:md+txt', 0),
-- Skills 至尊版1000+条 (sku 142)
(142, 'download:https://pan.example.com/s/skills-1000 | code:sx01 | format:md+txt', 0),
-- AI Agent PDF电子书 (sku 143)
(143, 'download:https://pan.example.com/s/agent-pdf | code:ap01 | format:pdf', 0),
-- AI Agent PDF+代码+社群 (sku 144)
(144, 'download:https://pan.example.com/s/agent-full | code:af01 | format:pdf+code | group:included', 0),
-- AI指南 PDF+代码+社群 (sku 146)
(146, 'download:https://pan.example.com/s/ai-full | code:ai01 | format:pdf+code | group:included', 0);

-- ========== 工具与充值 ==========
INSERT INTO card_key (sku_id, content, status) VALUES
-- OpenClaw 全平台版 (sku 148)
(148, 'download:https://pan.example.com/s/openclaw-full | code:oc01 | platform:all | readme:included', 0),
-- Hermes 基础版 (sku 149)
(149, 'download:https://pan.example.com/s/hermes-basic | code:hb01 | readme:included', 0),
-- Hermes 完整版 (sku 150)
(150, 'download:https://pan.example.com/s/hermes-full | code:hf01 | readme:included', 0),
-- LobeChat 全平台版 (sku 152)
(152, 'download:https://pan.example.com/s/lobechat-full | code:lf01 | platform:all | plugins:included', 0),
-- ChatGPT注册机 单次授权 (sku 153)
(153, 'license:REG-2026-M9N2-P4R6-T8U1 | type:single | limit:10accounts', 0),
-- 0刀卡 5张打包 (sku 156)
(156, 'card-number:5167-XXXX-XXXX-1234 | cvv:789 | exp:06/29 | balance:$0 | region:US', 0),
(156, 'card-number:5167-XXXX-XXXX-5678 | cvv:012 | exp:09/29 | balance:$0 | region:US', 0),
-- 0刀卡 10张打包 (sku 157)
(157, 'card-number:4111-XXXX-XXXX-1111 | cvv:111 | exp:01/30 | balance:$0 | region:US', 0),
(157, 'card-number:4111-XXXX-XXXX-2222 | cvv:222 | exp:02/30 | balance:$0 | region:US', 0),
-- 批量邮箱 单次授权 (sku 158)
(158, 'license:MAIL-2026-X7K8-L2M3-N5P4 | type:single | platforms:gmail+outlook', 0),
-- 批量邮箱 永久授权 (sku 159)
(159, 'license:MAIL-2026-Q5RS-T7UV-W1XY | type:permanent | platforms:gmail+outlook+proton', 0),
-- USDT 50U (sku 161)
(161, 'wallet:TRC20-TXhash2026mN2pQrS4 | amount:50USDT | chain:TRC20', 0),
(161, 'wallet:TRC20-TXhash2026aB3cD5eF | amount:50USDT | chain:TRC20', 0),
-- USDT 100U (sku 162)
(162, 'wallet:TRC20-TXhash2026pQrS4tU6 | amount:100USDT | chain:TRC20', 0),
(162, 'wallet:TRC20-TXhash2026cD5eF7gH | amount:100USDT | chain:TRC20', 0),
-- USDC 10U (sku 163)
(163, 'wallet:ERC20-TXhash2026xK9mN2pQ | amount:10USDC | chain:ERC20', 0),
(163, 'wallet:ERC20-TXhash2026aB3cD5eF | amount:10USDC | chain:ERC20', 0),
-- USDC 50U (sku 164)
(164, 'wallet:ERC20-TXhash2026pQrS4tU6 | amount:50USDC | chain:ERC20', 0),
(164, 'wallet:ERC20-TXhash2026cD5eF7gH | amount:50USDC | chain:ERC20', 0),
-- OKX 邀请码 (sku 166)
(166, 'REF-2026-OKX-XK9M2N | rebate:20% | bonus:blindbox', 0),
(166, 'REF-2026-OKX-AB3C5D | rebate:20% | bonus:blindbox', 0),
-- Bybit 邀请码 (sku 167)
(167, 'REF-2026-BYBIT-XK9M2N | rebate:15% | bonus:newuser', 0),
(167, 'REF-2026-BYBIT-AB3C5D | rebate:15% | bonus:newuser', 0);

-- ========== 统计 ==========
SELECT COUNT(*) AS total, SUM(status=0) AS unsold, SUM(status=1) AS sold FROM card_key;
