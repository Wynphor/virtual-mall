package com.mall.controller.user;

import com.mall.entity.Order;
import com.mall.entity.User;
import com.mall.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/user")
public class OrderController {

    @Autowired
    private OrderService orderService;

    /** 我的订单（登录用户） */
    @GetMapping("/orders")
    public String myOrders(@RequestParam(value = "page", defaultValue = "1") int page,
                           HttpSession session, Model model) {
        User user = (User) session.getAttribute("loginUser");
        int pageSize = 10;
        List<Order> orders = orderService.findByUserId(user.getId(), page, pageSize);
        int total = orderService.countByUserId(user.getId());
        model.addAttribute("orders", orders);
        model.addAttribute("page", page);
        model.addAttribute("totalPage", (total + pageSize - 1) / pageSize);
        return "front/user/orders";
    }
}
