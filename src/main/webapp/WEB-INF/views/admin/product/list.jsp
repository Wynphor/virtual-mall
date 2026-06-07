<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin_header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="section-title mb-0">PRODUCTS 商品管理</h4>
    <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-success btn-sm" style="border-radius: 8px;">添加商品</a>
</div>

<div class="glass-card">
    <div class="table-responsive">
        <table class="table mb-0">
            <thead>
                <tr><th>ID</th><th>商品名</th><th>起步价</th><th>销量</th><th>状态</th><th>操作</th></tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${products}">
                    <tr>
                        <td>${p.id}</td>
                        <td style="font-weight: bolder;">${fn:escapeXml(p.name)}</td>
                        <td class="price-tag">¥${p.price}</td>
                        <td>${p.sales}</td>
                        <td><span class="badge ${p.status == 1 ? 'bg-success' : 'bg-secondary'}">${p.status == 1 ? '上架' : '下架'}</span></td>
                        <td>
                            <div class="d-flex gap-1">
                                <a href="${pageContext.request.contextPath}/admin/product/${p.id}/sku/list" class="btn btn-outline-primary btn-sm">规格</a>
                                <a href="${pageContext.request.contextPath}/admin/product/edit/${p.id}" class="btn btn-outline-info btn-sm">编辑</a>
                                <form action="${pageContext.request.contextPath}/admin/product/delete/${p.id}" method="post" class="d-inline">
                                    <input type="hidden" name="_csrf" value="${csrfToken}">
                                    <button type="submit" class="btn btn-outline-danger btn-sm" onclick="return confirm('确定删除此商品？')">删除</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<c:if test="${empty products}"><div class="empty-state"><h5>暂无商品</h5></div></c:if>

<c:if test="${totalPage > 1}">
    <nav class="mt-4"><ul class="pagination justify-content-center">
        <c:forEach begin="1" end="${totalPage}" var="i">
            <li class="page-item ${page == i ? 'active' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/product/list?page=${i}">${i}</a>
            </li>
        </c:forEach>
    </ul></nav>
</c:if>

<%@ include file="../admin_footer.jsp" %>
