package com.mall.mapper;

import com.mall.entity.OrderItem;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderItemMapper {
    int insert(OrderItem item);
    List<OrderItem> findByOrderId(Integer orderId);
    OrderItem findById(Integer id);
}
