<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>

<!-- Hero（fixed定位，铺满视口，无留白） -->
<div class="hero-section">
    <h1>Virtual Mall<br>虚拟数字商城</h1>
</div>

<!-- 占位：撑开页面，让下方内容出现在Hero下方 -->
<div class="hero-spacer"></div>

<!-- 内容区（实色背景覆盖hero） -->
<div style="position: relative; z-index: 1; background: rgba(255,255,255,0.85); backdrop-filter: blur(10px); min-height: 100vh;">

<!-- 分类 Chip -->
<div class="container mt-4">
    <div class="chip-list">
        <c:forEach var="cat" items="${categories}">
            <a class="chip" href="${pageContext.request.contextPath}/product/list?categoryId=${cat.id}">
                ${fn:escapeXml(cat.name)}
            </a>
        </c:forEach>
    </div>
</div>

<!-- 特色推荐 -->
<div class="container mt-4 mb-4">
    <h4 class="section-title">FEATURED 特色推荐</h4>
    <div class="row g-3">
        <div class="col-lg-3 col-md-6">
            <div class="feature-card img-cat1 fade-in anim-delay-1"
                 onclick="location.href='${pageContext.request.contextPath}/product/list?categoryId=1'">
                <div class="imghid"><div class="feature-img"></div></div>
                <div class="feature-body">
                    <h5>AI 服务</h5>
                    <p>&emsp;ChatGPT、Claude、Midjourney等AI平台账号及API额度</p>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="feature-card img-cat2 fade-in anim-delay-2"
                 onclick="location.href='${pageContext.request.contextPath}/product/list?categoryId=3'">
                <div class="imghid"><div class="feature-img"></div></div>
                <div class="feature-body">
                    <h5>会员订阅</h5>
                    <p>&emsp;Netflix、Spotify、Steam等流媒体及平台会员</p>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="feature-card img-cat3 fade-in anim-delay-3"
                 onclick="location.href='${pageContext.request.contextPath}/product/list?categoryId=4'">
                <div class="imghid"><div class="feature-img"></div></div>
                <div class="feature-body">
                    <h5>课设毕设</h5>
                    <p>&emsp;SSM、SpringBoot、小程序等完整项目源码</p>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="feature-card img-cat4 fade-in anim-delay-4"
                 onclick="location.href='${pageContext.request.contextPath}/product/list?categoryId=5'">
                <div class="imghid"><div class="feature-img"></div></div>
                <div class="feature-body">
                    <h5>知识付费</h5>
                    <p>&emsp;AI教程、Prompt模板、开发实战课程</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- HOT ITEMS（cdk.do 风格商品卡片） -->
<div class="container mb-5">
    <h4 class="section-title">HOT ITEMS 热门商品</h4>
    <div class="row g-3">
        <c:forEach var="p" items="${hotProducts}" varStatus="status">
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
    </div>
</div>

</div><!-- /内容区 -->

<%@ include file="../common/footer.jsp" %>
