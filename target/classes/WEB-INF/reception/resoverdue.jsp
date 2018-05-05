<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>main</title>
    
	<link rel="stylesheet" type="text/css" href="css/common.css" />
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/bootstrap/easyui.css" />
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css" />
	<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui/locale/easyui-lang-zh_CN.js"></script>
  </head>
  <body>
			<table class="easyui-datagrid" title="逾期未入住" id="reslist" data-options="rownumbers:true,singleSelect:true,url:'res/getlist.do?act=overdue',method:'get',toolbar:'#tb',fit:true,pagination:true,
							rowStyler: function(index ,record){
								/*订单取消状态变色*/
								 if(record.resstate =='取消'){return 'background:#BEBEBE';}}">
						<thead>
							<tr>
								<th data-options="field:'resnumber',width:125">预订单号</th>
								<th data-options="field:'roomnum',width:55">房间号</th>
								<th data-options="field:'resname',width:50">预定人</th>
								<th data-options="field:'restel',width:100">预定手机号</th>
								<th data-options="field:'starttime',width:150">预抵时间</th>
								<th data-options="field:'resstate',width:40">状态</th>
								<th data-options="field:'_operate',width:40,formatter:rowformater">操作</th>	
								<th data-options="field:'remark',width:180">备注</th>
							</tr>
						</thead>
					</table>
						<script type="text/javascript"> 
					function rowformater(value, row, index) { 
							if(row.resstate=="取消") 
								return "<a href='javascript:back("+index+");' style='background:color:blue;' target='_self'>"+"还原</a>";
							else 
								return "<a href='javascript:cancel("+index+");'style='background:color:blue;' target='_self'> " + "取消</a>";
							}  
						//取消
					 	function cancel(index) {
						 	corb("取消成功",index,"取消订单","确定取消此订单吗？");
						}
						//还原
						function back(index,msg,title,tips){
						 	corb("还原成功",index,"还原","确定还原吗？");
						}
						//还原或者取消
						function corb(msg,index,title,tips){
							 var row = $('#reslist').datagrid('getData').size[index];
							 var resnumber=row.resnumber;
									$.messager.confirm(title, tips, function(r){
											$.post("res/corb.do",{resnumber:resnumber},function tip(data){
													if(data=="no"){
														$.messager.show({
																	title: '提示',
																	msg:'还原失败，房间已被预订，抱歉。。。。',
																	showType:'slide',
																	 style: { 
															                right: '', 
															                bottom: '',
															                time: 400,
															              } 
																});
															}
													else{
														$.messager.show({
																title: '提示',
																msg:msg,
																showType:'slide',
																 style: { 
														                right: '', 
														                bottom: '',
														              } 
															});
															$('#reslist').datagrid('reload');
													}
					    						});
					    						
										});
						}
   			 </script>
						<div id="tb" style="padding:5px;height:auto">
							<div>
								<form action="">
								<a ></a>
								订单状态: 
								<select class="easyui-combobox" panelHeight="auto" style="width:100px">
									<option value="正常">正常</option>
									<option value="取消">取消</option>
								</select>
								<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-search">Search</a>
								</form>
							</div>
						</div>
		  
  
  	
  </body>
</html>
