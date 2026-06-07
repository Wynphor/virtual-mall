package com.mall.service.impl;

import com.mall.dto.ProductQueryDTO;
import com.mall.entity.Product;
import com.mall.entity.ProductSku;
import com.mall.mapper.ProductMapper;
import com.mall.mapper.ProductSkuMapper;
import com.mall.mapper.CardKeyMapper;
import com.mall.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private ProductSkuMapper productSkuMapper;
    @Autowired
    private CardKeyMapper cardKeyMapper;

    @Override
    public Product findById(Integer id) {
        Product p = productMapper.findById(id);
        if (p != null) {
            p.setSkuList(productSkuMapper.findByProductId(id));
        }
        return p;
    }

    @Override
    public List<Product> getHotProducts(int limit) {
        return productMapper.findHot(limit);
    }

    @Override
    public List<Product> getAllProductsWithSku() {
        List<Product> products = productMapper.findAll(0, 9999);
        for (Product p : products) {
            p.setSkuList(productSkuMapper.findByProductId(p.getId()));
        }
        return products;
    }

    @Override
    public List<Product> queryProducts(ProductQueryDTO query) {
        int offset = (query.getPage() - 1) * query.getPageSize();
        if (query.getKeyword() != null && !query.getKeyword().trim().isEmpty()) {
            return productMapper.findByKeyword(query.getKeyword().trim(), offset, query.getPageSize());
        } else if (query.getCategoryId() != null) {
            return productMapper.findByCategoryId(query.getCategoryId(), offset, query.getPageSize());
        }
        return productMapper.findAll(offset, query.getPageSize());
    }

    @Override
    public int countByCategoryId(Integer categoryId) {
        return productMapper.countByCategoryId(categoryId);
    }

    @Override
    public int countByKeyword(String keyword) {
        return productMapper.countByKeyword(keyword);
    }

    @Override
    public int countAll() {
        return productMapper.countAll();
    }

    @Override
    public boolean save(Product product) {
        product.setSales(0);
        product.setStatus(1);
        return productMapper.insert(product) > 0;
    }

    @Override
    public boolean update(Product product) {
        return productMapper.update(product) > 0;
    }

    @Override
    public boolean delete(Integer id) {
        // 检查是否有规格
        List<ProductSku> skus = productSkuMapper.findByProductId(id);
        if (skus != null && !skus.isEmpty()) {
            throw new RuntimeException("该商品下有规格，请先删除规格");
        }
        return productMapper.deleteById(id) > 0;
    }

    @Override
    public List<ProductSku> getSkusByProductId(Integer productId) {
        return productSkuMapper.findByProductId(productId);
    }

    @Override
    public ProductSku findSkuById(Integer id) {
        return productSkuMapper.findById(id);
    }

    @Override
    public boolean saveSku(ProductSku sku) {
        sku.setStatus(1);
        return productSkuMapper.insert(sku) > 0;
    }

    @Override
    public boolean updateSku(ProductSku sku) {
        return productSkuMapper.update(sku) > 0;
    }

    @Override
    public boolean deleteSku(Integer id) {
        if (!cardKeyMapper.findBySkuId(id).isEmpty()) {
            return false; // 该规格下有卡密，不允许删除
        }
        return productSkuMapper.deleteById(id) > 0;
    }
}
