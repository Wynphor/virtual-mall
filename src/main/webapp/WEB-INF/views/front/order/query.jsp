<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/header.jsp" %>

<div class="container mt-4 fade-in" style="max-width: 800px;">
    <h4 class="section-title">QUERY 订单查询</h4>

    <div class="glass-card mb-4 p-4">
        <form action="${pageContext.request.contextPath}/order/queryResult" method="get" class="d-flex gap-2" onsubmit="return validateQuery();">
            <input type="text" class="form-control" name="contact" id="queryContact" value="${fn:escapeXml(contact)}"
                   placeholder="请输入下单时填写的手机号或邮箱" required>
            <button type="submit" class="btn btn-primary" style="white-space: nowrap;">查询订单</button>
        </form>

<script>
function validateQuery() {
    var contact = document.getElementById('queryContact').value.trim();
    if (!contact) { alert('请输入联系方式'); return false; }
    var isPhone = /^1[3-9]\d{9}$/.test(contact);
    var isEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(contact);
    if (!isPhone && !isEmail) { alert('请输入正确的手机号或邮箱'); return false; }
    return true;
}
</script>
    </div>

    <c:if test="${not empty orders}">
        <div class="glass-card">
            <div class="table-responsive">
                <table class="table mb-0">
                    <thead>
                        <tr>
                            <th>订单号</th>
                            <th>金额</th>
                            <th>状态</th>
                            <th>时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="o" items="${orders}">
                            <tr>
                                <td><code style="color: var(--color-nav);">${o.orderNo}</code></td>
                                <td class="price-tag">¥<fmt:formatNumber value="${o.totalPrice}" pattern="#,##0.00"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${o.status == 0}"><span class="badge bg-warning">待支付</span></c:when>
                                        <c:when test="${o.status == 2}"><span class="badge bg-success">已完成</span></c:when>
                                        <c:when test="${o.status == 3}"><span class="badge bg-secondary">已取消</span></c:when>
                                    </c:choose>
                                </td>
                                <td style="color: var(--color-primary-light); font-size: 0.85rem;"><fmt:formatDate value="${o.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/order/detail/${o.orderNo}" class="btn btn-outline-primary btn-sm">详情</a>
                                    <c:if test="${o.status == 0}">
                                        <a href="${pageContext.request.contextPath}/order/pay/${o.orderNo}" class="btn btn-danger btn-sm">去支付</a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>

    <c:if test="${not empty contact && empty orders}">
        <div class="empty-state">
            <h5>未找到订单</h5>
            <p>没有找到与 "${fn:escapeXml(contact)}" 关联的订单，请检查联系方式是否正确</p>
        </div>
    </c:if>
</div>

<%@ include file="../../common/footer.jsp" %>
