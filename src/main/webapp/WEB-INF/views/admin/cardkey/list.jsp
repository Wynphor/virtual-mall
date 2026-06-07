<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin_header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="section-title mb-0">CARDKEYS 卡密管理</h4>
    <a href="${pageContext.request.contextPath}/admin/cardkey/add" class="btn btn-success btn-sm" style="border-radius: 8px;">导入卡密</a>
</div>

<div class="glass-card">
    <div class="table-responsive">
        <table class="table mb-0">
            <thead>
                <tr><th>商品</th><th>规格</th><th>卡密内容</th><th>状态</th><th>入库时间</th><th>操作</th></tr>
            </thead>
            <tbody>
                <c:forEach var="k" items="${keys}">
                    <tr>
                        <td style="font-weight: bolder;">${fn:escapeXml(k.productName)}</td>
                        <td><span style="color: var(--color-primary-light);">${fn:escapeXml(k.specName)}</span></td>
                        <td><code style="color: var(--color-nav); font-size: 0.82rem;">${fn:escapeXml(k.content)}</code></td>
                        <td>
                            <c:choose>
                                <c:when test="${k.status == 0}"><span class="badge bg-success">未售</span></c:when>
                                <c:when test="${k.status == 1}"><span class="badge bg-secondary">已售</span></c:when>
                                <c:when test="${k.status == 2}"><span class="badge bg-danger">冻结</span></c:when>
                            </c:choose>
                        </td>
                        <td style="color: var(--color-primary-light); font-size: 0.85rem;"><fmt:formatDate value="${k.addTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td>
                            <c:if test="${k.status == 0}">
                                <a href="${pageContext.request.contextPath}/admin/cardkey/freeze/${k.id}" class="btn btn-outline-warning btn-sm">冻结</a>
                            </c:if>
                            <c:if test="${k.status == 2}">
                                <a href="${pageContext.request.contextPath}/admin/cardkey/unfreeze/${k.id}" class="btn btn-outline-success btn-sm">解冻</a>
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
                <a class="page-link" href="${pageContext.request.contextPath}/admin/cardkey/list?page=${i}">${i}</a>
            </li>
        </c:forEach>
    </ul></nav>
</c:if>

<%@ include file="../admin_footer.jsp" %>
