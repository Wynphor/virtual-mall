package com.mall.util;

import at.favre.lib.crypto.bcrypt.BCrypt;
import java.security.MessageDigest;

/**
 * 密码工具类：BCrypt 哈希 + MD5 遗留兼容
 */
public class PasswordUtil {

    /**
     * 使用 BCrypt 哈希密码
     */
    public static String hashPassword(String plainPassword) {
        return BCrypt.withDefaults().hashToString(12, plainPassword.toCharArray());
    }

    /**
     * 验证密码：先尝试 BCrypt，再尝试 MD5 遗留哈希
     * 用于登录时兼容旧密码
     */
    public static boolean verifyPassword(String plainPassword, String storedHash) {
        if (storedHash == null || plainPassword == null) {
            return false;
        }
        // BCrypt hash 以 $2a$ 或 $2b$ 开头
        if (storedHash.startsWith("$2a$") || storedHash.startsWith("$2b$")) {
            BCrypt.Result result = BCrypt.verifyer().verify(
                    plainPassword.toCharArray(), storedHash);
            return result.verified;
        }
        // 遗留 MD5 哈希回退验证
        return storedHash.equals(md5(plainPassword));
    }

    /**
     * 检查是否为 BCrypt 哈希
     */
    public static boolean isBcryptHash(String hash) {
        return hash != null && (hash.startsWith("$2a$") || hash.startsWith("$2b$"));
    }

    /**
     * MD5 哈希（仅用于遗留密码迁移兼容）
     */
    private static String md5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] digest = md.digest(input.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) {
                sb.append(String.format("%02x", b & 0xff));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("MD5算法不可用", e);
        }
    }
}
