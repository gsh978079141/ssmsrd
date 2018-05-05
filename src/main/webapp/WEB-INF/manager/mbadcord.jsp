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
						cordnum: $('#searcordnum').val(),
						memnum: $('#searmemnum').val(),
						cordtype: $('#searcordtype').combobox('getValue')
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
		<table class="easyui-datagrid"  id="typelist" data-options="rownumbers:true,singleSelect:true,url:'res/getlistBAD.do',method:'post',toolbar:'#tb', 
							fit:true,pagination: true , 
							pageSize: 5 ,striped: true ,	
							pageList:[5,10,15,20,50] ,
							loadMsg: '数据加载中......',
								 striped: true">
						<thead>
							<tr>
								<th data-options="field:'cordnum',width:170,align:'center'">记录单号</th>
								<th data-options="field:'memnum',width:80,align:'center'">会员卡号</th>
								<th data-options="field:'cordname',width:80,align:'center'">记录姓名</th>
								<th data-options="field:'cordtype',width:75,align:'center'">记录类型</th>	
								<th data-options="field:'tel',width:95,align:'center'">联系方式</th>	
								<th data-options="field:'cordtime',width:180,align:'center'">记录时间</th>
								<th data-options="field:'bookkeeper',width:80">操作员</th>
								<th data-options="field:'remark',width:360,align:'center'">详细信息</th>	
							</tr>
						</thead>
					</table>
					<input type="hidden" id="Htypeid" />
					<!-- S 搜索域  -->
						<div id="tb" style="padding:5px;height:auto">
							<div>
								<form method="post" id="mysearch">
								充值单号：<input type="text" id="searcordnum" name="searcordnum"  value="" class="easyui-textbox" style="width:160px;"/>
								会员卡号：<input type="text" id="searmemnum" name="searmemnum"  value="" class="easyui-textbox" style="width:80px;"/>
								记录类型: 
								<select class="easyui-combobox" panelHeight="auto" style="width:100px" name="searcordtype" id="searcordtype">
									<option value="">全部记录</option>
									<option value="逾期">逾期记录</option>
									<option value="严重">严重记录</option>
									<option value="其他">其他记录</option>
								</select>
								<a id="serachbtn"  class="easyui-linkbutton" iconCls="icon-search">查询</a>
								<a id="clearbtn" class="easyui-linkbutton" >清空</a>
								</form> 
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">新增</a>
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">删除</a>
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a>
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">撤销</a>
							</div>
						</div>
					<!-- E 搜索域  -->
	</div>

	<div style="margin:20px 0;">
	</div>
		
  </body>
</html>
