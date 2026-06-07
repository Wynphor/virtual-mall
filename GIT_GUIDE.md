# Git 协作指南 - 4人3天分工方案

## 一、Git 仓库初始化（A执行）

```bash
cd virtual-mall

# 1. 初始化仓库
git init

# 2. 创建 .gitignore
cat > .gitignore << 'EOF'
# IDEA
.idea/
*.iml
out/
target/

# Maven
target/
*.jar
*.war

# OS
.DS_Store
Thumbs.db

# Logs
*.log
EOF

# 3. 首次提交
git add .
git commit -m "feat: 初始化项目框架、数据库、全部基础代码"

# 4. 创建远程仓库（GitHub/Gitee）
# 在GitHub/Gitee上创建仓库，然后：
git remote add origin https://gitee.com/你的用户名/virtual-mall.git
git push -u origin main

# 5. 创建 dev 分支
git checkout -b dev
git push -u origin dev
```

---

## 二、4人分支策略

```
main          ← 最终交付（只合并，不直接改）
│
└── dev       ← 开发主分支（每天晚上合并一次）
    ├── feature/user      ← A负责
    ├── feature/product   ← B负责
    ├── feature/order     ← C负责
    └── feature/admin     ← D负责
```

---

## 三、4人具体文件分工

### A - 架构 + 用户模块（feature/user）
**负责文件：**
```
src/main/java/com/mall/
├── entity/User.java                  ✅
├── entity/Admin.java                 ✅
├── mapper/UserMapper.java            ✅
├── mapper/AdminMapper.java           ✅
├── service/UserService.java          ✅
├── service/AdminService.java         ✅
├── service/impl/UserServiceImpl.java ✅
├── service/impl/AdminServiceImpl.java✅
├── controller/user/UserController.java ✅
├── controller/user/OrderController.java ✅
├── controller/shop/AboutController.java ✅ （项目介绍页）
├── interceptor/LoginInterceptor.java ✅
├── interceptor/AdminInterceptor.java ✅
├── filter/CsrfTokenFilter.java       ✅ （CSRF防护）
├── util/PasswordUtil.java            ✅ （BCrypt密码工具）
├── util/CsrfToken.java               ✅ （CSRF Token工具）
├── util/OrderNoGenerator.java        ✅
└── config/                           ✅

src/main/resources/
├── mapper/UserMapper.xml             ✅
├── mapper/AdminMapper.xml            ✅
├── spring-dao.xml                    ✅
├── spring-service.xml                ✅
├── spring-web.xml                    ✅
├── db.properties                     ✅
├── logback.xml                       ✅ （替代log4j.properties）
├── mybatis-config.xml                ✅
├── init.sql                          ✅
└── fix_product_images.sql            ✅ （商品封面图更新）

src/main/webapp/
├── WEB-INF/web.xml                   ✅
├── WEB-INF/views/common/header.jsp   ✅
├── WEB-INF/views/common/footer.jsp   ✅
├── WEB-INF/views/common/error.jsp    ✅ （CSRF错误页）
├── WEB-INF/views/front/user/login.jsp    ✅
├── WEB-INF/views/front/user/register.jsp ✅
├── WEB-INF/views/front/user/orders.jsp   ✅
├── WEB-INF/views/front/about.jsp         ✅ （项目技术文档页）
├── static/css/style.css              ✅
├── static/js/common.js               ✅
├── static/fonts/                     ✅ （ZCOOL KuaiLe等手写字体）
└── static/images/about/              ✅ （项目文档配图 + rope-knot.svg）

pom.xml                               ✅
README.md                             ✅
```

### B - 商品模块（feature/product）
**负责文件：**
```
src/main/java/com/mall/
├── entity/Category.java              ✅
├── entity/Product.java               ✅
├── entity/ProductSku.java            ✅
├── dto/ProductQueryDTO.java          ✅
├── dto/PageResult.java               ✅
├── mapper/CategoryMapper.java        ✅
├── mapper/ProductMapper.java         ✅
├── mapper/ProductSkuMapper.java      ✅
├── service/CategoryService.java      ✅
├── service/ProductService.java       ✅
├── service/impl/CategoryServiceImpl.java ✅
├── service/impl/ProductServiceImpl.java  ✅
└── controller/shop/ProductController.java ✅

src/main/resources/mapper/
├── CategoryMapper.xml                ✅
├── ProductMapper.xml                 ✅
└── ProductSkuMapper.xml              ✅

src/main/webapp/WEB-INF/views/front/
├── index.jsp                         ✅
├── product/list.jsp                  ✅
└── product/detail.jsp                ✅
```

### C - 订单 + 支付模块（feature/order）
**负责文件：**
```
src/main/java/com/mall/
├── entity/Order.java                 ✅
├── entity/OrderItem.java             ✅
├── entity/CardKey.java               ✅
├── dto/OrderCreateDTO.java           ✅
├── mapper/OrderMapper.java           ✅
├── mapper/OrderItemMapper.java       ✅
├── mapper/CardKeyMapper.java         ✅
├── service/OrderService.java         ✅
├── service/CardKeyService.java       ✅
├── service/impl/OrderServiceImpl.java    ✅
├── service/impl/CardKeyServiceImpl.java  ✅
├── util/QRCodeGenerator.java         ✅
└── controller/shop/PayController.java    ✅

src/main/resources/mapper/
├── OrderMapper.xml                   ✅
├── OrderItemMapper.xml               ✅
└── CardKeyMapper.xml                 ✅

src/main/webapp/WEB-INF/views/front/order/
├── create.jsp                        ✅
├── pay.jsp                           ✅
├── success.jsp                       ✅
├── query.jsp                         ✅
└── detail.jsp                        ✅
```

### D - 后台管理模块（feature/admin）
**负责文件：**
```
src/main/java/com/mall/controller/admin/
├── AdminController.java              ✅
├── AdminCategoryController.java      ✅
├── AdminProductController.java       ✅
├── AdminOrderController.java         ✅
├── AdminCardKeyController.java       ✅
└── AdminUserController.java          ✅

src/main/webapp/WEB-INF/views/admin/
├── admin_header.jsp                  ✅
├── admin_footer.jsp                  ✅
├── login.jsp                         ✅
├── index.jsp                         ✅
├── category/list.jsp                 ✅
├── category/edit.jsp                 ✅
├── product/list.jsp                  ✅
├── product/edit.jsp                  ✅
├── product/sku_list.jsp              ✅
├── product/sku_edit.jsp              ✅
├── cardkey/list.jsp                  ✅
├── cardkey/add.jsp                   ✅
├── order/list.jsp                    ✅
├── order/detail.jsp                  ✅
└── user/list.jsp                     ✅
```

---

## 四、每人每日操作流程

### Day 1 上午：各自拉分支开始开发

**A的操作：**
```bash
git checkout dev
git pull origin dev
git checkout -b feature/user

# A已有全部代码，直接开始修改和完善用户模块
# 改完后：
git add .
git commit -m "feat(user): 完善用户注册登录功能"
git push origin feature/user
```

**B的操作：**
```bash
git clone https://gitee.com/xxx/virtual-mall.git
cd virtual-mall
git checkout dev
git checkout -b feature/product

# 开始开发商品模块
git add .
git commit -m "feat(product): 完善商品列表和详情页"
git push origin feature/product
```

**C的操作：**
```bash
git clone https://gitee.com/xxx/virtual-mall.git
cd virtual-mall
git checkout dev
git checkout -b feature/order

# 开始开发订单模块
git add .
git commit -m "feat(order): 完善下单和支付流程"
git push origin feature/order
```

**D的操作：**
```bash
git clone https://gitee.com/xxx/virtual-mall.git
cd virtual-mall
git checkout dev
git checkout -b feature/admin

# 开始开发后台管理
git add .
git commit -m "feat(admin): 完善后台管理页面"
git push origin feature/admin
```

### Day 1 晚上：合并到dev

**A执行合并（A是项目负责人）：**
```bash
git checkout dev
git merge feature/user
git merge feature/product
git merge feature/order
git merge feature/admin
git push origin dev
```

如果出现冲突，相关成员一起解决：
```bash
# 例如B的代码和C的代码冲突了
git checkout dev
git merge feature/product  # 先合B的
# 如果冲突，手动编辑冲突文件，然后：
git add .
git commit -m "merge: 解决product和order的冲突"
```

### Day 2：联调 + 修bug

每人从dev拉最新代码到自己的分支：
```bash
git checkout feature/user  # 或自己的分支
git merge dev              # 拉取其他人的最新代码
# 继续开发...
git add .
git commit -m "fix(user): 修复登录bug"
git push origin feature/user
```

### Day 3：最终合并

```bash
# 合并所有分支到dev
git checkout dev
git merge feature/user
git merge feature/product
git merge feature/order
git merge feature/admin

# dev合并到main
git checkout main
git merge dev
git push origin main

# 打tag标记版本
git tag -a v1.0 -m "虚拟数字商城v1.0 - 课程设计完成"
git push origin v1.0
```

---

## 五、Git Commit 规范

```
feat(module): 新功能描述
fix(module): 修复bug描述
docs: 文档更新
style: 代码格式调整
refactor: 重构
test: 测试相关
```

示例：
```
feat(user): 添加用户注册功能
feat(product): 实现商品分类筛选
fix(order): 修复卡密分配重复bug
feat(admin): 添加后台订单管理
fix: 修复二维码中文乱码
docs: 更新README
```

---

## 六、冲突预防策略

1. **各改各的文件**：按上面的文件分工，尽量不碰别人的文件
2. **公共文件协商**：pom.xml、web.xml、Spring配置文件只有A改
3. **每天晚上合并一次**：不要频繁合并，避免小冲突积累
4. **合并前先pull**：每次合并前先 `git pull origin dev`
5. **冲突不慌**：看清楚 <<<< HEAD 和 >>>> branch 的内容，保留两边都需要的

---

## 七、演示时的Git记录展示

答辩时可以展示：
```bash
# 查看分支图
git log --oneline --graph --all

# 查看每个人的提交
git log --author="A的名字" --oneline
git log --author="B的名字" --oneline
git log --author="C的名字" --oneline
git log --author="D的名字" --oneline

# 查看提交统计
git shortlog -sn
```

这样能清楚展示4个人各自的贡献。
