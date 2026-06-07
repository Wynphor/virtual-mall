<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册 - 虚拟数字商城</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="auth-container" id="back">
    <div class="auth-card">
        <h3>REGISTER</h3><p></p>
        <c:if test="${not empty msg}">
            <div class="alert alert-danger w-100 mb-3" style="background: rgba(229,62,62,0.2); color: rgba(255,180,180,0.9); font-size: 0.85rem;">${msg}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/user/doRegister" method="post" style="width: 100%;">
            <input type="hidden" name="_csrf" value="${csrfToken}">
            <input type="text" name="username" class="form-control" placeholder="用户名 *" required>
            <br>
            <input type="password" name="password" class="form-control" placeholder="密码 *" required>
            <br>
            <input type="password" name="repassword" class="form-control" placeholder="确认密码 *" required>
            <br>
            <input type="email" name="email" class="form-control" placeholder="邮箱（选填）">
            <br>
            <input type="tel" name="phone" class="form-control" placeholder="手机号（选填）">
            <br>
            <div style="text-align: center;">
                <button type="submit" class="btn-login">注册</button>
            </div>
            <div style="text-align: right; margin-top: 20px;">
                <a href="${pageContext.request.contextPath}/user/login" class="ykbt">已有账号？登录</a>
            </div>
        </form>
    </div>
</div>

<script>
    var back = document.getElementById('back');
    window.onmousemove = function(event) {
        var x = -event.clientX / 20;
        var y = -event.clientY / 25;
        back.style.backgroundPositionX = x + "px";
        back.style.backgroundPositionY = y + "px";
    };
</script>
</body>
</html>
