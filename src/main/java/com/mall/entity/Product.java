package com.mall.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class Product {
    private Integer id;
    private String name;
    private Integer categoryId;
    private String description;
    private String image;
    private BigDecimal price;
    private Integer sales;
    private Integer status;
    private Date createTime;
    // 非数据库字段
    private String categoryName;
    private Category category;
    private List<ProductSku> skuList;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public Integer getCategoryId() { return categoryId; }
    public void setCategoryId(Integer categoryId) { this.categoryId = categoryId; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public Integer getSales() { return sales; }
    public void setSales(Integer sales) { this.sales = sales; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
    public List<ProductSku> getSkuList() { return skuList; }
    public void setSkuList(List<ProductSku> skuList) { this.skuList = skuList; }
}
