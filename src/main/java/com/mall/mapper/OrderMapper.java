package com.mall.mapper;

import com.mall.entity.Order;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderMapper {
    int insert(Order order);
    Order findByOrderNo(String orderNo);
    Order findById(Integer id);
    List<Order> findByUserId(@Param("userId") Integer userId,
                             @Param("offset") int offset, @Param("limit") int limit);
    int countByUserId(Integer userId);
    List<Order> findByContact(@Param("contact") String contact);
    List<Order> findAll(@Param("offset") int offset, @Param("limit") int limit);
    List<Order> findByStatus(@Param("status") Integer status,
                             @Param("offset") int offset, @Param("limit") int limit);
    int countAll();
    int countByStatus(Integer status);
    int updateStatus(@Param("id") Integer id, @Param("status") Integer status, @Param("expectedStatus") Integer expectedStatus);
    int updatePayTime(@Param("id") Integer id);
}
