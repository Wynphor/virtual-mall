package com.mall.controller.admin;

import com.mall.entity.Admin;
import com.mall.service.*;
import com.mall.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private ProductService productService;
    @Autowired
    private com.mall.service.UserService userService;

    /** 管理员登录页 */
    @GetMapping("/login")
    public String loginPage() {
        return "admin/login";
    }

    /** 管理员登录 */
    @PostMapping("/login")
    public String doLogin(@RequestParam("username") String username,
                          @RequestParam("password") String password,
                          HttpServletRequest request,
                          HttpSession session,
                          RedirectAttributes ra) {
        // 暴力破解防护：Session 级失败计数，5次后锁定
        Integer failCount = (Integer) session.getAttribute("adminLoginFailCount");
        if (failCount == null) failCount = 0;
        if (failCount >= 5) {
            ra.addFlashAttribute("msg", "登录失败次数过多，请刷新页面后重试");
            return "redirect:/admin/login";
        }

        Admin admin = adminService.login(username, password);
        if (admin != null) {
            // 登录成功，清除失败计数
            session.removeAttribute("adminLoginFailCount");
            // 防止Session Fixation
            session.invalidate();
            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("adminUser", admin);
            return "redirect:/admin/index";
        } else {
            // 登录失败，增加计数
            session.setAttribute("adminLoginFailCount", failCount + 1);
            int remain = 5 - failCount - 1;
            ra.addFlashAttribute("msg", remain > 0
                    ? "账号或密码错误（剩余 " + remain + " 次机会）"
                    : "登录失败次数过多，请刷新页面后重试");
            return "redirect:/admin/login";
        }
    }

    /** 后台首页 */
    @GetMapping({"/index", "/"})
    public String index(Model model) {
        model.addAttribute("orderTotal", orderService.countAll());
        model.addAttribute("orderCompleted", orderService.countByStatus(2));
        model.addAttribute("productTotal", productService.countAll());
        model.addAttribute("userTotal", userService.countUsers());
        return "admin/index";
    }

    /** 登出 */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/login";
    }
}
