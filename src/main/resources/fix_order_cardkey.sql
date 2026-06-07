USE virtual_mall;

-- 修复已售卡密的 sku_id 和 order_item_id，使其与 order_item 对应

-- order_item 1: ChatGPT Plus 日抛(sku=4)
UPDATE card_key SET sku_id=4, order_item_id=1 WHERE id=115;

-- order_item 2: Kimi 月抛(sku=22) → 卡密改为 kimi 格式
UPDATE card_key SET sku_id=22, content='account:kimi-sold-001@qq.com | password:Ki@2026sO1l', order_item_id=2 WHERE id=125;

-- order_item 3: Midjourney Pro月卡(sku=27) → 卡密改为 midjourney 格式
UPDATE card_key SET sku_id=27, content='account:mj-pro-sold-001@gmail.com | password:Mj@2026sO1l | plan:pro', order_item_id=3 WHERE id=130;

-- order_item 4: Claude Pro 月抛(sku=9) → 修正 sku_id
UPDATE card_key SET sku_id=9, order_item_id=4 WHERE id=182;

-- 删除不对应的旧卡密 (gpt-free-sold, sku=1，没有对应订单)
DELETE FROM card_key WHERE id=114;

-- 为其他已完成订单补充示例卡密并关联
INSERT INTO card_key (sku_id, content, status, order_item_id) VALUES
-- order_item 5: SSM管理系统 外卖点餐(sku=128)
(128, 'download:https://pan.example.com/s/ssm-takeout | code:st02 | readme:included', 1, 5),
-- order_item 6: Claude Code 基础版(sku=134)
(134, 'download:https://pan.example.com/s/claude-code-sold | code:cc02 | format:pdf+code', 1, 6),
-- order_item 7: 机场年卡基础版(sku=57)
(57, 'subscribe-url:https://sub.example.com/link/sold01 | traffic:100GB | expire:365days', 1, 7),
-- order_item 8: SpringBoot 个人博客(sku=114)
(114, 'download:https://pan.example.com/s/sb-blog-sold | code:sb02 | readme:included', 1, 8);

-- 修复 order_item 的 sku_id 和 spec_name，使其与实际商品对应
UPDATE order_item SET sku_id=5, spec_name='月抛（土区）' WHERE id=1;
UPDATE order_item SET sku_id=21, spec_name='日抛' WHERE id=2;
UPDATE order_item SET sku_id=34, spec_name='月抛' WHERE id=3;

-- 验证
SELECT oi.id, oi.order_id, oi.sku_id AS item_sku, ck.sku_id AS ck_sku, ck.order_item_id, LEFT(ck.content,45) AS content, ck.status
FROM order_item oi
LEFT JOIN card_key ck ON ck.order_item_id=oi.id
ORDER BY oi.order_id, oi.id;
