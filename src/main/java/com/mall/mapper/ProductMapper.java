package com.mall.mapper;

import com.mall.entity.Product;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductMapper {
    Product findById(Integer id);
    List<Product> findByCategoryId(@Param("categoryId") Integer categoryId,
                                   @Param("offset") int offset, @Param("limit") int limit);
    List<Product> findByKeyword(@Param("keyword") String keyword,
                                @Param("offset") int offset, @Param("limit") int limit);
    List<Product> findHot(@Param("limit") int limit);
    List<Product> findAll(@Param("offset") int offset, @Param("limit") int limit);
    int countByCategoryId(Integer categoryId);
    int countByKeyword(String keyword);
    int countAll();
    int insert(Product product);
    int update(Product product);
    int deleteById(Integer id);
    int updateSales(@Param("id") Integer id, @Param("count") int count);
}
