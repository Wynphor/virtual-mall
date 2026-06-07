package com.mall.filter;

import com.mall.util.CsrfToken;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * CSRF Token 过滤器
 * - 每次请求将 token 放入 request attribute，供 JSP 表单输出
 * - 对 POST/PUT/DELETE 请求验证 token
 */
public class CsrfTokenFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession(true);

        // 确保 session 中有 token
        String token = (String) session.getAttribute(CsrfToken.sessionKey());
        if (token == null) {
            token = CsrfToken.generate();
            session.setAttribute(CsrfToken.sessionKey(), token);
        }

        // 将 token 放入 request attribute，JSP 可通过 ${_csrfToken} 获取
        request.setAttribute("csrfToken", token);

        // 对状态修改请求验证 token
        String method = request.getMethod();
        if ("POST".equalsIgnoreCase(method) || "PUT".equalsIgnoreCase(method)
                || "DELETE".equalsIgnoreCase(method) || "PATCH".equalsIgnoreCase(method)) {

            String submitted = request.getParameter(CsrfToken.formField());
            if (!CsrfToken.validate(session, submitted)) {
                request.setAttribute("msg", "CSRF Token 验证失败，请刷新页面后重试");
                request.getRequestDispatcher("/WEB-INF/views/common/error.jsp")
                       .forward(request, res);
                return;
            }
        }

        chain.doFilter(req, res);
    }

    @Override
    public void destroy() {}
}
