package com.mall.service;

import com.mall.dto.ProductQueryDTO;
import com.mall.entity.Product;
import com.mall.entity.ProductSku;

import java.util.List;

public interface ProductService {
    Product findById(Integer id);
    List<Product> getHotProducts(int limit);
    List<Product> getAllProductsWithSku();
    List<Product> queryProducts(ProductQueryDTO query);
    int countByCategoryId(Integer categoryId);
    int countByKeyword(String keyword);
    int countAll();
    boolean save(Product product);
    boolean update(Product product);
    boolean delete(Integer id);
    List<ProductSku> getSkusByProductId(Integer productId);
    ProductSku findSkuById(Integer id);
    boolean saveSku(ProductSku sku);
    boolean updateSku(ProductSku sku);
    boolean deleteSku(Integer id);
}
