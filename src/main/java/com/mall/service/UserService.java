package com.mall.service;

import com.mall.entity.User;

public interface UserService {
    User login(String username, String password);
    boolean register(User user);
    User findByUsername(String username);
    User findById(Integer id);
    boolean update(User user);
    java.util.List<User> listUsers(int page, int pageSize);
    int countUsers();
}
