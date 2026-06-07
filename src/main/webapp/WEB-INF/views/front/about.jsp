<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ include file="../common/header.jsp" %>

<div class="manuscript-layout">

    <!-- ====== 左侧目录 ====== -->
    <aside class="manuscript-sidebar" id="manuscriptSidebar">
        <div class="sidebar-title">目录</div>
        <div class="sidebar-progress-wrap">
            <div class="sidebar-progress-bar" id="progressBar"></div>
        </div>
        <nav class="sidebar-toc" id="sidebarToc">
            <a href="#sec-overview" class="toc-link active" data-sec="sec-overview">
                <span class="toc-num">01</span> 项目概览
            </a>
            <a href="#sec-arch" class="toc-link" data-sec="sec-arch">
                <span class="toc-num">02</span> 系统架构
            </a>
            <a href="#sec-db" class="toc-link" data-sec="sec-db">
                <span class="toc-num">03</span> 数据库设计
            </a>
            <a href="#sec-flow" class="toc-link" data-sec="sec-flow">
                <span class="toc-num">04</span> 业务流程
            </a>
            <a href="#sec-security" class="toc-link" data-sec="sec-security">
                <span class="toc-num">05</span> 安全设计
            </a>
            <a href="#sec-tree" class="toc-link" data-sec="sec-tree">
                <span class="toc-num">06</span> 项目目录
            </a>
        </nav>
        <div class="sidebar-footer">
            <span id="progressText">0%</span>
        </div>
    </aside>

    <!-- ====== 主内容区 ====== -->
    <main class="manuscript-paper">

        <!-- 标题 -->
        <div class="paper-header">
            <h1 class="paper-title">虚拟数字商城</h1>
            <p class="paper-subtitle">SSM 课程设计 · 项目技术文档</p>
            <div class="paper-meta">
                <span>Java 23</span>
                <span class="meta-dot">·</span>
                <span>Spring 6.2</span>
                <span class="meta-dot">·</span>
                <span>MyBatis 3.5</span>
                <span class="meta-dot">·</span>
                <span>MySQL 8.0</span>
            </div>
        </div>

        <!-- ====== 01 项目概览 ====== -->
        <section id="sec-overview" class="paper-section">
            <h2 class="section-heading"><span class="heading-num">01</span> 项目概览</h2>

            <img src="${pageContext.request.contextPath}/static/images/about/01-project-overview.png"
                 class="paper-img" alt="项目总览"
                 onerror="this.style.display='none'">

            <p>基于 SSM（Spring + SpringMVC + MyBatis）框架构建的虚拟数字产品在线商城。支持商品浏览、在线下单、扫码支付、卡密自动发货、匿名查单等功能。面向 AI 时代，提供 ChatGPT、Claude、Midjourney 等主流 AI 工具的账号与服务。</p>

            <h3>技术栈</h3>
            <div class="tech-grid">
                <div class="tech-block">Spring 6.2</div>
                <div class="tech-block">MyBatis 3.5</div>
                <div class="tech-block">MySQL 8.0</div>
                <div class="tech-block">Bootstrap 5</div>
                <div class="tech-block">Maven</div>
                <div class="tech-block">BCrypt</div>
                <div class="tech-block">Logback</div>
                <div class="tech-block">JDK 23</div>
            </div>

            <h3>核心功能</h3>
            <ul class="line-list">
                <li>商品二级分类 + 关键词搜索，支持分类筛选与模糊匹配</li>
                <li>无需登录即可下单（访客购买模式），降低使用门槛</li>
                <li>扫码支付（微信 / 支付宝 / USDT），支付后自动发货</li>
                <li>卡密自动发放，基于悲观锁 + CAS 乐观锁保证并发安全</li>
                <li>凭联系方式 + 查询密码匿名查单，支持无账号用户查询订单</li>
                <li>完整后台管理：商品 / 分类 / 订单 / 卡密 / 用户 / 数据统计</li>
            </ul>
        </section>

        <div class="paper-divider"></div>

        <!-- ====== 02 系统架构 ====== -->
        <section id="sec-arch" class="paper-section">
            <h2 class="section-heading"><span class="heading-num">02</span> 系统架构设计</h2>

            <img src="${pageContext.request.contextPath}/static/images/about/02-ssm-architecture.png"
                 class="paper-img" alt="SSM架构"
                 onerror="this.style.display='none'">

            <p>项目采用经典的 SSM 三层架构。浏览器请求经 DispatcherServlet 分发到对应 Controller，Controller 完成参数校验后调用 Service 层处理业务逻辑，Service 层通过 MyBatis Mapper 执行数据库操作，最终返回 JSP 视图渲染响应。</p>

            <!-- 主流程 -->
            <div class="arch-flow-v">
                <div class="arch-v-row">
                    <div class="arch-box-v">浏览器<small>HTTP Request</small></div>
                </div>
                <div class="arch-v-arrow">↓</div>
                <div class="arch-v-row">
                    <div class="arch-box-v main">DispatcherServlet<small>Spring MVC 前端控制器</small></div>
                </div>
                <div class="arch-v-arrow">↓</div>
                <div class="arch-v-row side-row">
                    <div class="arch-v-stack">
                        <div class="arch-box-v">Controller<small>接收请求 · 参数校验 · 响应分发</small></div>
                        <div class="arch-v-arrow">↓</div>
                        <div class="arch-box-v">Service<small>业务逻辑 · 事务管理 · 异常处理</small></div>
                        <div class="arch-v-arrow">↓</div>
                        <div class="arch-box-v">Mapper (MyBatis)<small>SQL 映射 · 数据库操作</small></div>
                        <div class="arch-v-arrow">↓</div>
                        <div class="arch-box-v dashed">MySQL<small>数据持久化</small></div>
                    </div>
                    <div class="arch-v-side">
                        <div class="arch-side-note">
                            <strong>Interceptor</strong>
                            <span>登录鉴权 · CSRF Token 验证<br>路径拦截 · Session 检查</span>
                        </div>
                        <div class="arch-side-note">
                            <strong>Filter</strong>
                            <span>UTF-8 编码 · CSRF Token 注入<br>请求预处理</span>
                        </div>
                        <div class="arch-side-note">
                            <strong>JSP 视图</strong>
                            <span>页面渲染 · 数据绑定<br>JSTL 标签 · EL 表达式</span>
                        </div>
                    </div>
                </div>
            </div>

            <h3>请求生命周期</h3>
            <ul class="line-list">
                <li><strong>客户端</strong> 发送 HTTP 请求，经过 CharacterEncodingFilter 编码处理</li>
                <li><strong>CsrfTokenFilter</strong> 生成/验证 CSRF Token，注入 request attribute</li>
                <li><strong>LoginInterceptor</strong> 检查 Session 登录状态，未登录重定向</li>
                <li><strong>DispatcherServlet</strong> 通过 HandlerMapping 匹配 Controller 方法</li>
                <li><strong>Controller</strong> 接收参数，调用 Service，返回视图名或重定向</li>
                <li><strong>Service</strong> 执行业务逻辑，<code>@Transactional</code> 管理事务边界</li>
                <li><strong>MyBatis</strong> 执行 SQL 映射，通过 Druid 连接池管理数据库连接</li>
                <li><strong>JSP</strong> 渲染 HTML 响应，<code>fn:escapeXml()</code> 防止 XSS</li>
            </ul>
        </section>

        <div class="paper-divider"></div>

        <!-- ====== 03 数据库设计 ====== -->
        <section id="sec-db" class="paper-section">
            <h2 class="section-heading"><span class="heading-num">03</span> 数据库设计</h2>

            <img src="${pageContext.request.contextPath}/static/images/about/03-database-er.png"
                 class="paper-img" alt="数据库ER"
                 onerror="this.style.display='none'">

            <p>共 7 张核心表，围绕 <code>product</code> 和 <code>mall_order</code> 两条主线组织，外键关联关系如下：</p>

            <!-- ER 关系图 -->
            <div class="er-diagram-v">
                <!-- 第一层：用户 + 分类 -->
                <div class="er-layer">
                    <div class="er-box">user<small>id · username · password(BCrypt)<br>email · phone · status</small></div>
                    <div class="er-box dashed">admin<small>id · username · password</small></div>
                    <div class="er-box dashed">category<small>id · name · parent_id<br>sort_order · status</small></div>
                </div>
                <div class="er-conn">1 : N ↓</div>
                <!-- 第二层：商品 + 订单 -->
                <div class="er-layer">
                    <div class="er-box">product<small>id · name · category_id<br>price · image · sales · status</small></div>
                    <div class="er-box main">mall_order<small>order_no · user_id<br>contact · status · pay_method<br>query_password</small></div>
                </div>
                <div class="er-conn">1 : N ↓</div>
                <!-- 第三层：SKU + 明细 + 卡密 -->
                <div class="er-layer">
                    <div class="er-box">product_sku<small>product_id · spec_name<br>price · stock · status</small></div>
                    <div class="er-box">order_item<small>order_id · product_id<br>sku_id · quantity · price</small></div>
                    <div class="er-box main">card_key<small>sku_id · content<br>status · order_item_id</small></div>
                </div>
            </div>

            <h3>关键设计决策</h3>
            <ul class="line-list">
                <li><strong>库存派生</strong>：product_sku.stock 由未售卡密 COUNT 自动决定，不手动编辑</li>
                <li><strong>密码安全</strong>：BCrypt (cost=12) 哈希存储，兼容旧 MD5 遗留密码回退验证</li>
                <li><strong>匿名查单</strong>：mall_order.contact 字段支持手机号/邮箱，无需登录即可查询</li>
                <li><strong>订单状态</strong>：status=0 待支付 / 2 已完成 / 3 已取消，通过 CAS 乐观锁更新</li>
                <li><strong>卡密状态</strong>：status=0 未售 / 1 已售 / 2 冻结，分配时 SELECT FOR UPDATE 行锁</li>
            </ul>

            <details>
                <summary>查看完整字段表</summary>
                <div style="overflow-x: auto; margin-top: 12px;">
                    <table class="sketch-table">
                        <thead><tr><th>表名</th><th>核心字段</th><th>说明</th></tr></thead>
                        <tbody>
                            <tr><td><code>user</code></td><td>username, password, email, phone</td><td>密码 BCrypt 哈希，status=1 正常</td></tr>
                            <tr><td><code>admin</code></td><td>username, password</td><td>管理员账户，独立管理表</td></tr>
                            <tr><td><code>category</code></td><td>name, parent_id, sort_order</td><td>二级分类，parent_id=0 为一级</td></tr>
                            <tr><td><code>product</code></td><td>name, category_id, price, image</td><td>商品基本信息，sales 自动累加</td></tr>
                            <tr><td><code>product_sku</code></td><td>product_id, spec_name, price, stock</td><td>商品规格，stock 由卡密数决定</td></tr>
                            <tr><td><code>mall_order</code></td><td>order_no, user_id, contact, status</td><td>0 待支付 / 2 已完成 / 3 已取消</td></tr>
                            <tr><td><code>order_item</code></td><td>order_id, sku_id, quantity, price</td><td>订单明细，记录下单时快照</td></tr>
                            <tr><td><code>card_key</code></td><td>sku_id, content, status</td><td>0 未售 / 1 已售 / 2 冻结</td></tr>
                        </tbody>
                    </table>
                </div>
            </details>
        </section>

        <div class="paper-divider"></div>

        <!-- ====== 04 业务流程 ====== -->
        <section id="sec-flow" class="paper-section">
            <h2 class="section-heading"><span class="heading-num">04</span> 核心业务流程</h2>

            <h3>购物流程</h3>
            <img src="${pageContext.request.contextPath}/static/images/about/04-purchase-flow.png"
                 class="paper-img" alt="购物流程"
                 onerror="this.style.display='none'">

            <p>用户从首页浏览商品，选择规格后进入下单页填写联系方式和查询密码，提交后生成订单并跳转至支付页面。确认付款后，系统自动完成卡密分配和订单完结。</p>

            <div class="flow-steps">
                <div class="flow-step">浏览选品</div>
                <span class="flow-arrow">→</span>
                <div class="flow-step">选规格填信息</div>
                <span class="flow-arrow">→</span>
                <div class="flow-step">提交订单</div>
                <span class="flow-arrow">→</span>
                <div class="flow-step">扫码支付</div>
                <span class="flow-arrow">→</span>
                <div class="flow-step hl">自动发货</div>
            </div>

            <p>核心自动发货逻辑在 <code>OrderServiceImpl.userConfirmPay()</code> 中实现，整个过程在一个 <code>@Transactional</code> 事务中完成，保证原子性：</p>

            <ul class="line-list">
                <li><strong>Step 1</strong>：校验订单状态必须为「待支付」</li>
                <li><strong>Step 2</strong>：遍历订单明细，为每个 SKU 执行 <code>cardKeyService.allocateKeys()</code></li>
                <li><strong>Step 3</strong>：<code>SELECT ... FOR UPDATE</code> 锁定未售卡密，防止并发分配</li>
                <li><strong>Step 4</strong>：批量更新卡密状态为已售（CAS：<code>WHERE status = 0</code>）</li>
                <li><strong>Step 5</strong>：更新商品销量，扣减 SKU 库存</li>
            </ul>

            <h3>卡密分配与并发安全</h3>
            <img src="${pageContext.request.contextPath}/static/images/about/05-cardkey-concurrency.png"
                 class="paper-img" alt="卡密并发安全"
                 onerror="this.style.display='none'">

            <p>当多个用户同时购买同一 SKU 时，系统通过两层锁机制保证卡密不会被重复分配：</p>

            <ul class="line-list">
                <li><strong>悲观锁</strong>：<code>SELECT ... FOR UPDATE</code> 在事务中锁定目标卡密行，其他事务必须等待</li>
                <li><strong>CAS 乐观锁</strong>：<code>batchUpdateStatus</code> 时加 <code>WHERE status = &#35;{expectedStatus}</code>，防止更新冲突</li>
                <li><strong>库存同步</strong>：库存值由 <code>COUNT(*) WHERE status=0</code> 派生，不手动维护，避免不一致</li>
            </ul>

            <h3>订单状态机</h3>
            <div class="state-flow">
                <div class="state-node">待支付<small>status = 0</small></div>
                <div class="state-branch">
                    <div class="branch-row">
                        <span class="branch-arrow">→ 确认付款 →</span>
                        <div class="state-node hl">已完成<small>status = 2</small></div>
                        <span class="branch-note">自动发货</span>
                    </div>
                    <div class="branch-row">
                        <span class="branch-arrow">→ 取消订单 →</span>
                        <div class="state-node dashed">已取消<small>status = 3</small></div>
                        <span class="branch-note">释放卡密 + 恢复库存</span>
                    </div>
                </div>
            </div>

            <p>取消订单时，系统自动将已分配的卡密批量恢复为未售状态，并恢复 SKU 库存。所有状态更新均使用 <code>UPDATE ... WHERE status = &#35;{expectedStatus}</code> 保证并发安全。</p>
        </section>

        <div class="paper-divider"></div>

        <!-- ====== 05 安全设计 ====== -->
        <section id="sec-security" class="paper-section">
            <h2 class="section-heading"><span class="heading-num">05</span> 安全设计</h2>

            <img src="${pageContext.request.contextPath}/static/images/about/06-security-gates.png"
                 class="paper-img" alt="安全设计"
                 onerror="this.style.display='none'">

            <p>项目从认证、授权、输入校验、并发控制四个层面构建安全防护体系：</p>

            <div class="security-list">
                <div class="sec-item">
                    <span class="sec-num">01</span>
                    <div>
                        <strong>BCrypt 密码加密</strong>
                        <p>使用 BCrypt (cost=12) 对密码进行单向哈希存储。登录时先按用户名查用户，再在 Java 层本地校验密码，避免用户枚举攻击。兼容旧 MD5 遗留密码回退验证，支持平滑迁移。</p>
                    </div>
                </div>
                <div class="sec-item">
                    <span class="sec-num">02</span>
                    <div>
                        <strong>CSRF Token 防护</strong>
                        <p>CsrfTokenFilter 在每次请求时生成 64 字符随机 Token 存入 Session，所有 POST 表单携带 hidden 字段 _csrf。拦截器使用 <code>MessageDigest.isEqual()</code> 进行时序安全比较，防止时序攻击。</p>
                    </div>
                </div>
                <div class="sec-item">
                    <span class="sec-num">03</span>
                    <div>
                        <strong>XSS 防护</strong>
                        <p>全部 30+ 处用户输入输出使用 <code>fn:escapeXml()</code> 转义，覆盖页面标题 param.title、搜索关键词 keyword、联系方式 contact、商品名称、订单号等所有动态内容。</p>
                    </div>
                </div>
                <div class="sec-item">
                    <span class="sec-num">04</span>
                    <div>
                        <strong>登录限流</strong>
                        <p>管理员登录采用 Session 级失败计数，连续 5 次失败后锁定并提示刷新。登录成功后通过 <code>session.invalidate()</code> + <code>request.getSession(true)</code> 防止 Session Fixation 攻击。Session 中不存储密码哈希。</p>
                    </div>
                </div>
                <div class="sec-item">
                    <span class="sec-num">05</span>
                    <div>
                        <strong>并发控制</strong>
                        <p>卡密分配使用 <code>SELECT ... FOR UPDATE</code> 悲观锁 + CAS 乐观锁双重保障。订单状态更新均使用 <code>WHERE status = &#35;{expectedStatus}</code> 原子操作，防止并发覆盖。所有写操作标注 <code>@Transactional</code>。</p>
                    </div>
                </div>
            </div>
        </section>

        <div class="paper-divider"></div>

        <!-- ====== 06 项目目录 ====== -->
        <section id="sec-tree" class="paper-section">
            <h2 class="section-heading"><span class="heading-num">06</span> 项目目录</h2>

            <details open>
                <summary>src/main/java/com/mall/</summary>
<pre>├── controller/
│   ├── shop/        # ProductController, PayController, AboutController
│   ├── user/        # UserController, OrderController
│   └── admin/       # AdminController + 5 个管理 Controller
├── service/
│   └── impl/        # 业务实现（@Transactional 事务管理）
├── mapper/          # MyBatis Mapper 接口（8 个）
├── entity/          # 实体类（User, Product, Order, CardKey...）
├── dto/             # ProductQueryDTO, OrderCreateDTO, PageResult
├── filter/          # CsrfTokenFilter（CSRF Token 生成/验证）
├── interceptor/     # LoginInterceptor, AdminInterceptor
└── util/            # PasswordUtil, CsrfToken, OrderNoGenerator, QRCodeGenerator</pre>
            </details>

            <details>
                <summary>src/main/resources/</summary>
<pre>├── mapper/              # MyBatis XML 映射文件（8 个）
│   ├── UserMapper.xml       # 用户 CRUD + 登录验证
│   ├── ProductMapper.xml    # 商品查询 + 分类筛选
│   ├── OrderMapper.xml      # 订单管理 + 状态更新
│   └── CardKeyMapper.xml    # 卡密分配 + FOR UPDATE 锁
├── spring-dao.xml       # Druid 数据源 + MyBatis 配置
├── spring-service.xml   # 事务管理器 + 注解驱动
├── spring-web.xml       # MVC + 拦截器映射配置
├── logback.xml          # 日志配置（替代 Log4j 1.x）
├── db.properties        # 数据库连接（支持环境变量覆盖）
└── init.sql             # 建库建表 + 63 个初始商品数据</pre>
            </details>

            <details>
                <summary>src/main/webapp/</summary>
<pre>├── WEB-INF/
│   ├── web.xml                    # Servlet + Filter + Session 配置
│   └── views/
│       ├── common/    header.jsp, footer.jsp, error.jsp
│       ├── front/     index, product/*, order/*, user/*, about.jsp
│       └── admin/     login, index, product/*, order/*, cardkey/*, user/*
├── static/
│   ├── css/style.css              # 全局样式 + about 手稿风样式
│   ├── fonts/                     # ZCOOL KuaiLe 等本地手写字体
│   └── images/                    # 商品封面 + about/ 配图目录</pre>
            </details>

            <img src="${pageContext.request.contextPath}/static/images/about/07-conclusion.png"
                 class="paper-img" alt="技术收获"
                 onerror="this.style.display='none'">
        </section>

    </main>

    <!-- ====== 右侧悬挂小绳 + 猫爪印 ====== -->
    <div class="hang-rope" id="hangRope">
        <div class="rope-line" id="ropeLine"></div>
        <div class="rope-paw-wrap" id="ropeKnot" title="回到顶部" onclick="window.scrollTo({top:0,behavior:'smooth'})">
            <img src="${pageContext.request.contextPath}/static/images/about/paw-print.svg"
                 class="rope-paw-img" alt="黑色猫爪印回到顶部">
        </div>
    </div>
</div>

<!-- 阅读进度 + 目录高亮 -->
<script>
(function() {
    var sections = document.querySelectorAll('.paper-section');
    var tocLinks = document.querySelectorAll('.toc-link');
    var progressBar = document.getElementById('progressBar');
    var progressText = document.getElementById('progressText');
    var ropeLine = document.getElementById('ropeLine');
    var hangRope = document.getElementById('hangRope');
    var ropeStillTimer = null;

    function updateProgress() {
        var scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        var docHeight = document.documentElement.scrollHeight - window.innerHeight;
        var percent = Math.min(100, Math.round((scrollTop / docHeight) * 100));
        progressBar.style.width = percent + '%';
        progressText.textContent = percent + '%';
    }

    function updateActiveToc() {
        var scrollPos = window.pageYOffset + 140;
        var current = '';
        sections.forEach(function(sec) {
            if (sec.offsetTop <= scrollPos) current = sec.id;
        });
        tocLinks.forEach(function(link) {
            link.classList.toggle('active', link.getAttribute('data-sec') === current);
        });
    }

    function updateRopeHeight() {
        if (!ropeLine || !hangRope) return;
        var scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        var docHeight = document.documentElement.scrollHeight - window.innerHeight;
        var percent = docHeight > 0 ? Math.min(1, scrollTop / docHeight) : 0;
        ropeLine.style.height = (percent * 100) + '%';
    }

    function swingRope() {
        if (!hangRope) return;

        hangRope.classList.add('is-swinging');

        window.clearTimeout(ropeStillTimer);
        ropeStillTimer = window.setTimeout(function() {
            hangRope.classList.remove('is-swinging');
        }, 700);
    }

    window.addEventListener('scroll', function() {
        updateProgress();
        updateActiveToc();
        updateRopeHeight();
    });

    tocLinks.forEach(function(link) {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            var target = document.getElementById(this.getAttribute('data-sec'));
            if (target) window.scrollTo({ top: target.offsetTop - 100, behavior: 'smooth' });
        });
    });

    updateProgress();
    updateActiveToc();
    updateRopeHeight();
})();
</script>

<%@ include file="../common/footer.jsp" %>
