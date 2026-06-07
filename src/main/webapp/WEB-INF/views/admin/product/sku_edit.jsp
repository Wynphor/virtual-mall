<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin_header.jsp" %>

<h4 class="section-title">${empty sku ? 'ADD SKU 添加规格' : 'EDIT SKU 编辑规格'}</h4>
<div class="row">
    <div class="col-md-6">
        <div class="glass-card p-4">
            <form action="${pageContext.request.contextPath}/admin/product/sku/save" method="post">
                <input type="hidden" name="_csrf" value="${csrfToken}">
                <c:if test="${not empty sku}">
                    <input type="hidden" name="id" value="${sku.id}">
                    <input type="hidden" name="productId" value="${sku.productId}">
                </c:if>
                <c:if test="${empty sku}"><input type="hidden" name="productId" value="${productId}"></c:if>
                <div class="mb-3">
                    <label class="form-label" style="font-weight: bolder;">规格名称</label>
                    <input type="text" class="form-control" name="specName" value="${fn:escapeXml(sku.specName)}" placeholder="如：Plus月抛、Pro年抛" required>
                </div>
                <div class="mb-3">
                    <label class="form-label" style="font-weight: bolder;">价格</label>
                    <input type="number" step="0.01" class="form-control" name="price" value="${sku.price}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label" style="font-weight: bolder;">库存（自动计算）</label>
                    <input type="text" class="form-control" value="由未售卡密数自动决定，不可手动设置" disabled
                           style="background: #f3f4f6; color: #9ca3af; cursor: not-allowed;">
                    <div class="form-text">库存 = 未售卡密数量，导入卡密自动增加，售出自动减少</div>
                </div>
                <div class="mb-3">
                    <label class="form-label" style="font-weight: bolder;">状态</label>
                    <select class="form-select" name="status">
                        <option value="1" ${sku.status == 1 ? 'selected' : ''}>启用</option>
                        <option value="0" ${sku.status == 0 ? 'selected' : ''}>禁用</option>
                    </select>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary" style="border-radius: 8px;">保存</button>
                    <a href="javascript:history.back()" class="btn btn-outline-secondary" style="border-radius: 8px;">取消</a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="../admin_footer.jsp" %>
