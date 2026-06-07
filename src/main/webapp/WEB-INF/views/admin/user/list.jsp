<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin_header.jsp" %>

<h4 class="section-title">USERS 用户管理</h4>

<div class="glass-card">
    <div class="table-responsive">
        <table class="table mb-0">
            <thead>
                <tr><th>ID</th><th>用户名</th><th>邮箱</th><th>手机号</th><th>注册时间</th><th>状态</th><th>操作</th></tr>
            </thead>
            <tbody>
                <c:forEach var="u" items="${users}">
                    <tr>
                        <td>${u.id}</td>
                        <td style="font-weight: bolder;">${fn:escapeXml(u.username)}</td>
                        <td>${fn:escapeXml(u.email)}</td>
                        <td>${fn:escapeXml(u.phone)}</td>
                        <td style="color: var(--color-primary-light); font-size: 0.85rem;"><fmt:formatDate value="${u.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td>
                            <span class="badge ${u.status == 1 ? 'bg-success' : 'bg-danger'}">
                                ${u.status == 1 ? '正常' : '禁用'}
                            </span>
                        </td>
                        <td>
                            <c:if test="${u.status == 1}">
                                <a href="${pageContext.request.contextPath}/admin/user/disable/${u.id}" class="btn btn-outline-danger btn-sm">禁用</a>
                            </c:if>
                            <c:if test="${u.status == 0}">
                                <a href="${pageContext.request.contextPath}/admin/user/enable/${u.id}" class="btn btn-outline-success btn-sm">启用</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<c:if test="${totalPage > 1}">
    <nav class="mt-4"><ul class="pagination justify-content-center">
        <c:forEach begin="1" end="${totalPage}" var="i">
            <li class="page-item ${page == i ? 'active' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/user/list?page=${i}">${i}</a>
            </li>
        </c:forEach>
    </ul></nav>
</c:if>

<%@ include file="../admin_footer.jsp" %>
