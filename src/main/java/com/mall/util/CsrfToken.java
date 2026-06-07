package com.mall.util;

import java.security.SecureRandom;

/**
 * CSRF Token 生成与验证工具
 */
public class CsrfToken {

    private static final String SESSION_KEY = "_csrf_token";
    private static final String FORM_FIELD = "_csrf";
    private static final SecureRandom RANDOM = new SecureRandom();

    /** 生成随机 Token（64 字符 hex） */
    public static String generate() {
        byte[] bytes = new byte[32];
        RANDOM.nextBytes(bytes);
        StringBuilder sb = new StringBuilder(64);
        for (byte b : bytes) {
            sb.append(String.format("%02x", b & 0xff));
        }
        return sb.toString();
    }

    /** Session 中存储的 key */
    public static String sessionKey() {
        return SESSION_KEY;
    }

    /** 表单隐藏字段名 */
    public static String formField() {
        return FORM_FIELD;
    }

    /** 验证请求中的 token 是否与 session 中一致 */
    public static boolean validate(jakarta.servlet.http.HttpSession session, String submittedToken) {
        if (submittedToken == null || submittedToken.isEmpty()) {
            return false;
        }
        String sessionToken = (String) session.getAttribute(SESSION_KEY);
        if (sessionToken == null) {
            return false;
        }
        return java.security.MessageDigest.isEqual(
                sessionToken.getBytes(java.nio.charset.StandardCharsets.UTF_8),
                submittedToken.getBytes(java.nio.charset.StandardCharsets.UTF_8));
    }
}
