package com.mall.controller.shop;

import com.mall.entity.*;
import com.mall.service.OrderService;
import com.mall.service.ProductService;
import com.mall.util.QRCodeGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/order")
public class PayController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private ProductService productService;

    /** 下单页面 */
    @GetMapping("/create")
    public String createPage(@RequestParam("skuId") Integer skuId,
                             @RequestParam(value = "quantity", defaultValue = "1") int quantity,
                             @RequestParam(value = "contact", required = false) String contact,
                             @RequestParam(value = "queryPassword", required = false) String queryPassword,
                             @RequestParam(value = "payMethod", required = false) String payMethod,
                             Model model, HttpSession session) {
        // 输入校验
        if (quantity < 1 || quantity > 99) quantity = 1;
        if (payMethod != null && !payMethod.matches("^(wechat|alipay|usdt)$")) payMethod = "wechat";

        ProductSku sku = productService.findSkuById(skuId);
        if (sku == null) {
            return "redirect:/";
        }
        // 填充商品名
        Product product = productService.findById(sku.getProductId());
        if (product == null) {
            return "redirect:/";
        }
        sku.setProductName(product.getName());

        model.addAttribute("sku", sku);
        model.addAttribute("quantity", quantity);
        model.addAttribute("product", product);
        model.addAttribute("queryPassword", queryPassword);
        model.addAttribute("payMethod", payMethod);

        // 联系方式：优先用URL参数，否则用登录用户的邮箱/手机
        if (contact != null && !contact.isEmpty()) {
            model.addAttribute("defaultContact", contact);
        } else {
            User user = (User) session.getAttribute("loginUser");
            if (user != null) {
                model.addAttribute("defaultContact", user.getEmail() != null ? user.getEmail() : user.getPhone());
            }
        }
        return "front/order/create";
    }

    /** 提交订单 */
    @PostMapping("/submit")
    public String submitOrder(@RequestParam("skuId") Integer skuId,
                              @RequestParam(value = "quantity", defaultValue = "1") int quantity,
                              @RequestParam("contact") String contact,
                              @RequestParam(value = "queryPassword", required = false) String queryPassword,
                              @RequestParam(value = "payMethod", required = false) String payMethod,
                              HttpSession session,
                              RedirectAttributes ra) {
        // 输入校验
        if (quantity < 1 || quantity > 99) {
            ra.addFlashAttribute("msg", "购买数量无效");
            return "redirect:/order/create?skuId=" + skuId + "&quantity=" + quantity + "&contact=" + contact;
        }
        if (contact == null || contact.trim().isEmpty()) {
            ra.addFlashAttribute("msg", "请填写联系方式");
            return "redirect:/order/create?skuId=" + skuId + "&quantity=" + quantity;
        }
        contact = contact.trim();
        boolean isPhone = contact.matches("^1[3-9]\\d{9}$");
        boolean isEmail = contact.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");
        if (!isPhone && !isEmail) {
            ra.addFlashAttribute("msg", "联系方式格式不正确，请输入手机号或邮箱");
            return "redirect:/order/create?skuId=" + skuId + "&quantity=" + quantity + "&contact=" + contact;
        }
        // 支付方式白名单
        if (payMethod != null && !payMethod.matches("^(wechat|alipay|usdt)$")) payMethod = "wechat";
        try {
            User user = (User) session.getAttribute("loginUser");
            Integer userId = user != null ? user.getId() : null;
            Order order = orderService.createOrder(userId, skuId, quantity, contact, queryPassword, payMethod);
            return "redirect:/order/pay/" + order.getOrderNo();
        } catch (Exception e) {
            ra.addFlashAttribute("msg", e.getMessage());
            return "redirect:/order/create?skuId=" + skuId + "&quantity=" + quantity + "&contact=" + contact;
        }
    }

    /** 支付页面（恶搞二维码） */
    @GetMapping("/pay/{orderNo}")
    public String payPage(@PathVariable("orderNo") String orderNo, Model model) {
        Order order = orderService.findByOrderNo(orderNo);
        if (order == null) {
            return "redirect:/";
        }
        model.addAttribute("order", order);
        return "front/order/pay";
    }

    /** 生成二维码图片 */
    @GetMapping("/qrcode/{orderNo}")
    public void generateQRCode(@PathVariable("orderNo") String orderNo,
                               HttpServletResponse response) throws IOException {
        byte[] qrImage = QRCodeGenerator.generateQRCode(orderNo, 300, 300);
        response.setContentType("image/png");
        response.getOutputStream().write(qrImage);
        response.getOutputStream().flush();
    }

    /** 用户确认已付款 */
    @PostMapping("/confirmPay")
    @ResponseBody
    public Map<String, Object> confirmPay(@RequestParam("orderNo") String orderNo) {
        Map<String, Object> result = new HashMap<>();
        boolean success = orderService.userConfirmPay(orderNo);
        result.put("success", success);
        result.put("msg", success ? "支付成功，卡密已发放" : "订单状态异常");
        return result;
    }

    /** 支付成功页 */
    @GetMapping("/success/{orderNo}")
    public String paySuccess(@PathVariable("orderNo") String orderNo, Model model) {
        Order order = orderService.findByOrderNo(orderNo);
        if (order == null) {
            return "redirect:/";
        }
        // 加载每个明细项的卡密
        List<OrderItem> items = orderService.getOrderItems(order.getId());
        order.setItems(items);
        model.addAttribute("order", order);
        return "front/order/success";
    }

    /** 订单查询页面（匿名） */
    @GetMapping("/query")
    public String queryPage() {
        return "front/order/query";
    }

    /** 执行查询 */
    @GetMapping("/queryResult")
    public String queryResult(@RequestParam("contact") String contact, Model model) {
        List<Order> orders = orderService.findByContact(contact);
        model.addAttribute("orders", orders);
        model.addAttribute("contact", contact);
        return "front/order/query";
    }

    /** 订单详情 */
    @GetMapping("/detail/{orderNo}")
    public String orderDetail(@PathVariable("orderNo") String orderNo, Model model) {
        Order order = orderService.findByOrderNo(orderNo);
        if (order == null) {
            return "redirect:/order/query";
        }
        // 加载订单明细及卡密
        List<OrderItem> items = orderService.getOrderItems(order.getId());
        model.addAttribute("order", order);
        model.addAttribute("items", items);
        return "front/order/detail";
    }
}
