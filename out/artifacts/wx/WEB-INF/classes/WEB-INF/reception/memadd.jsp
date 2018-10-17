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
	<script type="text/javascript">
</script>
	<style type="text/css">
		input{
			margin-left:3px;
			width:80px;
			height: 25px;
		}
		label{
 				font-size: 25px;
 				color: rgb(51,107,155);
		}
	</style>
  </head>
  
  <body>
  	<h1>新会员办理</h1>
  	<h3>会员基本信息：</h3>
  
  <hr>
	<div>
	   		 <form id="ff" method="post" action="mem/addmem.do">
	    	<div>
	    		   会员卡号:
			<input id="memnum" name="memnum" class="easyui-validatebox" missingMessage="请填写会员卡号" data-options="prompt:'六位会员卡号',required:true,validType:'multiple[\'digits\',\'length[0,5]\']'" onblur="v_memnum()" style="width:100px;">  
				   会员等级：<input type="hidden" name="memType.id" value="1">会员密码<input name="mempass" type="password" >
				   <select class="easyui-combobox" name="memtype" disabled="disabled" style="width: 100px"><option value="1" selected="selected">普通会员</option></select></div><br/>
	    	<div>手机号码：<input class="easyui-textbox" type="text" id="tel" name="tel" data-options="prompt:'手机号必填',required:true,validType:'telphone'" style="width: 120px" size="11" name="tel"></input>
	    		  <input type="button" id="hsbtn" onclick="sendmsg();" value="获取验证码" style="width: 150px;" />
	    		  <input class="easyui-textbox" type="text" id="srtelmsg" data-options="prompt:'6位数验证码',required:true" style="width: 100px" maxlength="6"></input><br/></div>
	<h3>会员身份信息：</h3>
<hr/>				<input type="hidden" name="state" value="1" >
		   		<div>
		   		真实姓名：<input class="easyui-textbox" type="text" name="memname" data-options="required:true"></input>证件类型:<select class="easyui-combobox" name="idtype.id" style="width:100px;" id="idtype">
							<option value="1" selected="selected">身份证</option>
							<option value="2">学生证</option>
							<option value="3">军人证</option>
							<option value="4">驾驶证</option>
							<option value="5">护照</option>
							<option value="6">员工证</option>
							<option value="7">其他</option>
						</select>
	    		身份证号:<input class="easyui-textbox" type="text" name="idnum" data-options="prompt:'身份证号',required:true" id="idnum" style="width: 170px;"></input>
	    		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="v_idnum()"  iconCls="icon-lock">读取</a>
	    		<br/><br/>
					<input class="easyui-textbox" type="text" id="province"name="province" data-options="required:true" readonly="readonly" style="width: 45px"></input>省
					<input class="easyui-textbox" type="text" id="city"name="city" data-options="required:true" readonly="readonly" style="width: 45px"></input>市
					<input class="easyui-textbox" type="text" id="town"name="town" data-options="required:true" readonly="readonly" style="width: 55px"></input>
					性别：<input class="easyui-textbox" type="text" id="sex" name="sex" data-options="required:true" readonly="readonly" style="width: 45px"></input>
					生日：<input class="easyui-textbox" type="text" id="birth" name="birthday" data-options="required:true" readonly="readonly" style="width: 150px"></input>
					地址：<input class="easyui-textbox" type="text" name="area" id="area" data-options="required:true" readonly="readonly" style="width: 150px"></input>	    		
	    		</div>
	<hr/>		<h3>其他信息：</h3>
	<hr/>	
	    	<div>备注:<input class="easyui-textbox" name="remark" data-options="multiline:true,prompt:'饮食口味或者其他住房习惯'" style="height:60px;width: 250px;"></input>
	    	</div>
	    	</form>
	 <hr/><br><br/><br>
		    <div style="padding:5px;margin-left: 200px;">
		    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" iconCls="icon-ok"><label>确认办理</label></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()"><label>重填信息</label></a>
		    </div>
   </div>
   <input type="hidden" id="telmsg" value="">
				<script>
				function submitForm(){
						if($("#telmsg").val()!=$("#srtelmsg").val()||$("#telmsg").val()==""){
							$.messager.alert('提示:','验证码错误！','error'); 	
						}
						
						else {
						$.messager.confirm('会员办理 ', '确认办理？ ', function(r){
								if (r){
									$.ajax({  
				                    type: "post",  
				                    url: "mem/addmem.do",  
				                    data: $("#ff").serialize(),  
				                    success: function () {
										$.messager.show({
									title:'提示 ',
									msg:'新会员 办理成功',
									timeout:500,
									showType:'slide',
									 style: { 
							                right: '', 
							                bottom: ''
							              } 
										});				                    	}  
				                		});  
								}
							});
						}
					}
					function clearForm(){
						$('#ff').form('clear');
					}
				  /*S 验证码按钮 ,发送验证码 */
				  var wait = 60;
				  function sendmsg(){
				  var tel=$("#tel").val(); 
				  if(tel.length==11){
			    	$.post("jump/gettelmsg.do",{tel:tel},function msg(data){
			    		$("#telmsg").val(data.telmsg);
			    	});
				  	mytime();
				  	}
				  	else{
				  		$.messager.alert('提示:','请输入正确手机号','error'); 	
				  	}
				  }
			    function mytime() {
			    var btnObj=document.getElementById("hsbtn");
				        if (wait == 0) {
			            btnObj.removeAttribute("disabled");
			            btnObj.value = "再次获取验证码";
			            wait = 60;
			        } else {
			            btnObj.setAttribute("disabled", true);
			            btnObj.value = "重新发送验证码(" + wait + "s)";
			            wait--;
			            setTimeout(function() {
			                    mytime(btnObj)
			                },1000)
			        }
			    }
				/*E 验证码按钮 ,发送验证码 */
			    /*卡号 和身份证检测 v_idnum,v_memnum*/
			    function v_memnum(){
			    	$.post("mem/getlist.do",{memnum:$("#memnum").val()},function(data){
			    			if(data.total!=0){
			    			$("#memnum").val("");
			    			$.messager.alert('提示:','会员卡号已存在！','error'); 	
			    				}
			    			});
			  		  	}
				 function v_idnum(){
				  var idnum=$("#idnum").val();
				  	  if(idnum.length==18){
						$.post("jump/checkid.do",{idnum:idnum},function(data){
								data=eval("("+data+")");
								if(data.status==0){
									var idinfo=data.result;
									$("#province").textbox('setValue',idinfo.province);
									$("#city").textbox('setValue',idinfo.city);
									$("#town").textbox('setValue',idinfo.town);
									$("#sex").textbox('setValue',idinfo.sex);
									$("#birth").textbox('setValue',idinfo.birth);
									$("#area").textbox('setValue',idinfo.area);									
								}
								else{
			    				$.messager.alert('提示:','身份信息有误！请核实！','error'); 	
								}
			   				 });
			   			}
			   			else	
			   					$.messager.alert('提示:','请输入有效身份证号','error'); 	
					}
				</script>
				
				
  </body>
</html>
