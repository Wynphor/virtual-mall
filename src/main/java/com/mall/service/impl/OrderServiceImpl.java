package com.mall.service.impl;

import com.mall.entity.*;
import com.mall.mapper.CardKeyMapper;
import com.mall.mapper.OrderItemMapper;
import com.mall.mapper.OrderMapper;
import com.mall.mapper.ProductMapper;
import com.mall.mapper.ProductSkuMapper;
import com.mall.service.CardKeyService;
import com.mall.service.OrderService;
import com.mall.util.OrderNoGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private OrderItemMapper orderItemMapper;
    @Autowired
    private ProductSkuMapper productSkuMapper;
    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private CardKeyService cardKeyService;
    @Autowired
    private CardKeyMapper cardKeyMapper;

    @Override
    @Transactional
    public Order createOrder(Integer userId, Integer skuId, Integer quantity, String contact, String queryPassword, String payMethod) {
        // 1. 查询SKU
        ProductSku sku = productSkuMapper.findById(skuId);
        if (sku == null || sku.getStatus() != 1) {
            throw new RuntimeException("商品规格不存在或已下架");
        }
        // 2. 检查卡密库存
        int available = cardKeyService.getAvailableStock(skuId);
        if (available < quantity) {
            throw new RuntimeException("库存不足，当前库存: " + available);
        }
        // 3. 查询商品
        Product product = productMapper.findById(sku.getProductId());
        if (product == null) {
            throw new RuntimeException("商品不存在或已下架");
        }
        // 4. 创建订单
        BigDecimal totalPrice = sku.getPrice().multiply(new BigDecimal(quantity));
        Order order = new Order();
        order.setOrderNo(OrderNoGenerator.generate());
        order.setUserId(userId);
        order.setContact(contact);
        order.setTotalPrice(totalPrice);
        order.setStatus(Order.STATUS_UNPAID);
        order.setQueryPassword(queryPassword);
        order.setPayMethod(payMethod);
        orderMapper.insert(order);
        // 5. 创建订单明细
        OrderItem item = new OrderItem();
        item.setOrderId(order.getId());
        item.setProductId(product.getId());
        item.setSkuId(skuId);
        item.setProductName(product.getName());
        item.setSpecName(sku.getSpecName());
        item.setPrice(sku.getPrice());
        item.setQuantity(quantity);
        orderItemMapper.insert(item);
        // 返回完整订单
        order.setId(order.getId());
        return order;
    }

    @Override
    public Order findByOrderNo(String orderNo) {
        Order order = orderMapper.findByOrderNo(orderNo);
        if (order != null) {
            order.setItems(orderItemMapper.findByOrderId(order.getId()));
        }
        return order;
    }

    @Override
    public Order findById(Integer id) {
        Order order = orderMapper.findById(id);
        if (order != null) {
            order.setItems(orderItemMapper.findByOrderId(order.getId()));
        }
        return order;
    }

    @Override
    public List<Order> findByUserId(Integer userId, int page, int pageSize) {
        List<Order> orders = orderMapper.findByUserId(userId, (page - 1) * pageSize, pageSize);
        for (Order o : orders) {
            o.setItems(orderItemMapper.findByOrderId(o.getId()));
        }
        return orders;
    }

    @Override
    public int countByUserId(Integer userId) {
        return orderMapper.countByUserId(userId);
    }

    @Override
    public List<Order> findByContact(String contact) {
        List<Order> orders = orderMapper.findByContact(contact);
        for (Order o : orders) {
            o.setItems(orderItemMapper.findByOrderId(o.getId()));
        }
        return orders;
    }

    @Override
    public List<Order> findAll(int page, int pageSize) {
        List<Order> orders = orderMapper.findAll((page - 1) * pageSize, pageSize);
        for (Order o : orders) {
            o.setItems(orderItemMapper.findByOrderId(o.getId()));
        }
        return orders;
    }

    @Override
    public List<Order> findByStatus(Integer status, int page, int pageSize) {
        List<Order> orders = orderMapper.findByStatus(status, (page - 1) * pageSize, pageSize);
        for (Order o : orders) {
            o.setItems(orderItemMapper.findByOrderId(o.getId()));
        }
        return orders;
    }

    @Override
    public int countAll() {
        return orderMapper.countAll();
    }

    @Override
    public int countByStatus(Integer status) {
        return orderMapper.countByStatus(status);
    }

    @Override
    @Transactional
    public boolean userConfirmPay(String orderNo) {
        Order order = orderMapper.findByOrderNo(orderNo);
        if (order == null || order.getStatus() != Order.STATUS_UNPAID) {
            return false;
        }
        // 用户确认付款，自动完成发货
        List<OrderItem> items = orderItemMapper.findByOrderId(order.getId());
        for (OrderItem item : items) {
            // 分配卡密
            List<CardKey> keys = cardKeyService.allocateKeys(
                    item.getSkuId(), item.getQuantity(), item.getId());
            if (keys.size() < item.getQuantity()) {
                throw new RuntimeException("卡密库存不足，发货失败");
            }
            // 更新销量
            productMapper.updateSales(item.getProductId(), item.getQuantity());
            // 扣减SKU库存
            productSkuMapper.decreaseStock(item.getSkuId(), item.getQuantity());
        }
        // 订单直接完成
        orderMapper.updateStatus(order.getId(), Order.STATUS_COMPLETED, Order.STATUS_UNPAID);
        orderMapper.updatePayTime(order.getId());
        return true;
    }

    @Override
    @Transactional
    public boolean adminConfirmPay(Integer orderId) {
        Order order = orderMapper.findById(orderId);
        if (order == null || order.getStatus() != Order.STATUS_UNPAID) {
            return false;
        }
        // 管理员确认，自动发货
        List<OrderItem> items = orderItemMapper.findByOrderId(orderId);
        for (OrderItem item : items) {
            // 分配卡密
            List<CardKey> keys = cardKeyService.allocateKeys(
                    item.getSkuId(), item.getQuantity(), item.getId());
            if (keys.size() < item.getQuantity()) {
                throw new RuntimeException("卡密库存不足，发货失败");
            }
            // 更新销量
            productMapper.updateSales(item.getProductId(), item.getQuantity());
            // 扣减SKU库存
            productSkuMapper.decreaseStock(item.getSkuId(), item.getQuantity());
        }
        // 订单状态变为已完成
        orderMapper.updateStatus(orderId, Order.STATUS_COMPLETED, Order.STATUS_UNPAID);
        orderMapper.updatePayTime(orderId);
        return true;
    }

    @Override
    @Transactional
    public boolean cancelOrder(Integer orderId) {
        Order order = orderMapper.findById(orderId);
        if (order == null || order.getStatus() >= Order.STATUS_COMPLETED) {
            return false;
        }
        // 取消订单，释放可能已分配的卡密和库存
        List<OrderItem> items = orderItemMapper.findByOrderId(orderId);
        for (OrderItem item : items) {
            // 如果已分配卡密，释放回未售状态
            List<CardKey> keys = cardKeyService.findByOrderItemId(item.getId());
            if (keys != null && !keys.isEmpty()) {
                List<Integer> keyIds = keys.stream().map(CardKey::getId).collect(Collectors.toList());
                cardKeyMapper.batchUpdateStatus(keyIds, CardKey.STATUS_UNSOLD, null, CardKey.STATUS_SOLD);
            }
            // 恢复SKU库存
            productSkuMapper.increaseStock(item.getSkuId(), item.getQuantity());
        }
        return orderMapper.updateStatus(orderId, Order.STATUS_CANCELLED, order.getStatus()) > 0;
    }

    @Override
    public List<OrderItem> getOrderItems(Integer orderId) {
        List<OrderItem> items = orderItemMapper.findByOrderId(orderId);
        // 为每个item加载卡密
        for (OrderItem item : items) {
            item.setCardKeys(cardKeyService.findByOrderItemId(item.getId()));
        }
        return items;
    }
}
