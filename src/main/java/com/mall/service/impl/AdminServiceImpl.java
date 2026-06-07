package com.mall.service.impl;

import com.mall.entity.Admin;
import com.mall.mapper.AdminMapper;
import com.mall.service.AdminService;
import com.mall.util.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public Admin login(String username, String password) {
        // 先按用户名查管理员，再验证密码（支持 BCrypt + MD5 遗留）
        Admin admin = adminMapper.findByUsername(username);
        if (admin == null) return null;
        if (!PasswordUtil.verifyPassword(password, admin.getPassword())) return null;
        return admin;
    }
}
