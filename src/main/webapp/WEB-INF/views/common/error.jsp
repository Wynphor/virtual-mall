<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>

<div class="container mt-4 fade-in" style="max-width: 500px;">
    <div class="glass-card p-5 text-center">
        <div style="font-size: 3rem; margin-bottom: 1rem;">⚠️</div>
        <h4 style="font-weight: bolder; color: #ef4444; margin-bottom: 0.5rem;">操作异常</h4>
        <p style="color: var(--color-primary-light); margin-bottom: 1.5rem;">${msg}</p>
        <a href="javascript:history.back()" class="btn btn-primary w-100" style="border-radius: 10px; padding: 0.7rem;">返回上一页</a>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
