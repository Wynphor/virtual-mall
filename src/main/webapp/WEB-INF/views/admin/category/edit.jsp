<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin_header.jsp" %>

<h4 class="section-title">${empty category ? 'ADD CATEGORY 添加分类' : 'EDIT CATEGORY 编辑分类'}</h4>
<div class="row">
    <div class="col-lg-6">
        <div class="glass-card p-4">
            <form action="${pageContext.request.contextPath}/admin/category/${empty category ? 'save' : 'update'}" method="post">
                <input type="hidden" name="_csrf" value="${csrfToken}">
                <c:if test="${not empty category}"><input type="hidden" name="id" value="${category.id}"></c:if>
                <div class="mb-3">
                    <label class="form-label" style="font-weight: bolder;">分类名称 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="name" value="${fn:escapeXml(category.name)}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label" style="font-weight: bolder;">父分类</label>
                    <select class="form-select" name="parentId">
                        <option value="0">无（一级分类）</option>
                        <c:forEach var="tc" items="${topCategories}">
                            <option value="${tc.id}" ${category.parentId == tc.id ? 'selected' : ''}>${fn:escapeXml(tc.name)}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label" style="font-weight: bolder;">排序</label>
                    <input type="number" class="form-control" name="sortOrder" value="${category.sortOrder != null ? category.sortOrder : 0}">
                </div>
                <div class="mb-3">
                    <label class="form-label" style="font-weight: bolder;">状态</label>
                    <select class="form-select" name="status">
                        <option value="1" ${category.status == 1 ? 'selected' : ''}>启用</option>
                        <option value="0" ${category.status == 0 ? 'selected' : ''}>禁用</option>
                    </select>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary" style="border-radius: 8px;">保存</button>
                    <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-secondary" style="border-radius: 8px;">取消</a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="../admin_footer.jsp" %>
