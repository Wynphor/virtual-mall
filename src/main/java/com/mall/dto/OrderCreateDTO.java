package com.mall.dto;

import java.math.BigDecimal;
import java.util.List;

public class OrderCreateDTO {
    private Integer skuId;
    private Integer quantity;
    private String contact;

    public Integer getSkuId() { return skuId; }
    public void setSkuId(Integer skuId) { this.skuId = skuId; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }
}
