//package com.gsh.ssmsrd.config.shiro;
///**
//    * @Title: MyExceptionHandler
//    * @Package com.gsh.ssmsrd.config.shiro
//    * @Description: Shiro框架会根据用户登录及权限状态抛出异常，
//    * 使用全局异常捕获来处理异常，避免重复代码
//    * @author gsh
//    * @date 2018/3/31 下午5:54
//    */
//import org.apache.shiro.authz.UnauthenticatedException;
//import org.apache.shiro.authz.UnauthorizedException;
//import org.springframework.web.servlet.HandlerExceptionResolver;
//import org.springframework.web.servlet.ModelAndView;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.util.HashMap;
//import java.util.Map;
//
///**
// * Created by Administrator on 2017/12/11.
// * 全局异常处理
// */
//@SuppressWarnings("ALL")
//public class MyExceptionHandler implements HandlerExceptionResolver {
//
//    @Override
//    public ModelAndView resolveException(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception ex) {
//        ModelAndView mv = new ModelAndView();
//        Map<String, Object> attributes = new HashMap<String, Object>();
//        if (ex instanceof UnauthenticatedException) {
//            attributes.put("code", "1000001");
//            attributes.put("msg", "token错误");
//        } else if (ex instanceof UnauthorizedException) {
//            attributes.put("code", "1000002");
//            attributes.put("msg", "用户无权限");
//        } else {
//            attributes.put("code", "1000003");
//            attributes.put("msg", ex.getMessage());
//        }
//        mv.addAllObjects(attributes);
//        return mv;
//    }
//}
