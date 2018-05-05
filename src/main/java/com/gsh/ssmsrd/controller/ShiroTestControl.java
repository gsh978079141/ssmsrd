//package com.gsh.ssmsrd.controller;
//
//import org.apache.shiro.SecurityUtils;
//import org.apache.shiro.authc.UsernamePasswordToken;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RestController;
//
//@RestController
//public class ShiroTestControl {
//
//    @RequestMapping(value="/login",method= RequestMethod.POST)
//    public String login(String username, String password,String vcode,Boolean rememberMe){
//        System.out.println("ShiroTestControl中/login");
//        rememberMe=false;
//        System.out.println(username);
//        UsernamePasswordToken token = new UsernamePasswordToken(username, password,rememberMe);
//        SecurityUtils.getSubject().login(token);
//        return "loginSuccess";
//    }
//
////    @RequestMapping(value="/index",method=RequestMethod.GET)
////    public String home(){
////        System.out.println("ShiroTestControl中/index");
////        Subject subject = SecurityUtils.getSubject();
////        User principal = (User)subject.getPrincipal();
////        return "Home";
////    }
//
//}