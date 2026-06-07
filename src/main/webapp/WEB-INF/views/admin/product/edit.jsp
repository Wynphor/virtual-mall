<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin_header.jsp" %>

<h4 class="section-title">${empty product ? 'ADD PRODUCT 添加商品' : 'EDIT PRODUCT 编辑商品'}</h4>
<div class="d-flex justify-content-center">
    <div style="width: 100%; max-width: 720px;">
        <div class="glass-card p-4">
            <form action="${pageContext.request.contextPath}/admin/product/${empty product ? 'save' : 'update'}" method="post">
                <input type="hidden" name="_csrf" value="${csrfToken}">
                <c:if test="${not empty product}"><input type="hidden" name="id" value="${product.id}"></c:if>
                <div class="mb-3">
                    <label class="form-label" style="font-weight: bolder;">商品名称 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="name" value="${fn:escapeXml(product.name)}" required style="border-radius: 8px;">
                </div>
                <div class="mb-3">
                    <label class="form-label" style="font-weight: bolder;">所属分类（二级） <span class="text-danger">*</span></label>
                    <select class="form-select" name="categoryId" required style="border-radius: 8px;">
                        <c:forEach var="cat" items="${categories}">
                            <optgroup label="${fn:escapeXml(cat.name)}">
                                <c:forEach var="child" items="${cat.children}">
                                    <option value="${child.id}" ${product.categoryId == child.id ? 'selected' : ''}>${child.name}</option>
                                </c:forEach>
                            </optgroup>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label" style="font-weight: bolder;">起步价 <span class="text-danger">*</span></label>
                    <input type="number" step="0.01" class="form-control" name="price" value="${product.price}" required style="border-radius: 8px;">
                </div>
                <div class="mb-3">
                    <label class="form-label" style="font-weight: bolder;">商品描述</label>
                    <textarea class="form-control" name="description" rows="5" style="border-radius: 8px;">${product.description}</textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label" style="font-weight: bolder;">状态</label>
                    <select class="form-select" name="status" style="border-radius: 8px;">
                        <option value="1" ${product.status == 1 ? 'selected' : ''}>上架</option>
                        <option value="0" ${product.status == 0 ? 'selected' : ''}>下架</option>
                    </select>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary" style="border-radius: 8px;">保存</button>
                    <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-outline-secondary" style="border-radius: 8px;">取消</a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="../admin_footer.jsp" %>
