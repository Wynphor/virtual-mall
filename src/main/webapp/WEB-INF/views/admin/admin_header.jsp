<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${fn:escapeXml(param.title)} - ADMIN PANEL</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<nav class="nav-mall" id="mainNav">
    <div class="nav-mall-inner">
        <a class="nav-mall-brand" href="${pageContext.request.contextPath}/admin/index">
            <strong>ADMIN</strong>|PANEL
        </a>

        <button class="nav-mall-toggle" id="navToggle" aria-label="Menu">
            <span></span><span></span><span></span>
        </button>

        <div class="nav-mall-body" id="navBody">
            <div class="nav-mall-links" id="navLinks">
                <c:set var="uri" value="${requestScope['javax.servlet.forward.request_uri'] != null ? requestScope['javax.servlet.forward.request_uri'] : pageContext.request.requestURI}" />
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <a class="nav-mall-link ${fn:endsWith(uri, '/admin/index') || fn:endsWith(uri, '/admin/') ? 'active' : ''}" href="${ctx}/admin/index">首页</a>
                <a class="nav-mall-link ${fn:contains(uri, '/admin/product') ? 'active' : ''}" href="${ctx}/admin/product/list">商品管理</a>
                <a class="nav-mall-link ${fn:contains(uri, '/admin/category') ? 'active' : ''}" href="${ctx}/admin/category/list">分类管理</a>
                <a class="nav-mall-link ${fn:contains(uri, '/admin/order') ? 'active' : ''}" href="${ctx}/admin/order/list">订单管理</a>
                <a class="nav-mall-link ${fn:contains(uri, '/admin/cardkey') ? 'active' : ''}" href="${ctx}/admin/cardkey/list">卡密管理</a>
                <a class="nav-mall-link ${fn:contains(uri, '/admin/user') ? 'active' : ''}" href="${ctx}/admin/user/list">用户管理</a>
                <div class="nav-mall-anim" id="navAnim"></div>
            </div>

            <div style="flex: 1;"></div>

            <div class="nav-mall-user">
                <a class="nav-mall-link" href="${pageContext.request.contextPath}/" target="_blank">访问前台</a>
                <a class="nav-mall-link" href="${pageContext.request.contextPath}/admin/logout">退出登录</a>
            </div>
        </div>
    </div>
</nav>
<div style="height: 70px;"></div>

<div class="container-fluid mt-3">
    <c:if test="${not empty msg}">
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            ${fn:escapeXml(msg)}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
</div>
<div class="container-fluid mt-2">
