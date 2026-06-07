package com.mall.controller.admin;

import com.mall.entity.CardKey;
import com.mall.entity.Category;
import com.mall.entity.Product;
import com.mall.entity.ProductSku;
import com.mall.mapper.CardKeyMapper;
import com.mall.service.CategoryService;
import com.mall.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/product")
public class AdminProductController {

    @Autowired
    private ProductService productService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private CardKeyMapper cardKeyMapper;

    @GetMapping("/list")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        int pageSize = 10;
        List<Product> products = productService.queryProducts(
                new com.mall.dto.ProductQueryDTO() {{
                    setPage(page);
                    setPageSize(pageSize);
                }});
        model.addAttribute("products", products);
        model.addAttribute("page", page);
        model.addAttribute("totalPage", (productService.countAll() + pageSize - 1) / pageSize);
        return "admin/product/list";
    }

    @GetMapping("/add")
    public String addPage(Model model) {
        model.addAttribute("categories", categoryService.getAllWithChildren());
        return "admin/product/edit";
    }

    @PostMapping("/save")
    public String save(Product product, RedirectAttributes ra) {
        if (productService.save(product)) {
            ra.addFlashAttribute("msg", "添加成功");
        }
        return "redirect:/admin/product/list";
    }

    @GetMapping("/edit/{id}")
    public String editPage(@PathVariable("id") Integer id, Model model) {
        model.addAttribute("product", productService.findById(id));
        model.addAttribute("categories", categoryService.getAllWithChildren());
        return "admin/product/edit";
    }

    @PostMapping("/update")
    public String update(Product product, RedirectAttributes ra) {
        productService.update(product);
        ra.addFlashAttribute("msg", "修改成功");
        return "redirect:/admin/product/list";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable("id") Integer id, RedirectAttributes ra) {
        try {
            productService.delete(id);
            ra.addFlashAttribute("msg", "删除成功");
        } catch (RuntimeException e) {
            ra.addFlashAttribute("msg", e.getMessage());
        }
        return "redirect:/admin/product/list";
    }

    /** 规格管理 */
    @GetMapping("/{productId}/sku/list")
    public String skuList(@PathVariable("productId") Integer productId, Model model) {
        model.addAttribute("product", productService.findById(productId));
        List<ProductSku> skus = productService.getSkusByProductId(productId);
        // 用实际未售卡密数覆盖stock显示值，确保与卡密数一致
        for (ProductSku sku : skus) {
            sku.setStock(cardKeyMapper.countBySkuIdAndStatus(sku.getId(), CardKey.STATUS_UNSOLD));
        }
        model.addAttribute("skus", skus);
        return "admin/product/sku_list";
    }

    @GetMapping("/{productId}/sku/add")
    public String skuAddPage(@PathVariable("productId") Integer productId, Model model) {
        model.addAttribute("productId", productId);
        return "admin/product/sku_edit";
    }

    /** 统一处理规格添加和编辑 */
    @PostMapping("/sku/save")
    public String skuSave(ProductSku sku, RedirectAttributes ra) {
        if (sku.getId() != null) {
            // 编辑时不允许修改stock，保持由卡密数自动决定
            ProductSku existing = productService.findSkuById(sku.getId());
            if (existing != null) sku.setStock(existing.getStock());
            productService.updateSku(sku);
            ra.addFlashAttribute("msg", "规格修改成功");
        } else {
            // 新增规格，库存为0（需导入卡密才有库存）
            sku.setStock(0);
            productService.saveSku(sku);
            ra.addFlashAttribute("msg", "规格添加成功");
        }
        return "redirect:/admin/product/" + sku.getProductId() + "/sku/list";
    }

    @GetMapping("/sku/edit/{id}")
    public String skuEditPage(@PathVariable("id") Integer id, Model model) {
        model.addAttribute("sku", productService.findSkuById(id));
        return "admin/product/sku_edit";
    }

    @PostMapping("/sku/delete/{id}")
    public String skuDelete(@PathVariable("id") Integer id, @RequestParam("productId") Integer productId, RedirectAttributes ra) {
        productService.deleteSku(id);
        ra.addFlashAttribute("msg", "规格删除成功");
        return "redirect:/admin/product/" + productId + "/sku/list";
    }
}
