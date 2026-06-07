package com.mall.mapper;

import com.mall.entity.ProductSku;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductSkuMapper {
    List<ProductSku> findByProductId(Integer productId);
    ProductSku findById(Integer id);
    int insert(ProductSku sku);
    int update(ProductSku sku);
    int deleteById(Integer id);
    int decreaseStock(@Param("id") Integer id, @Param("count") int count);
    int increaseStock(@Param("id") Integer id, @Param("count") int count);
}
