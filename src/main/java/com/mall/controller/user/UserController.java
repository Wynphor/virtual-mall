package com.mall.controller.user;

import com.mall.entity.User;
import com.mall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    /** 注册页面 */
    @GetMapping("/register")
    public String registerPage() {
        return "front/user/register";
    }

    /** 提交注册 */
    @PostMapping("/doRegister")
    public String doRegister(@RequestParam("username") String username,
                             @RequestParam("password") String password,
                             @RequestParam("repassword") String repassword,
                             @RequestParam(required = false) String email,
                             @RequestParam(required = false) String phone,
                             RedirectAttributes ra) {
        // 输入校验
        if (username == null || username.trim().length() < 2 || username.trim().length() > 20) {
            ra.addFlashAttribute("msg", "用户名长度需为2-20个字符");
            return "redirect:/user/register";
        }
        if (password == null || password.length() < 6) {
            ra.addFlashAttribute("msg", "密码长度不能少于6位");
            return "redirect:/user/register";
        }
        if (!password.equals(repassword)) {
            ra.addFlashAttribute("msg", "两次密码不一致");
            return "redirect:/user/register";
        }
        if (email != null && !email.isEmpty() && !email.matches("^[\\w.-]+@[\\w.-]+\\.\\w{2,}$")) {
            ra.addFlashAttribute("msg", "邮箱格式不正确");
            return "redirect:/user/register";
        }
        if (phone != null && !phone.isEmpty() && !phone.matches("^1[3-9]\\d{9}$")) {
            ra.addFlashAttribute("msg", "手机号格式不正确");
            return "redirect:/user/register";
        }
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setPhone(phone);
        if (userService.register(user)) {
            ra.addFlashAttribute("msg", "注册成功，请登录");
            return "redirect:/user/login";
        } else {
            ra.addFlashAttribute("msg", "用户名已存在");
            return "redirect:/user/register";
        }
    }

    /** 登录页面 */
    @GetMapping("/login")
    public String loginPage() {
        return "front/user/login";
    }

    /** 提交登录 */
    @PostMapping("/doLogin")
    public String doLogin(@RequestParam("username") String username,
                          @RequestParam("password") String password,
                          HttpServletRequest request,
                          HttpSession session,
                          RedirectAttributes ra) {
        User user = userService.login(username, password);
        if (user != null) {
            // 防止Session Fixation：登录前销毁旧session
            session.invalidate();
            HttpSession newSession = request.getSession(true);
            user.setPassword(null); // 不把密码哈希存入session
            newSession.setAttribute("loginUser", user);
            return "redirect:/";
        } else {
            ra.addFlashAttribute("msg", "用户名或密码错误");
            return "redirect:/user/login";
        }
    }

    /** 登出 */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
