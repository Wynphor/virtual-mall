<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin_header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="section-title mb-0">SKU SPECS 规格管理 - ${product.name}</h4>
    <a href="${pageContext.request.contextPath}/admin/product/${product.id}/sku/add" class="btn btn-success btn-sm" style="border-radius: 8px;">添加规格</a>
</div>

<div class="glass-card">
    <div class="table-responsive">
        <table class="table mb-0">
            <thead>
                <tr><th>ID</th><th>规格名</th><th>价格</th><th>库存(卡密数)</th><th>状态</th><th>操作</th></tr>
            </thead>
            <tbody>
                <c:forEach var="sku" items="${skus}">
                    <tr>
                        <td>${sku.id}</td>
                        <td style="font-weight: bolder;">${fn:escapeXml(sku.specName)}</td>
                        <td class="price-tag">¥${sku.price}</td>
                        <td>${sku.stock}</td>
                        <td><span class="badge ${sku.status == 1 ? 'bg-success' : 'bg-secondary'}">${sku.status == 1 ? '启用' : '禁用'}</span></td>
                        <td>
                            <div class="d-flex gap-1">
                                <a href="${pageContext.request.contextPath}/admin/product/sku/edit/${sku.id}" class="btn btn-outline-info btn-sm">编辑</a>
                                <form action="${pageContext.request.contextPath}/admin/product/sku/delete/${sku.id}?productId=${product.id}" method="post" class="d-inline">
                                    <input type="hidden" name="_csrf" value="${csrfToken}">
                                    <button type="submit" class="btn btn-outline-danger btn-sm" onclick="return confirm('确定删除此规格？')">删除</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty skus}"><tr><td colspan="6" class="text-center py-4" style="color: var(--color-primary-light);">暂无规格，请添加</td></tr></c:if>
            </tbody>
        </table>
    </div>
</div>

<div class="mt-3"><a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-outline-secondary" style="border-radius: 8px;">返回商品列表</a></div>

<%@ include file="../admin_footer.jsp" %>
