package com.mall.service.impl;

import com.mall.entity.Category;
import com.mall.mapper.CategoryMapper;
import com.mall.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public List<Category> getTopCategories() {
        return categoryMapper.findByParentId(0);
    }

    @Override
    public List<Category> getChildren(Integer parentId) {
        return categoryMapper.findByParentId(parentId);
    }

    @Override
    public List<Category> getAllWithChildren() {
        List<Category> all = categoryMapper.findAll();
        // 分离一级和二级
        List<Category> top = all.stream()
                .filter(c -> Integer.valueOf(0).equals(c.getParentId()))
                .collect(Collectors.toList());
        for (Category parent : top) {
            List<Category> children = all.stream()
                    .filter(c -> c.getParentId().equals(parent.getId()))
                    .collect(Collectors.toList());
            parent.setChildren(children);
        }
        return top;
    }

    @Override
    public Category findById(Integer id) {
        return categoryMapper.findById(id);
    }

    @Override
    public boolean save(Category category) {
        return categoryMapper.insert(category) > 0;
    }

    @Override
    public boolean update(Category category) {
        return categoryMapper.update(category) > 0;
    }

    @Override
    public boolean delete(Integer id) {
        // 检查是否有子分类
        if (categoryMapper.countByParentId(id) > 0) {
            throw new RuntimeException("该分类下有子分类，无法删除");
        }
        return categoryMapper.deleteById(id) > 0;
    }
}
