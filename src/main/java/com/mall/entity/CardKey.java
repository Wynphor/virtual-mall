package com.mall.entity;

import java.util.Date;

public class CardKey {
    public static final int STATUS_UNSOLD = 0;
    public static final int STATUS_SOLD = 1;
    public static final int STATUS_FROZEN = 2;

    private Integer id;
    private Integer skuId;
    private String content;
    private Integer status;
    private Integer orderItemId;
    private Date addTime;
    private Date sellTime;
    // 非数据库字段
    private String specName;
    private String productName;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getSkuId() { return skuId; }
    public void setSkuId(Integer skuId) { this.skuId = skuId; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Integer getOrderItemId() { return orderItemId; }
    public void setOrderItemId(Integer orderItemId) { this.orderItemId = orderItemId; }
    public Date getAddTime() { return addTime; }
    public void setAddTime(Date addTime) { this.addTime = addTime; }
    public Date getSellTime() { return sellTime; }
    public void setSellTime(Date sellTime) { this.sellTime = sellTime; }
    public String getSpecName() { return specName; }
    public void setSpecName(String specName) { this.specName = specName; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getStatusText() {
        switch (status) {
            case 0: return "未售";
            case 1: return "已售";
            case 2: return "冻结";
            default: return "未知";
        }
    }
}
