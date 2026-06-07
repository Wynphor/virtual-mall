package com.mall.service.impl;

import com.mall.entity.User;
import com.mall.mapper.UserMapper;
import com.mall.service.UserService;
import com.mall.util.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User login(String username, String password) {
        // 先按用户名查用户，再验证密码（支持 BCrypt + MD5 遗留）
        User user = userMapper.findByUsername(username);
        if (user == null) return null;
        if (!PasswordUtil.verifyPassword(password, user.getPassword())) return null;
        if (user.getStatus() != 1) return null;
        user.setPassword(null);
        return user;
    }

    @Override
    public boolean register(User user) {
        // 检查用户名是否已存在
        if (userMapper.findByUsername(user.getUsername()) != null) {
            return false;
        }
        user.setPassword(PasswordUtil.hashPassword(user.getPassword()));
        user.setStatus(1);
        return userMapper.insert(user) > 0;
    }

    @Override
    public User findByUsername(String username) {
        return userMapper.findByUsername(username);
    }

    @Override
    public User findById(Integer id) {
        return userMapper.findById(id);
    }

    @Override
    public boolean update(User user) {
        return userMapper.update(user) > 0;
    }

    @Override
    public List<User> listUsers(int page, int pageSize) {
        return userMapper.findAll((page - 1) * pageSize, pageSize);
    }

    @Override
    public int countUsers() {
        return userMapper.countAll();
    }
}
