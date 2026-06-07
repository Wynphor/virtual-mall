package com.mall.service;

import com.mall.entity.Category;
import java.util.List;

public interface CategoryService {
    List<Category> getTopCategories();
    List<Category> getChildren(Integer parentId);
    List<Category> getAllWithChildren();
    Category findById(Integer id);
    boolean save(Category category);
    boolean update(Category category);
    boolean delete(Integer id);
}
