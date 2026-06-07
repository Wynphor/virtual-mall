package com.mall.controller.admin;

import com.mall.entity.User;
import com.mall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/user")
public class AdminUserController {

    @Autowired
    private UserService userService;

    @GetMapping("/list")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        int pageSize = 10;
        List<User> users = userService.listUsers(page, pageSize);
        model.addAttribute("users", users);
        model.addAttribute("page", page);
        model.addAttribute("totalPage", (userService.countUsers() + pageSize - 1) / pageSize);
        return "admin/user/list";
    }

    @GetMapping("/disable/{id}")
    public String disable(@PathVariable("id") Integer id, RedirectAttributes ra) {
        User user = userService.findById(id);
        if (user != null) {
            user.setStatus(0);
            userService.update(user);
            ra.addFlashAttribute("msg", "已禁用");
        }
        return "redirect:/admin/user/list";
    }

    @GetMapping("/enable/{id}")
    public String enable(@PathVariable("id") Integer id, RedirectAttributes ra) {
        User user = userService.findById(id);
        if (user != null) {
            user.setStatus(1);
            userService.update(user);
            ra.addFlashAttribute("msg", "已启用");
        }
        return "redirect:/admin/user/list";
    }
}
