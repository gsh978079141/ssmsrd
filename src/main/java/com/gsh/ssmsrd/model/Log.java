package com.gsh.ssmsrd.model;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.io.Serializable;

/**
 * <p>
 * 操作日志记录
 * </p>
 *
 * @author gsh123
 * @since 2018-03-22
 */
@TableName("log")
public class Log extends Model<Log> {

    private static final long serialVersionUID = 1L;

    /**
     * 日志
     */
    @TableId(value = "logId", type = IdType.AUTO)
    private Integer logId;
    /**
     * 酒店ID
     */
    private Integer hid;
    /**
     * 操作人
     */
    private String userName;
    /**
     * 时间
     */
    private String createTime;
    /**
     * 详细
     */
    private String content;
    /**
     * 操作类型（增删改）
     */
    private String operation;
    /**
     * IP地址
     */
    private String ip;
    /**
     * 所属模块
     */
    private String module;


    public Integer getLogId() {
        return logId;
    }

    public void setLogId(Integer logId) {
        this.logId = logId;
    }

    public Integer getHid() {
        return hid;
    }

    public void setHid(Integer hid) {
        this.hid = hid;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getOperation() {
        return operation;
    }

    public void setOperation(String operation) {
        this.operation = operation;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getModule() {
        return module;
    }

    public void setModule(String module) {
        this.module = module;
    }

    @Override
    protected Serializable pkVal() {
        return this.logId;
    }

    @Override
    public String toString() {
        return "Log{" +
        "logId=" + logId +
        ", hid=" + hid +
        ", userName=" + userName +
        ", createTime=" + createTime +
        ", content=" + content +
        ", operation=" + operation +
        ", ip=" + ip +
        ", module=" + module +
        "}";
    }
}
