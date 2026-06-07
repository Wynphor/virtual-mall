package com.mall.controller.shop;

import com.mall.dto.ProductQueryDTO;
import com.mall.entity.Category;
import com.mall.entity.Product;
import com.mall.service.CategoryService;
import com.mall.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class ProductController {

    @Autowired
    private ProductService productService;
    @Autowired
    private CategoryService categoryService;

    /** 首页 */
    @GetMapping({"/", "/index"})
    public String index(Model model) {
        List<Category> categories = categoryService.getAllWithChildren();
        List<Product> hotProducts = productService.getHotProducts(8);
        // 为每个热销商品加载SKU列表（用于库存显示）
        for (Product p : hotProducts) {
            p.setSkuList(productService.getSkusByProductId(p.getId()));
        }
        model.addAttribute("categories", categories);
        model.addAttribute("hotProducts", hotProducts);
        return "front/index";
    }

    /** 商品列表 */
    @GetMapping("/product/list")
    public String productList(@RequestParam(value = "categoryId", required = false) Integer categoryId,
                              @RequestParam(value = "keyword", required = false) String keyword,
                              @RequestParam(value = "page", defaultValue = "1") int page,
                              Model model) {
        ProductQueryDTO query = new ProductQueryDTO();
        query.setCategoryId(categoryId);
        query.setKeyword(keyword);
        query.setPage(page);

        List<Product> products = productService.queryProducts(query);
        // 为每个商品加载SKU列表（用于库存显示和售罄判断）
        for (Product p : products) {
            p.setSkuList(productService.getSkusByProductId(p.getId()));
        }
        int total = 0;
        if (keyword != null && !keyword.trim().isEmpty()) {
            total = productService.countByKeyword(keyword);
        } else if (categoryId != null) {
            total = productService.countByCategoryId(categoryId);
        } else {
            total = productService.countAll();
        }

        List<Category> categories = categoryService.getAllWithChildren();

        model.addAttribute("products", products);
        model.addAttribute("categories", categories);
        model.addAttribute("categoryId", categoryId);
        model.addAttribute("keyword", keyword);
        model.addAttribute("page", page);
        model.addAttribute("totalPage", (total + query.getPageSize() - 1) / query.getPageSize());
        return "front/product/list";
    }

    /** 商品详情 */
    @GetMapping("/product/detail/{id}")
    public String productDetail(@PathVariable("id") Integer id, Model model) {
        Product product = productService.findById(id);
        if (product == null) {
            return "redirect:/product/list";
        }
        List<Category> categories = categoryService.getAllWithChildren();
        model.addAttribute("product", product);
        model.addAttribute("categories", categories);
        return "front/product/detail";
    }
}
