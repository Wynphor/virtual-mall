package com.mall.mapper;

import com.mall.entity.Admin;
import org.apache.ibatis.annotations.Param;

public interface AdminMapper {
    Admin findByUsernameAndPassword(@Param("username") String username, @Param("password") String password);
    Admin findByUsername(@Param("username") String username);
}
