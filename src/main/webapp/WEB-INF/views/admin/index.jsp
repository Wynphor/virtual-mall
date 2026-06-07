<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="admin_header.jsp" %>

<h4 class="section-title mb-4">DASHBOARD 数据概览</h4>

<div class="row g-4 mb-4">
    <div class="col-md-3 col-6">
        <div class="mall-card stat-card p-3 fade-in anim-delay-1">
            <div style="font-size: 2rem;">📦</div>
            <h3>${orderTotal}</h3>
            <p>总订单</p>
        </div>
    </div>
    <div class="col-md-3 col-6">
        <div class="mall-card stat-card p-3 fade-in anim-delay-2">
            <div style="font-size: 2rem;">✅</div>
            <h3 style="color: #10B981;">${orderCompleted}</h3>
            <p>已完成</p>
        </div>
    </div>
    <div class="col-md-3 col-6">
        <div class="mall-card stat-card p-3 fade-in anim-delay-3">
            <div style="font-size: 2rem;">👤</div>
            <h3 style="color: var(--color-accent);">${userTotal}</h3>
            <p>用户数</p>
        </div>
    </div>
    <div class="col-md-3 col-6">
        <div class="mall-card stat-card p-3 fade-in anim-delay-4">
            <div style="font-size: 2rem;">🏷️</div>
            <h3 style="color: var(--color-nav);">${productTotal}</h3>
            <p>商品数</p>
        </div>
    </div>
</div>

<h4 class="section-title mb-3">QUICK ACTIONS 快捷操作</h4>
<div class="row g-3">
    <div class="col-md-4">
        <a href="${pageContext.request.contextPath}/admin/order/list" class="btn btn-primary w-100 py-3" style="border-radius: 12px;">
            查看所有订单
        </a>
    </div>
    <div class="col-md-4">
        <a href="${pageContext.request.contextPath}/admin/cardkey/add" class="btn btn-success w-100 py-3" style="border-radius: 12px;">
            导入卡密
        </a>
    </div>
    <div class="col-md-4">
        <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-outline-primary w-100 py-3" style="border-radius: 12px;">
            添加商品
        </a>
    </div>
</div>

<%@ include file="admin_footer.jsp" %>
