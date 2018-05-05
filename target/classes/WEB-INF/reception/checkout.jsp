<%@page import="com.gsh.model.Room"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
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
	
	<style type="text/css">
		input{
			margin-left:15px;
			width: 80px;
			
		}
		label{
 				font-size: 25px;
 				color: rgb(51,107,155);
		}
		#divbtn{
			margin-top:30px;
			margin-left: 150px;
		}
		.infos{
			background-color: rgb(239,239,239);
			margin:  20px 10px;
			padding: 5px;
		    justify-content: space-around;	
		    	}
		   .minput{
		   		color: rgb(51,107,155);
		   }
	</style>
	
	
  </head>
<body>
<script type="text/javascript">
	//
	$(function(){
		$("#memdiv").hide();
// 		$.ajax({
// 			url="";
// 		});
		
	});
	function paymethod() {
		if($("#paymethod").val()==4){
			$("#memdiv").show();
		}
		else{
			$("#memdiv").hide();
		}
	}
	
	function v_memnum(){
			var memnum=$("#memnum").val();
			if(memnum.length==5){
				$.post("mem/crisearch.do",{memnum:memnum},function(data){
					if(data.total!=0){
							var mem=data.size[0];
							if(mem.state=="2"){
								$.messager.alert('提示:','会员卡 已挂失储值锁定  ...','error'); 	
							}
							else if(mem.state=="3"){
								$.messager.alert('警告 :','黑名单会员 无权操作 ...','error'); 	
							}
							else{
							$('#memid').val(mem.id);
							$('#memtype').val(mem.memType.typename);
							$('#memname').val(mem.memname);
							$('#leftmoney').val(mem.leftmoney);
							$('#password').val(mem.mempass);
							$('#memid').val(mem.id);
							}
						}
						else{
							 $.messager.show({ 
							              title: '提示消息', 
							              msg: '会员卡号不存在，请检查 ', 
							              showType: 'fade', 
							              timeout: 400, 
							              style: { 
							                right: '', 
							                bottom: ''
							              } 
							            }); 
							            
						}
				});
			   }
			 else	
			   $.messager.alert('提示:','会员卡号为五位纯数字','error'); 
		}
	
</script>
	<div>
			<div id="divroominfo" class="infos">
				<label>房号:&nbsp;${con.roomnum}</label><input  name="roomnum" id="roomnum" type="hidden" value="${con.roomnum}">
				姓名:<label style="font-size: 15px">${con.guestname}</label>
				入住时间:${con.starttime}
				入账单号：<label style="font-size: 15px">${con.ordernum}</label>
			</div>	
			<div id="conlist">
				<table class="easyui-datagrid" title="房间消费明细" style="width:650px;height:250px"
						data-options="singleSelect:true,collapsible:true">
					<thead>
						<tr>
							<th data-options="field:'itemname',width:80">消费项目</th>
							<th data-options="field:'itemprice',width:60,align:'right'">项目单价</th>
							<th data-options="field:'amount',width:40,align:'right'">数量</th>
							<th data-options="field:'totalprice',width:60,align:'right'">消费金额</th>
							<th data-options="field:'paymethod',width:60">支付方式</th>
							<th data-options="field:'payprice',width:60">支付金额</th>
							<th data-options="field:'booktime',width:150">入账时间</th>
							<th data-options="field:'bookkeeper',width:80">操作员</th>
							<th data-options="field:'remark',width:160">备注</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="con" items="${con.roomConLists}">  
						<tr>
						<td>${con.itemname}</td>
						<td>${con.itemprice}</td>
						<td>${con.amount}</td>
						<td>${con.totalprice}</td>
						<td>${con.paymethod.name}</td>
						<td>${con.payprice}</td>
						<td>${con.bookitime}</td>
						<td>${con.bookkeeper}</td>
						<td>${con.remark}</td>
						</tr>
						</c:forEach>  
					</tbody>
				</table>
			</div>
			<div style="margin-top: 15px; margin-left:25px;" class="infos">
				消费金额：<input type="text" name="totalmoney"  id="totalmoney" value="${totalmoney}" class="minput" readonly="readonly">
				已收金额：<input type="text" name="totalmoney" id="paymoney"  value="${paymoney}" class="minput" readonly="readonly">
					<c:choose>
					   <c:when test="${needmoney<0}">  
					       应退金额：<input type="text" name="totalmoney" id="needmoney"  value="${-needmoney}" class="minput" readonly="readonly">
					   </c:when>
					   <c:otherwise> 
					    	应收金额：<input type="text" name="totalmoney" id="needmoney"  value="${needmoney}" class="minput" readonly="readonly">
					   </c:otherwise>
					</c:choose>
					<br><br>
					
					手工单号:<input type="text" name="handnum" id="handnum">
					备注:<input type="text" name="remark" id="remark"  value="" style="width: 350px;height: 25px;">
			</div>
			
			<div class="infos" style="margin-left:25px;" >
					支付方式:<select name="paymethod" onchange="paymethod();" id="paymethod">
									<option value="1">现金</option>
									<option value="4">储值卡</option>
									<option value="3">网上支付</option>
									<option value="5">信用卡</option>
									<option value="6">酒店员工</option>
								</select>
					<div id="memdiv" style="float: right; margin-right: 5px;">会员卡：<input type="text" readonly="readonly"><a href="javascript:$('#memdialog').dialog('open')">选择</a></div>
						<c:choose>
					   <c:when test="${needmoney<0}">  
					       应退金额：<input type="text" name="totalmoney" id="needmoney"  value="${-needmoney}" class="minput" readonly="readonly">
					   </c:when>
					   <c:otherwise> 
					    	应收金额：<input type="text" name="totalmoney" id="needmoney"  value="${needmoney}" class="minput" readonly="readonly">
					   </c:otherwise>
					</c:choose>	
					收款金额:<input type="text" id="getmoney" name="getmoney" placeholder="负退款,正收款" >
			</div>
					<div id="divbtn">
			    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()"><label>结账退房</label></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()"><label>取消退房</label></a>
					<script type="text/javascript">
							function submitForm(){
							if($("#getmoney").val()==""){
								$.messager.alert('提示  ','请填写收款金额','warning');										
							}
							else{
							$.messager.defaults = { ok: "确定", cancel: "登记赔偿" };
							$.messager.confirm('结账退房', "楼层保洁员通知查房完毕，且房间物品无损坏退房", function(r){
								if (r){
									$.messager.prompt('确认退房', '营业员验证', function(r){
									if (r!=${sessionScope.userpass}){
										$.messager.alert('提示  ','密码错误 ,无法执行','warning');										
									}
									else{
										checkoutend("");
									}
									});	
								}
								 else  {
								 		$.messager.prompt('注意', '请先填写赔偿明细', function(r){
											checkoutend(r);                                                                                                                                                                                                                                              
										});
								 }										
							});
							}
					}
					
		function checkoutend(remark){
			$.post("room/checkoutend.do",{ordernum:${con.ordernum},handnum:$("#handnum").val(),totalmoney:${totalmoney},mcash:$("#getmoney").val(),conid:${con.id},remark:$("#remark").val(),roomnum:$("#roomnum").val()},
							function(data){
											if(data!="no"){
														$.messager.show({
																title:'提示',
																msg:'已退房',
																timeout:200,
																showType:'slide',
																 style: { 
														                right: '', 
														                bottom: ''
														              } 
															});
													}
										});
							}
					
					</script>
=					</div>
					<!-- S 储值卡支付 -->
					<div class="easyui-dialog" id="memdialog" closed="true" title="快捷支付" style="padding: 15px;" >
						<h2>储值卡支付</h2>
							<input type="hidden" id="memid" name="id">
							<form id="payform">
							<input type="hidden" id="password">
							卡&nbsp;&nbsp;&nbsp;号:<input  name="memnum" id="memnum" type="text">
							<a href="javascript:void(0)" class="easyui-linkbutton" onclick="v_memnum();"  iconCls="icon-lock">读取</a><br>
							类&nbsp;&nbsp;&nbsp;型:<input  name="memtype" id="memtype" type="text" readonly="readonly"><br>
							姓&nbsp;&nbsp;&nbsp;名:<input  name="memname" id="memname" type="text" readonly="readonly"><br>
							余&nbsp;&nbsp;&nbsp;额:<input  name="leftmony" id="leftmoney" type="text" readonly="readonly">元<br>
							本次支付:<input  name="mempay" id="mempay" type="text" style="margin-left: 5px;">元<br>
							密&nbsp;&nbsp;&nbsp;码:<input  name="password" id="srpass" type="password"><br>
							</form>
							<input type="button" value="确认" onclick="sure();" > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="关闭" onclick="close();">
				</div>
					<!-- E 储值卡支付 -->
				<script type="text/javascript">
					function sure(){
						var pass1=$('#password').val();
						var pass2=$('#srpass').val();
						var left=parseFloat($('#leftmoney').val());
						var mempay=parseFloat($('#mempay').val());
						if(pass1==pass2){
							if(left>mempay){
									$.post("mem/pay.do",{id:$("#memid").val(),mempay:mempay,conid:${con.id}},function msg(){
										$('#payform').get(0).reset();
										//$('#myform').form('clear');
										$('#memdialog').dialog('close');
										parent.$('#win-cz').window('close');
								    });
								}
									else{
									$.messager.alert('提示','余额不足，无法支付....... ','warning');
									
									}
						}
						
						else{
							$.messager.alert('提示','密码错误....... ','warning');
							}
					}
					//关闭储值卡充值弹窗
					function close(){
						$('#memdialog').dialog('close');
					}
					//取消退房
					function clearForm(){
						parent.$('#win-cz').window('close');
					}
					
				
					
				</script>
	</div>
</body>
</html>
