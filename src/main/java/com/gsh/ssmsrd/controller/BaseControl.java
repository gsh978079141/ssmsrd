package com.gsh.ssmsrd.controller;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.gsh.ssmsrd.util.IDCardCheck;
import com.gsh.ssmsrd.util.SmsUtil;
/**
 *
 *<p>Title:BaseControl </p>
 *<p style="color:green;">Description:基础控制器 ，主要功能（1）页面跳转 (2)数据库备份</p>
 *<p>Company: </p>
 *@author gdd
 *@date 2017-12-30 下午4:00:02
 */
@Controller
@RequestMapping("jump")
public class BaseControl {
    @RequestMapping("/{folder}/{page}.do")
    public String to(@PathVariable String folder, @PathVariable String page){
		return folder+"/"+page;
    }
    /**
     *
     *Description:<p style="color:red">导出Excel </p>
     *@param tablename 要导出的表名
     *@param theadname 表头信息，以“，”隔开
     *@param model 通过model向前台传值
     *@return
     *@throws UnsupportedEncodingException
     */
    @RequestMapping("/manager/download.do")
    public String backup(String tablename, String theadname,ModelMap model) throws UnsupportedEncodingException{
        model.put("tablename", tablename);
        model.put("theadname", theadname);
        return "manager/download";
    }

    /**
     *
     <p style="color:green;">Description :手机验证码生成与发送</p>
     * Map<String,Object>
     * @param tel 手机号
     * @return
     */
    @RequestMapping("/gettelmsg.do")
    @ResponseBody
    public Map<String, Object> sms(String tel){
        Map<String, Object> map = new HashMap<String, Object>(2);
        int randnum=(int)((Math.random()*9+1)*100000);
        String code="您的验证码是："+randnum+"。请不要把验证码泄露给其他人。";
        System.out.println(randnum);
//        调用发送手机验证码接口
//        SmsUtil.sendSms2(tel, code);
        map.put("msg", "ok");
        map.put("telmsg", randnum);
        return  map;
    }
    /**
     *
     <p style="color:green;">Description :身份信息校验</p>
     * Map<String,String>
     * @param idnum
     * @return
     */
    @RequestMapping(value="/checkid.do",produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String checkid(String idnum){
        String idinfo=IDCardCheck.checkid(idnum);
        return  idinfo;
    }
}
