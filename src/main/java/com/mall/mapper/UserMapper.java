package com.mall.mapper;

import com.mall.entity.User;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {
    User findByUsername(String username);
    User findByUsernameAndPassword(@Param("username") String username, @Param("password") String password);
    User findById(Integer id);
    int insert(User user);
    int update(User user);
    int countAll();
    java.util.List<User> findAll(@Param("offset") int offset, @Param("limit") int limit);
}
