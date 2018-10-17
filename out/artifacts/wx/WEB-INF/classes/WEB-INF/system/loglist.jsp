<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>极限星空酒店管理-后台管理</title>
  	<link rel="stylesheet" type="text/css" href="css/common.css" />
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/bootstrap/easyui.css" />
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css" />
	<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
		var typeid=0; 
			$(function(){
             	 //查询--查询按钮事件 
			$('#serachbtn').click(function(){
				$('#typelist').datagrid('load' ,{
						module: $('#searmodule').val(),
						operation: $('#searoperation').combobox('getValue')
					});
				});
			//查询--清空按钮事件
			$('#clearbtn').click(function(){
						$('#mysearch').form('clear');
						$('#typelist').datagrid('load' ,{});
					});
		});
		
</script>
	</head>
	<body>
  	<div style="float: left;width: 100%;height: 95%;">
		<table class="easyui-datagrid"  id="typelist" data-options="rownumbers:true,singleSelect:true,url:'sys/getloglist.do',method:'post',toolbar:'#tb', 
							fit:true,pagination: true , 
							pageSize: 5 ,striped: true ,	
							pageList:[5,10,15,20,50] ,
							loadMsg: '数据加载中......',
								 striped: true">
						<thead>
							<tr>
								<th data-options="field:'userName',width:180,align:'center'">操作人</th>
								<th data-options="field:'createTime',width:80,align:'center'">操作时间</th>
								<th data-options="field:'operation',width:80">操作类型</th>
								<th data-options="field:'module',width:180,align:'center'">所属模块</th>
								<th data-options="field:'content',width:360,align:'center'">详细内容</th>	
								<th data-options="field:'ip',width:80,align:'center'">IP地址</th>	
							</tr>
						</thead>
					</table>
					<input type="hidden" id="Htypeid" />
					<!-- S 搜索域  -->
						<div id="tb" style="padding:5px;height:auto">
							<div>
								<form method="post" id="mysearch">
								所属模块：<input type="text" id="searmodule" name="searmodule"  value="" class="easyui-textbox" style="width:160px;"/>
								操作类型: 
								<select class="easyui-combobox" panelHeight="auto" style="width:100px" name="searoperation" id="searoperation">
									<option value="">全部</option>
									<option value="删除">删除</option>
									<option value="添加">添加</option>
									<option value="修改">修改</option>
								</select>
								<a id="serachbtn"  class="easyui-linkbutton" iconCls="icon-search">查询</a>
								<a id="clearbtn" class="easyui-linkbutton" >清空</a>
								</form>
							</div>
						</div>
					<!-- E 搜索域  -->
	</div>

	<div style="margin:20px 0;">
	</div>
		
  </body>
</html>
