<%@ page contentType="application/vnd.ms-excel" language="java" import="java.util.*,com.gsh.controller.SystemControl" pageEncoding="utf-8"%>
<%@page import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%	
	//乱码处理 
	String tablename = (request.getParameter("tablename")).replaceAll("%(?![0-9a-fA-F]{2})", "%25");
	String theadname= java.net.URLDecoder.decode(request.getParameter("theadname"), "UTF-8");
	//String theadname = java.net.URLDecoder.decode(request.getParameter("theadname"), "UTF-8");
	response.setHeader("Content-Disposition", "attachment;filename="+ tablename + ".xls");//指定下载的文件名 
	response.setContentType("application/vnd.ms-excel");
	ApplicationContext ac=new ClassPathXmlApplicationContext("spring/applicationContext.xml");
	SystemControl we = (SystemControl)ac.getBean("systemControl");
	we.outExcel(theadname,tablename,response.getOutputStream());
	out = pageContext.getOut();
	out.clear();
	out = pageContext.pushBody();
%> 