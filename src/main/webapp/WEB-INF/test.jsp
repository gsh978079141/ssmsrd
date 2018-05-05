<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>test.jsp</title>

</head>
<body >
test.jsp

<shiro:hasPermission name="add"><li>增加</li></shiro:hasPermission>
<shiro:hasPermission name="del"><li>删除</li></shiro:hasPermission>

</body>
</html>
