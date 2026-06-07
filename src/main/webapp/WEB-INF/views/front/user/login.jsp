<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录 - 虚拟数字商城</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="auth-container" id="back">
    <div class="auth-card" id="log">
        <h3>LOGIN</h3><p></p>
        <c:if test="${not empty msg}">
            <div class="alert alert-danger w-100 mb-3" style="background: rgba(229,62,62,0.2); color: rgba(255,180,180,0.9); font-size: 0.85rem;">${msg}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/user/doLogin" method="post" id="logbody" onsubmit="return showLoading()">
            <input type="hidden" name="_csrf" value="${csrfToken}">
            <input type="text" name="username" class="form-control" placeholder="账户" required>
            <br>
            <input type="password" name="password" class="form-control" placeholder="密码" required>
            <br>
            <div style="text-align: center;">
                <button type="submit" class="btn-login">登录</button>
            </div>
            <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 20px;">
                <a href="${pageContext.request.contextPath}/admin/login" class="ykbt">管理员登录 →</a>
                <a href="${pageContext.request.contextPath}/" class="ykbt">游客登录</a>
            </div>
        </form>
        <div style="text-align: center; margin-top: 20px;">
            <a href="${pageContext.request.contextPath}/user/register" style="color: rgba(180,190,210,0.7); font-size: 0.85rem;">没有账号？立即注册</a>
        </div>
    </div>
</div>

<!-- 加载动画（匹配参考 Loading.css） -->
<div class="loading-overlay" id="con">
    <div class="loading-dots">
        <div class="dot" style="--i:0"></div>
        <div class="dot" style="--i:1"></div>
        <div class="dot" style="--i:2"></div>
        <div class="dot" style="--i:3"></div>
        <div class="dot" style="--i:4"></div>
        <div class="dot" style="--i:5"></div>
        <div class="dot" style="--i:6"></div>
    </div>
</div>

<script>
    // 视差背景效果（匹配参考 login.js）
    var back = document.getElementById('back');
    window.onmousemove = function(event) {
        var x = -event.clientX / 20;
        var y = -event.clientY / 25;
        back.style.backgroundPositionX = x + "px";
        back.style.backgroundPositionY = y + "px";
    };

    // 页面加载时显示加载动画（匹配参考 login.js window.onload）
    var con = document.getElementById('con');
    function loadoff() { con.style.display = "none"; }
    function loadon() { con.style.display = "flex"; }
    window.onload = function() {
        loadon();
        setTimeout(loadoff, 2000);
    };

    // 提交时显示加载动画
    function showLoading() {
        var username = document.querySelector('input[name="username"]').value;
        var password = document.querySelector('input[name="password"]').value;
        if (username === "" || password === "") {
            alert("账号或密码不能为空");
            return false;
        }
        loadon();
        return true;
    }
</script>
</body>
</html>
