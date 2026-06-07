package com.mall.dto;

public class PageResult {
    private int page;        // 当前页码
    private int pageSize;    // 每页条数
    private int totalCount;  // 总记录数
    private int totalPage;   // 总页数
    private Object list;     // 数据列表

    public PageResult() {
        this.page = 1;
        this.pageSize = 10;
    }

    public PageResult(int page, int pageSize) {
        this.page = page < 1 ? 1 : page;
        this.pageSize = pageSize < 1 ? 10 : pageSize;
    }

    public int getOffset() {
        return (page - 1) * pageSize;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        this.totalPage = (totalCount + pageSize - 1) / pageSize;
    }

    // Getters & Setters
    public int getPage() { return page; }
    public void setPage(int page) { this.page = page; }
    public int getPageSize() { return pageSize; }
    public void setPageSize(int pageSize) { this.pageSize = pageSize; }
    public int getTotalCount() { return totalCount; }
    public int getTotalPage() { return totalPage; }
    public Object getList() { return list; }
    public void setList(Object list) { this.list = list; }
}
