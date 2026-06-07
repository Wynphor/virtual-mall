package com.mall.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class Order {
    public static final int STATUS_UNPAID = 0;
    public static final int STATUS_COMPLETED = 2;
    public static final int STATUS_CANCELLED = 3;

    private Integer id;
    private String orderNo;
    private Integer userId;
    private String contact;
    private BigDecimal totalPrice;
    private Integer status;
    private Date createTime;
    private Date payTime;
    private String queryPassword;
    private String payMethod;
    // 非数据库字段
    private List<OrderItem> items;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getOrderNo() { return orderNo; }
    public void setOrderNo(String orderNo) { this.orderNo = orderNo; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }
    public BigDecimal getTotalPrice() { return totalPrice; }
    public void setTotalPrice(BigDecimal totalPrice) { this.totalPrice = totalPrice; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public Date getPayTime() { return payTime; }
    public void setPayTime(Date payTime) { this.payTime = payTime; }
    public String getQueryPassword() { return queryPassword; }
    public void setQueryPassword(String queryPassword) { this.queryPassword = queryPassword; }
    public String getPayMethod() { return payMethod; }
    public void setPayMethod(String payMethod) { this.payMethod = payMethod; }
    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) { this.items = items; }

    public String getStatusText() {
        switch (status) {
            case 0: return "待支付";
            case 2: return "已完成";
            case 3: return "已取消";
            default: return "未知";
        }
    }
}
