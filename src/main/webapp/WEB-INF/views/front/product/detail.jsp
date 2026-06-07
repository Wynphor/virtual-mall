<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/header.jsp" %>

<main class="container py-4">

    <!-- 商品主面板 -->
    <div class="panel mt-3">
        <div class="panel-body">
            <div class="row g-4 align-items-stretch">
                <!-- 左侧：商品大图 -->
                <div class="col-12 col-lg-6 d-flex">
                    <div class="acg-card h-100 w-100 flex-fill acg-cover" style="cursor: default;">
                        <img src="${pageContext.request.contextPath}/static/images/${product.image}" class="item-cover" alt="${product.name}">
                    </div>
                </div>

                <!-- 右侧：商品信息 + 购买表单 -->
                <div class="col-12 col-lg-6 d-flex">
                    <div class="flex-fill">
                        <h4>${fn:escapeXml(product.name)}</h4>

                        <!-- badge 行 -->
                        <div class="d-flex align-items-center gap-2 mb-2">
                            <span class="badge-soft badge-soft-success">自动发货</span>
                            <span class="badge-soft badge-soft-primary">已售 ${product.sales}</span>
                            <c:if test="${not empty product.skuList}">
                                <span class="badge-soft badge-soft-success item-stock">库存 ${product.skuList[0].stock}</span>
                            </c:if>
                        </div>

                        <!-- 价格 -->
                        <div class="d-flex align-items-baseline gap-2 mb-3 abacus">
                            <div class="price"><span class="unit">¥</span><span id="priceDisplay">${product.price}</span></div>
                        </div>

                        <!-- 购买表单（完全匹配 cdk.do 结构） -->
                        <form class="vstack gap-3" id="buyForm">
                            <!-- 规格选择 -->
                            <c:if test="${not empty product.skuList}">
                                <div>
                                    <label class="form-label mb-1">选择规格</label>
                                    <div class="sku-list" id="skuList">
                                        <c:forEach var="sku" items="${product.skuList}">
                                            <div class="sku-item-tag ${sku.stock == 0 ? 'sku-soldout' : ''}" data-id="${sku.id}" data-price="${sku.price}" data-stock="${sku.stock}"
                                                 onclick="${sku.stock > 0 ? 'selectSku(this)' : ''}">
                                                ${sku.specName} <span style="color: #ff6b88; font-weight: 700; margin-left: 4px;">¥${sku.price}</span>
                                                <c:if test="${sku.stock == 0}"><span style="color:#999; font-size:12px; margin-left:4px;">售罄</span></c:if>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>

                            <!-- 联系方式 -->
                            <div>
                                <label class="form-label mb-1">联系方式</label>
                                <input type="text" name="contact" class="form-control" placeholder="手机号或邮箱，用于接收卡密" value="${fn:escapeXml(defaultContact)}" />
                            </div>

                            <!-- 查询密码 -->
                            <div>
                                <label class="form-label mb-1">查询密码</label>
                                <input type="password" name="queryPassword" class="form-control" placeholder="设置查询订单的密码" />
                            </div>

                            <!-- 购买数量 -->
                            <div>
                                <label class="form-label mb-1">购买数量</label>
                                <div class="input-group qty-group">
                                    <button type="button" class="change-num-sub" onclick="changeQty(-1)">-</button>
                                    <input type="number" class="form-control text-center" name="num" id="quantity" value="1" min="1" />
                                    <button type="button" class="change-num-add" onclick="changeQty(1)">+</button>
                                </div>
                            </div>

                            <!-- 付款区 -->
                            <div class="cash-pay p-2" id="cashPay">
                                <label class="form-label mb-2">
                                    <span style="display: inline-flex; align-items: center; justify-content: center; width: 20px; height: 20px; border-radius: 6px; font-size: 12px; color: #fff; background: linear-gradient(90deg, var(--color-nav-hover), var(--color-primary-lighter)); box-shadow: 0 6px 14px rgba(122, 140, 255, 0.35); margin-right: 6px;">🛒</span>
                                    付款方式
                                </label>
                                <div class="pay-list">
                                    <div class="pay active" onclick="selectPay(this, 'wechat')">
                                        <span style="font-size: 18px;">💚</span>
                                        <span>微信支付</span>
                                    </div>
                                    <div class="pay" onclick="selectPay(this, 'alipay')">
                                        <span style="font-size: 18px;">💙</span>
                                        <span>支付宝</span>
                                    </div>
                                    <div class="pay" onclick="selectPay(this, 'usdt')">
                                        <span style="font-size: 18px;">💰</span>
                                        <span>USDT</span>
                                    </div>
                                </div>
                            </div>

                            <!-- 提交按钮 -->
                            <button type="button" class="btn buy-btn" onclick="buyNow()">
                                立即购买
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 宝贝详情面板 -->
    <div class="panel mt-3 item-detail">
        <div class="panel-header">
            <span class="icon" style="background: linear-gradient(90deg, var(--color-nav-hover), var(--color-primary-lighter)); color: #fff; width: 28px; height: 28px; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; font-size: 14px;">ℹ️</span>
            <h6 class="panel-title">宝贝详情</h6>
        </div>
        <div class="panel-body">
            <p>${fn:escapeXml(product.description)}</p>
        </div>
    </div>

</main>

<style>
    /* SKU 选择 */
    .sku-item-tag {
        display: inline-flex;
        align-items: center;
        position: relative;
        padding: 0.2rem 0.6rem;
        border-radius: 16px;
        background: rgba(255, 248, 248, 0.63);
        color: #929292;
        border: none;
        text-decoration: none;
        white-space: nowrap;
        transition: transform 0.18s ease, box-shadow 0.18s ease, background-color 0.18s ease;
        transform-origin: center;
        box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px;
        font-size: 14px;
        cursor: pointer;
        margin: 0 0.4rem 0.4rem 0;
    }
    .sku-item-tag.active {
        color: #fff;
        background: linear-gradient(90deg, #ffb1b1, #ab57ff);
        border-color: transparent;
    }
    .sku-item-tag.sku-soldout {
        opacity: 0.45;
        cursor: not-allowed;
        text-decoration: line-through;
    }
    @media (hover: hover) and (pointer: fine) {
        .sku-item-tag:hover { transform: scale(1.02); }
    }

    /* 立即购买按钮 */
    .buy-btn {
        width: 100% !important;
        border: none !important;
        border-radius: 12px !important;
        padding: 0.7rem 2rem !important;
        font-weight: 700 !important;
        font-size: 15px !important;
        color: #fff !important;
        background: linear-gradient(135deg, var(--color-nav-hover), var(--color-primary-lighter)) !important;
        box-shadow: 0 4px 12px rgba(122,140,255,0.35) !important;
        transition: transform 0.2s ease, box-shadow 0.2s ease !important;
    }
    @media (hover: hover) and (pointer: fine) {
        .buy-btn:hover {
            transform: translateY(-2px) !important;
            box-shadow: 0 6px 20px rgba(122,140,255,0.5) !important;
        }
    }
    .buy-btn:active {
        transform: translateY(0) !important;
    }

    /* 付款区（匹配 cdk.do .cash-pay） */
    .cash-pay {
        position: relative;
        border-radius: 16px;
        padding: 12px;
        background: #ffffff70;
        border: none;
        box-shadow: 0 10px 28px rgba(149, 157, 165, 0.25),
            0 0 0 6px rgba(122, 140, 255, 0.06) inset;
    }

    .cash-pay .form-label {
        display: flex;
        align-items: center;
        gap: 0.3rem;
        margin: 4px 0 8px 4px;
        font-weight: 800;
        font-size: 1rem;
        color: #9d93f7;
    }

    /* 支付方式列表（匹配 cdk.do .pay-list） */
    .pay-list {
        display: flex;
        gap: 0.5rem;
        flex-wrap: wrap;
        padding-top: 10px;
        border-top: 1px dashed #eceff3;
    }

    .pay-list .pay {
        display: inline-flex;
        align-items: center;
        gap: 3px;
        padding: 0.4rem 0.75rem;
        border-radius: 12px;
        background: rgba(255, 248, 248, 0.15);
        box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
        text-decoration: none;
        user-select: none;
        cursor: pointer;
        transition: transform 0.18s ease, box-shadow 0.18s ease, background-color 0.18s ease;
    }

    .pay-list .pay span:last-child {
        font-size: 14px;
        font-weight: 700;
        color: #a3a3a3;
    }

    /* 选中态 */
    .pay-list .pay.active {
        color: #fff;
        background: linear-gradient(90deg, var(--color-nav-hover), var(--color-primary-lighter));
        border-color: transparent;
        box-shadow: 0 8px 18px rgba(122, 140, 255, 0.25);
    }

    .pay-list .pay.active span:last-child {
        color: #fff;
    }

    @media (hover: hover) and (pointer: fine) {
        .pay-list .pay:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.12);
        }
    }
</style>

<script>
    let selectedSkuId = null;
    let selectedPrice = 0;
    let selectedPay = 'wechat';

    // 默认选中第一个 SKU
    (function() {
        const first = document.querySelector('.sku-item-tag');
        if (first) selectSku(first);
    })();

    function selectSku(el) {
        document.querySelectorAll('.sku-item-tag').forEach(item => item.classList.remove('active'));
        el.classList.add('active');
        selectedSkuId = el.dataset.id;
        selectedPrice = parseFloat(el.dataset.price);
        const stock = el.dataset.stock;
        const stockBadge = document.querySelector('.item-stock');
        if (stockBadge) stockBadge.textContent = '库存 ' + stock;
        // 动态更新价格显示
        const priceDisplay = document.getElementById('priceDisplay');
        if (priceDisplay) priceDisplay.textContent = selectedPrice.toFixed(2);
    }

    function changeQty(delta) {
        const input = document.getElementById('quantity');
        let val = parseInt(input.value) + delta;
        if (val < 1) val = 1;
        input.value = val;
    }

    function selectPay(el, method) {
        document.querySelectorAll('.pay-list .pay').forEach(p => p.classList.remove('active'));
        el.classList.add('active');
        selectedPay = method;
    }

    function buyNow() {
        if (!selectedSkuId) { alert('请选择规格'); return; }
        // 库存校验
        const selectedTag = document.querySelector('.sku-item-tag.active');
        if (selectedTag && parseInt(selectedTag.dataset.stock) <= 0) {
            alert('该规格已售罄，请选择其他规格');
            return;
        }
        const contact = document.querySelector('input[name="contact"]').value.trim();
        if (!contact) { alert('请输入联系方式'); return; }
        const isPhone = /^1[3-9]\d{9}$/.test(contact);
        const isEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(contact);
        if (!isPhone && !isEmail) { alert('联系方式请输入正确的手机号或邮箱'); return; }

        // 确认下单
        const qty = document.getElementById('quantity').value;
        const pwd = document.querySelector('input[name="queryPassword"]').value;
        let url = '${pageContext.request.contextPath}/order/create?skuId=' + selectedSkuId + '&quantity=' + qty + '&contact=' + encodeURIComponent(contact);
        if (pwd) url += '&queryPassword=' + encodeURIComponent(pwd);
        if (selectedPay) url += '&payMethod=' + encodeURIComponent(selectedPay);
        window.location.href = url;
    }
</script>

<%@ include file="../../common/footer.jsp" %>
