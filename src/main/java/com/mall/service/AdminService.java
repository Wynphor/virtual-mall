package com.mall.service;

import com.mall.entity.Admin;

public interface AdminService {
    Admin login(String username, String password);
}
