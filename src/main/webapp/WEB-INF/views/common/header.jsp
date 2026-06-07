<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${fn:escapeXml(param.title)} - VIRTUAL MALL</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<!-- 导航栏 -->
<nav class="nav-mall" id="mainNav">
    <div class="nav-mall-inner">
        <a class="nav-mall-brand" href="${pageContext.request.contextPath}/">
            <strong>MALL</strong>|VIRTUAL STORE
        </a>

        <!-- 移动端汉堡按钮 -->
        <button class="nav-mall-toggle" id="navToggle" aria-label="Menu">
            <span></span><span></span><span></span>
        </button>

        <!-- 导航主体（桌面端横向，移动端折叠） -->
        <div class="nav-mall-body" id="navBody">
            <div class="nav-mall-links" id="navLinks">
                <c:set var="uri" value="${requestScope['javax.servlet.forward.request_uri'] != null ? requestScope['javax.servlet.forward.request_uri'] : pageContext.request.requestURI}" />
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <a class="nav-mall-link ${(!fn:contains(uri, '/product') && !fn:contains(uri, '/order') && !fn:contains(uri, '/user') && !fn:contains(uri, '/about')) ? 'active' : ''}" href="${ctx}/">首页</a>
                <a class="nav-mall-link ${fn:contains(uri, '/product') ? 'active' : ''}" href="${ctx}/product/list">全部商品</a>
                <a class="nav-mall-link ${fn:contains(uri, '/order/query') || fn:contains(uri, '/order/detail') ? 'active' : ''}" href="${ctx}/order/query">订单查询</a>
                <a class="nav-mall-link ${fn:contains(uri, '/about') ? 'active' : ''}" href="${ctx}/about">项目介绍</a>
                <c:if test="${not empty sessionScope.loginUser}">
                    <a class="nav-mall-link ${fn:contains(uri, '/user/orders') ? 'active' : ''}" href="${ctx}/user/orders">我的订单</a>
                </c:if>
                <div class="nav-mall-anim" id="navAnim"></div>
            </div>

            <!-- 搜索框 -->
            <form class="nav-mall-search" action="${pageContext.request.contextPath}/product/list" method="get">
                <input type="search" name="keyword" placeholder="搜索商品..." value="${fn:escapeXml(keyword)}">
                <button type="submit">搜索</button>
            </form>

            <!-- 用户区 -->
            <div class="nav-mall-user">
                <c:choose>
                    <c:when test="${not empty sessionScope.loginUser}">
                        <div class="nav-mall-dropdown">
                            <a class="nav-mall-link nav-mall-dropdown-toggle" href="#" data-bs-toggle="dropdown">
                                ${fn:escapeXml(sessionScope.loginUser.username)}
                            </a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/user/orders">我的订单</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout">退出登录</a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a class="nav-mall-link" href="${pageContext.request.contextPath}/user/login">登录</a>
                        <a class="nav-mall-link" href="${pageContext.request.contextPath}/user/register">注册</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<div style="height: 70px;"></div>

<div class="container mt-3">
    <c:if test="${not empty msg}">
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            ${fn:escapeXml(msg)}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
</div>
