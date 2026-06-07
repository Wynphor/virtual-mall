package com.mall.controller.admin;

import com.mall.entity.Order;
import com.mall.entity.OrderItem;
import com.mall.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/order")
public class AdminOrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/list")
    public String list(@RequestParam(value = "status", required = false) Integer status,
                       @RequestParam(value = "page", defaultValue = "1") int page,
                       Model model) {
        int pageSize = 10;
        List<Order> orders;
        int total;
        if (status != null) {
            orders = orderService.findByStatus(status, page, pageSize);
            total = orderService.countByStatus(status);
        } else {
            orders = orderService.findAll(page, pageSize);
            total = orderService.countAll();
        }
        model.addAttribute("orders", orders);
        model.addAttribute("status", status);
        model.addAttribute("page", page);
        model.addAttribute("totalPage", (total + pageSize - 1) / pageSize);
        return "admin/order/list";
    }

    @GetMapping("/detail/{id}")
    public String detail(@PathVariable("id") Integer id, Model model) {
        Order order = orderService.findById(id);
        if (order == null) {
            return "redirect:/admin/order/list";
        }
        List<OrderItem> items = orderService.getOrderItems(id);
        model.addAttribute("order", order);
        model.addAttribute("items", items);
        return "admin/order/detail";
    }

    /** 确认支付（自动发货） */
    @PostMapping("/confirm/{id}")
    public String confirmPay(@PathVariable("id") Integer id, RedirectAttributes ra) {
        try {
            if (orderService.adminConfirmPay(id)) {
                ra.addFlashAttribute("msg", "已确认支付，卡密已自动发货");
            } else {
                ra.addFlashAttribute("msg", "操作失败，订单状态不正确");
            }
        } catch (Exception e) {
            ra.addFlashAttribute("msg", "发货失败: " + e.getMessage());
        }
        return "redirect:/admin/order/list";
    }

    /** 取消订单 */
    @PostMapping("/cancel/{id}")
    public String cancel(@PathVariable("id") Integer id, RedirectAttributes ra) {
        if (orderService.cancelOrder(id)) {
            ra.addFlashAttribute("msg", "订单已取消");
        } else {
            ra.addFlashAttribute("msg", "取消失败");
        }
        return "redirect:/admin/order/list";
    }
}
