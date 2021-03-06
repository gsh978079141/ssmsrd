package com.gsh.ssmsrd.model;
/**  
    * @Title: PageInfo
    * @Package com.gsh.ssmsrd.model
    * @Description: 
    * @author gsh
    * @date 2018/7/10 15:59
    */
@SuppressWarnings("ALL")
public class PageInfo {
    private Integer page;
    private Integer size;
    public Integer getPage() {
        return page;
    }
    public void setPage(Integer page) {
        this.page = page;
    }
    public Integer getSize() {
        return size;
    }
    public void setSize(Integer size) {
        this.size = size;
    }
    public PageInfo(Integer page, Integer rows) {
        super();
        this.page = page;
        this.size = rows;
    }
    public PageInfo() {
        super();
    }
    @Override
    public String toString() {
        System.out.println("page="+this.page);
        System.out.println("size="+this.size);
        return super.toString();
    }
}
