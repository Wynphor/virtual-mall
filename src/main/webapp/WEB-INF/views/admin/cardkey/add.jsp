<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin_header.jsp" %>

<div class="d-flex justify-content-center">
    <div style="width: 100%; max-width: 720px;">
        <div class="glass-card p-4">
            <h5 style="font-weight: 800; margin-bottom: 1rem; color: var(--color-heading-alt);">
                <span style="display: inline-flex; align-items: center; justify-content: center; width: 28px; height: 28px; border-radius: 50%; font-size: 14px; color: #fff; background: linear-gradient(90deg, var(--color-nav-hover), var(--color-primary-lighter)); margin-right: 8px;">📥</span>
                导入卡密
            </h5>
            <form action="${pageContext.request.contextPath}/admin/cardkey/save" method="post">
                <input type="hidden" name="_csrf" value="${csrfToken}">
                <div class="mb-3">
                    <label class="form-label" style="font-weight: 700;">选择规格（SKU） <span class="text-danger">*</span></label>
                    <select class="form-select" name="skuId" required style="border-radius: 8px;">
                        <option value="">-- 请选择商品规格 --</option>
                        <c:forEach var="p" items="${products}">
                            <c:forEach var="sku" items="${p.skuList}">
                                <option value="${sku.id}">${p.name} - ${sku.specName} (¥${sku.price} / 库存${sku.stock})</option>
                            </c:forEach>
                        </c:forEach>
                    </select>
                    <div class="form-text">选择卡密所属的商品规格，库存会自动累加</div>
                </div>
                <div class="mb-3">
                    <label class="form-label" style="font-weight: 700;">卡密内容 <span class="text-danger">*</span></label>
                    <textarea class="form-control" name="content" rows="12"
                              placeholder="每行一个卡密&#10;&#10;示例格式：&#10;account:gpt-plus-001@outlook.com | password:xxx | region:TR&#10;demo-key-xxxxxxxxxxxxxxxxxxxxxxxx"
                              required style="font-family: 'Courier New', monospace; font-size: 0.85rem; line-height: 1.6; border-radius: 8px;"></textarea>
                    <div class="form-text">支持批量导入，每行一个卡密。空行会自动跳过。导入后库存自动累加。</div>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary" style="border-radius: 8px; padding: 8px 24px;">确认导入</button>
                    <a href="${pageContext.request.contextPath}/admin/cardkey/list" class="btn btn-outline-secondary" style="border-radius: 8px; padding: 8px 24px;">返回列表</a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="../admin_footer.jsp" %>
