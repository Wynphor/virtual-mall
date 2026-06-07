package com.mall.entity;

import java.math.BigDecimal;
import java.util.List;

public class OrderItem {
    private Integer id;
    private Integer orderId;
    private Integer productId;
    private Integer skuId;
    private String productName;
    private String specName;
    private BigDecimal price;
    private Integer quantity;
    // 非数据库字段
    private List<CardKey> cardKeys;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getOrderId() { return orderId; }
    public void setOrderId(Integer orderId) { this.orderId = orderId; }
    public Integer getProductId() { return productId; }
    public void setProductId(Integer productId) { this.productId = productId; }
    public Integer getSkuId() { return skuId; }
    public void setSkuId(Integer skuId) { this.skuId = skuId; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public String getSpecName() { return specName; }
    public void setSpecName(String specName) { this.specName = specName; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    public List<CardKey> getCardKeys() { return cardKeys; }
    public void setCardKeys(List<CardKey> cardKeys) { this.cardKeys = cardKeys; }
}
