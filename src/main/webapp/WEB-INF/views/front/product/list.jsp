<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/header.jsp" %>

<main class="container py-4 fade-in">

    <!-- 搜索结果提示 -->
    <c:if test="${not empty keyword}">
        <div class="panel mb-3">
            <div class="panel-body" style="padding: 12px 16px;">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span style="color: #6b7280; font-size: 14px;">搜索结果：</span>
                        <span style="font-weight: 700; color: #1f2937;">"${fn:escapeXml(keyword)}"</span>
                        <span style="color: #9ca3af; font-size: 13px; margin-left: 8px;">共 ${products.size()} 件商品</span>
                    </div>
                    <a href="${pageContext.request.contextPath}/product/list" class="btn btn-sm" style="border-radius: 8px; font-size: 13px; color: #6b7280; border: 1px solid #e5e7eb;">清除搜索</a>
                </div>
            </div>
        </div>
    </c:if>

    <!-- 公告面板（仅非搜索时显示） -->
    <c:if test="${empty keyword}">
        <div class="panel mb-3">
            <div class="panel-header">
                <span class="icon" style="background: linear-gradient(90deg, var(--color-nav-hover), var(--color-primary-lighter)); color: #fff; width: 28px; height: 28px; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; font-size: 14px;">📢</span>
                <h6 class="panel-title">公告</h6>
            </div>
            <div class="panel-body">
                <p><b>☑ 本商城所有商品均为虚拟商品，购买后自动发货</b></p>
                <p><b>☑ 支付如没有回调，先尝试刷新网页，后可联系客服解决！</b></p>
            </div>
        </div>
    </c:if>

    <!-- 购买面板 -->
    <div class="panel">
        <div class="panel-header">
            <span class="icon" style="background: linear-gradient(90deg, var(--color-nav-hover), var(--color-primary-lighter)); color: #fff; width: 28px; height: 28px; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; font-size: 14px;">🛒</span>
            <h6 class="panel-title">
                <c:choose>
                    <c:when test="${not empty keyword}">搜索结果</c:when>
                    <c:otherwise>购买</c:otherwise>
                </c:choose>
            </h6>
        </div>
        <div class="panel-body">
            <!-- 分类 Chip -->
            <div class="mb-3">
                <div class="chip-list">
                    <a href="${pageContext.request.contextPath}/product/list"
                       class="chip ${empty categoryId && empty keyword ? 'is-primary' : ''}">ALL 全部</a>
                    <c:forEach var="cat" items="${categories}" varStatus="cs">
                        <c:forEach var="child" items="${cat.children}">
                            <a href="${pageContext.request.contextPath}/product/list?categoryId=${child.id}"
                               class="chip ${categoryId == child.id ? 'is-primary' : ''}">
                                ${fn:escapeXml(child.name)}
                            </a>
                        </c:forEach>
                    </c:forEach>
                </div>
            </div>

            <!-- 商品列表 -->
            <div class="row item-list">
                <c:forEach var="p" items="${products}" varStatus="status">
                    <!-- 计算是否售罄（所有 SKU 库存为 0） -->
                    <c:set var="cardSoldOut" value="false"/>
                    <c:if test="${p.status == 0 || empty p.skuList}">
                        <c:set var="cardSoldOut" value="true"/>
                    </c:if>
                    <c:if test="${p.status != 0 && not empty p.skuList}">
                        <c:set var="cardSoldOut" value="true"/>
                        <c:forEach var="sku" items="${p.skuList}">
                            <c:if test="${sku.stock > 0}"><c:set var="cardSoldOut" value="false"/></c:if>
                        </c:forEach>
                    </c:if>
                    <div class="col-12 col-md-6 col-lg-3 mb-3">
                        <a href="${pageContext.request.contextPath}/product/detail/${p.id}" style="text-decoration: none;">
                            <div class="product-card h-100 ${cardSoldOut ? 'soldout' : ''}">
                                <div class="card-cover">
                                    <div class="card-cover-bg" style="background: url('${pageContext.request.contextPath}/static/images/${p.image}') center/cover no-repeat;"></div>
                                </div>
                                <div class="card-body">
                                    <div class="card-tags">
                                        <span class="badge-soft badge-soft-success">自动发货</span>
                                        <c:if test="${p.sales > 10}">
                                            <span class="badge-soft badge-soft-primary">推荐</span>
                                        </c:if>
                                    </div>
                                    <p class="goods-title">${fn:escapeXml(p.name)}</p>
                                    <div class="card-stat-row mb-1">
                                        <div class="price"><span class="unit">¥</span>${p.price}</div>
                                    </div>
                                    <div class="card-stat-bottom">
                                        <c:if test="${not empty p.skuList}">
                                            <c:set var="totalStock" value="0"/>
                                            <c:forEach var="sku" items="${p.skuList}">
                                                <c:set var="totalStock" value="${totalStock + sku.stock}"/>
                                            </c:forEach>
                                            <span>库存：${totalStock}</span>
                                        </c:if>
                                        <span>已售：${p.sales}</span>
                                    </div>
                                </div>
                                <c:if test="${p.status == 0}">
                                    <div class="soldout-ribbon">下架</div>
                                </c:if>
                                <c:if test="${cardSoldOut && p.status != 0}">
                                    <div class="soldout-ribbon">售罄</div>
                                </c:if>
                            </div>
                        </a>
                    </div>
                </c:forEach>

                <c:if test="${empty products}">
                    <div class="item-message">
                        <c:choose>
                            <c:when test="${not empty keyword}">
                                没有找到 "${fn:escapeXml(keyword)}" 相关商品
                            </c:when>
                            <c:otherwise>
                                该分类下暂无商品
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
            </div>

            <!-- 分页 -->
            <c:if test="${totalPage > 1}">
                <nav class="mt-3">
                    <ul class="pagination justify-content-center mb-0">
                        <c:forEach begin="1" end="${totalPage}" var="i">
                            <li class="page-item ${page == i ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/product/list?page=${i}${not empty categoryId ? '&categoryId=' : ''}${categoryId}${not empty keyword ? '&keyword=' : ''}${fn:escapeXml(keyword)}">${i}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </nav>
            </c:if>
        </div>
    </div>

</main>

<%@ include file="../../common/footer.jsp" %>
