package com.mall.controller.admin;

import com.mall.entity.Category;
import com.mall.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/category")
public class AdminCategoryController {

    @Autowired
    private CategoryService categoryService;

    @GetMapping("/list")
    public String list(Model model) {
        List<Category> categories = categoryService.getAllWithChildren();
        model.addAttribute("categories", categories);
        return "admin/category/list";
    }

    @GetMapping("/add")
    public String addPage(@RequestParam(value = "parentId", defaultValue = "0") int parentId, Model model) {
        model.addAttribute("parentId", parentId);
        // 查询所有一级分类供选择
        model.addAttribute("topCategories", categoryService.getTopCategories());
        return "admin/category/edit";
    }

    @PostMapping("/save")
    public String save(Category category, RedirectAttributes ra) {
        if (categoryService.save(category)) {
            ra.addFlashAttribute("msg", "添加成功");
        } else {
            ra.addFlashAttribute("msg", "添加失败");
        }
        return "redirect:/admin/category/list";
    }

    @GetMapping("/edit/{id}")
    public String editPage(@PathVariable("id") Integer id, Model model) {
        model.addAttribute("category", categoryService.findById(id));
        model.addAttribute("topCategories", categoryService.getTopCategories());
        return "admin/category/edit";
    }

    @PostMapping("/update")
    public String update(Category category, RedirectAttributes ra) {
        if (categoryService.update(category)) {
            ra.addFlashAttribute("msg", "修改成功");
        }
        return "redirect:/admin/category/list";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable("id") Integer id, RedirectAttributes ra) {
        try {
            categoryService.delete(id);
            ra.addFlashAttribute("msg", "删除成功");
        } catch (RuntimeException e) {
            ra.addFlashAttribute("msg", e.getMessage());
        }
        return "redirect:/admin/category/list";
    }
}
