package com.mall.service;

import com.mall.entity.Order;
import com.mall.entity.OrderItem;
import java.util.List;

public interface OrderService {
    Order createOrder(Integer userId, Integer skuId, Integer quantity, String contact, String queryPassword, String payMethod);
    Order findByOrderNo(String orderNo);
    Order findById(Integer id);
    List<Order> findByUserId(Integer userId, int page, int pageSize);
    int countByUserId(Integer userId);
    List<Order> findByContact(String contact);
    List<Order> findAll(int page, int pageSize);
    List<Order> findByStatus(Integer status, int page, int pageSize);
    int countAll();
    int countByStatus(Integer status);
    boolean userConfirmPay(String orderNo);
    boolean adminConfirmPay(Integer orderId);
    boolean cancelOrder(Integer orderId);
    List<OrderItem> getOrderItems(Integer orderId);
}
