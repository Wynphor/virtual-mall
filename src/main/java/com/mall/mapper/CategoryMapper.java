package com.mall.mapper;

import com.mall.entity.Category;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CategoryMapper {
    List<Category> findByParentId(Integer parentId);
    List<Category> findAll();
    Category findById(Integer id);
    int countByParentId(Integer parentId);
    int insert(Category category);
    int update(Category category);
    int deleteById(Integer id);
}
