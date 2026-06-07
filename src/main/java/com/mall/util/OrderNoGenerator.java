package com.mall.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import java.util.concurrent.ThreadLocalRandom;

public class OrderNoGenerator {

    /**
     * 生成订单号：时间戳 + 8位随机字符（UUID片段）
     * 格式：yyyyMMddHHmmssSSS + 8位 hex = 25位
     */
    public static String generate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        String time = sdf.format(new Date());
        // 取 UUID 前 8 位 hex（32 bit 随机性，碰撞概率极低）
        String uuid = UUID.randomUUID().toString().replace("-", "").substring(0, 8);
        return time + uuid;
    }
}
