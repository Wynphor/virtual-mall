package com.mall.controller.admin;

import com.mall.entity.CardKey;
import com.mall.entity.ProductSku;
import com.mall.service.CardKeyService;
import com.mall.service.ProductService;
import com.mall.mapper.ProductSkuMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/cardkey")
public class AdminCardKeyController {

    @Autowired
    private CardKeyService cardKeyService;
    @Autowired
    private ProductService productService;
    @Autowired
    private ProductSkuMapper productSkuMapper;

    /** 单次导入上限 */
    private static final int MAX_IMPORT_PER_BATCH = 500;

    @GetMapping("/list")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        int pageSize = 20;
        List<CardKey> keys = cardKeyService.findAllWithProduct(page, pageSize);
        model.addAttribute("keys", keys);
        model.addAttribute("page", page);
        model.addAttribute("totalPage", (cardKeyService.countAll() + pageSize - 1) / pageSize);
        return "admin/cardkey/list";
    }

    @GetMapping("/add")
    public String addPage(Model model) {
        // 加载所有商品的规格供选择
        model.addAttribute("products", productService.getAllProductsWithSku());
        return "admin/cardkey/add";
    }

    @PostMapping("/save")
    @Transactional
    public String save(@RequestParam("skuId") Integer skuId,
                       @RequestParam("content") String content,
                       RedirectAttributes ra) {
        String[] lines = content.split("\\n");

        // 数量上限检查
        int validCount = 0;
        for (String line : lines) {
            if (!line.trim().isEmpty()) validCount++;
        }
        if (validCount > MAX_IMPORT_PER_BATCH) {
            ra.addFlashAttribute("msg", "单次导入不能超过 " + MAX_IMPORT_PER_BATCH + " 条卡密");
            return "redirect:/admin/cardkey/add";
        }

        int count = 0;
        int skipped = 0;
        // 一次性加载该 SKU 所有卡密用于去重（避免循环内重复查询）
        List<CardKey> existing = cardKeyService.findBySkuId(skuId);
        for (String line : lines) {
            String key = line.trim();
            if (!key.isEmpty()) {
                boolean duplicate = existing.stream().anyMatch(k -> k.getContent().equals(key));
                if (duplicate) {
                    skipped++;
                    continue;
                }
                CardKey cardKey = new CardKey();
                cardKey.setSkuId(skuId);
                cardKey.setContent(key);
                cardKeyService.addCardKey(cardKey);
                count++;
            }
        }
        // 同步更新SKU库存
        if (count > 0) {
            productSkuMapper.increaseStock(skuId, count);
        }
        String msg = "成功导入 " + count + " 条卡密";
        if (skipped > 0) msg += "，跳过重复 " + skipped + " 条";
        ra.addFlashAttribute("msg", msg);
        return "redirect:/admin/cardkey/list";
    }

    @GetMapping("/freeze/{id}")
    public String freeze(@PathVariable("id") Integer id, RedirectAttributes ra) {
        cardKeyService.freezeKey(id);
        ra.addFlashAttribute("msg", "已冻结");
        return "redirect:/admin/cardkey/list";
    }

    @GetMapping("/unfreeze/{id}")
    public String unfreeze(@PathVariable("id") Integer id, RedirectAttributes ra) {
        cardKeyService.unfreezeKey(id);
        ra.addFlashAttribute("msg", "已解冻");
        return "redirect:/admin/cardkey/list";
    }
}
