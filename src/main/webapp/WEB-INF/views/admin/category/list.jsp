<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin_header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="section-title mb-0">CATEGORIES 分类管理</h4>
    <a href="${pageContext.request.contextPath}/admin/category/add?parentId=0" class="btn btn-success btn-sm" style="border-radius: 8px;">添加一级分类</a>
</div>

<div class="glass-card">
    <div class="table-responsive">
        <table class="table mb-0">
            <thead>
                <tr><th>ID</th><th>分类名</th><th>排序</th><th>状态</th><th>操作</th></tr>
            </thead>
            <tbody>
                <c:forEach var="cat" items="${categories}">
                    <tr>
                        <td>${cat.id}</td>
                        <td style="font-weight: bolder;">${fn:escapeXml(cat.name)}</td>
                        <td>${cat.sortOrder}</td>
                        <td><span class="badge ${cat.status == 1 ? 'bg-success' : 'bg-secondary'}">${cat.status == 1 ? '启用' : '禁用'}</span></td>
                        <td>
                            <div class="d-flex gap-1">
                                <a href="${pageContext.request.contextPath}/admin/category/add?parentId=${cat.id}" class="btn btn-outline-success btn-sm">+子分类</a>
                                <a href="${pageContext.request.contextPath}/admin/category/edit/${cat.id}" class="btn btn-outline-info btn-sm">编辑</a>
                                <form action="${pageContext.request.contextPath}/admin/category/delete/${cat.id}" method="post" class="d-inline">
                                    <input type="hidden" name="_csrf" value="${csrfToken}">
                                    <button type="submit" class="btn btn-outline-danger btn-sm" onclick="return confirm('确定删除？')">删除</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <c:forEach var="child" items="${cat.children}">
                        <tr>
                            <td>${child.id}</td>
                            <td class="ps-4" style="color: var(--color-primary-light);">└ ${fn:escapeXml(child.name)}</td>
                            <td>${child.sortOrder}</td>
                            <td><span class="badge ${child.status == 1 ? 'bg-success' : 'bg-secondary'}">${child.status == 1 ? '启用' : '禁用'}</span></td>
                            <td>
                                <div class="d-flex gap-1">
                                    <a href="${pageContext.request.contextPath}/admin/category/edit/${child.id}" class="btn btn-outline-info btn-sm">编辑</a>
                                    <form action="${pageContext.request.contextPath}/admin/category/delete/${child.id}" method="post" class="d-inline">
                                        <input type="hidden" name="_csrf" value="${csrfToken}">
                                        <button type="submit" class="btn btn-outline-danger btn-sm" onclick="return confirm('确定删除？')">删除</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="../admin_footer.jsp" %>
