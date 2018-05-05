package com.gsh.ssmsrd.model;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.io.Serializable;
import java.util.List;

/**
 * <p>
 * 
 * </p>
 *
 * @author gsh123
 * @since 2018-03-22
 */
@TableName("role")
public class Role extends Model<Role> implements Serializable{

    private static final long serialVersionUID = 1L;

    @TableId(value = "roleid", type = IdType.AUTO)
    private Integer roleid;
    /**
     * 酒店ID
     */
    private Integer hid;
    private String rolename;
    private String rolecode;
    /**
     * 1正常0停用
     */
    private Integer rolestate;
    private String roledesc;

    public Integer getRoleid() {
        return roleid;
    }

    public void setRoleid(Integer roleid) {
        this.roleid = roleid;
    }

    public Integer getHid() {
        return hid;
    }

    public void setHid(Integer hid) {
        this.hid = hid;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
    }

    public String getRolecode() {
        return rolecode;
    }

    public void setRolecode(String rolecode) {
        this.rolecode = rolecode;
    }

    public Integer getRolestate() {
        return rolestate;
    }

    public void setRolestate(Integer rolestate) {
        this.rolestate = rolestate;
    }

    public String getRoledesc() {
        return roledesc;
    }

    public void setRoledesc(String roledesc) {
        this.roledesc = roledesc;
    }

    @Override
    protected Serializable pkVal() {
        return this.roleid;
    }

    @Override
    public String toString() {
        return "Role{" +
        "roleid=" + roleid +
        ", hid=" + hid +
        ", rolename=" + rolename +
        ", rolecode=" + rolecode +
        ", rolestate=" + rolestate +
        ", roledesc=" + roledesc +
        "}";
    }
}
