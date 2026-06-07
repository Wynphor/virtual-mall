package com.mall.entity;

import java.math.BigDecimal;

public class ProductSku {
    private Integer id;
    private Integer productId;
    private String specName;
    private BigDecimal price;
    private Integer stock;
    private Integer status;
    // 非数据库字段
    private String productName;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getProductId() { return productId; }
    public void setProductId(Integer productId) { this.productId = productId; }
    public String getSpecName() { return specName; }
    public void setSpecName(String specName) { this.specName = specName; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public Integer getStock() { return stock; }
    public void setStock(Integer stock) { this.stock = stock; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
}
