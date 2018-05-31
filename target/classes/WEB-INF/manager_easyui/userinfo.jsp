<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>用户界面</title>
		<link rel="stylesheet" type="text/css" href="css/common.css" />
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<link rel="stylesheet" type="text/css" href="js/easyui/themes/bootstrap/easyui.css" />
		<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css" />
		<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="js/easyui/locale/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript">
			/**************************start shif *********************/
					//-------------------------------------------------------------------------------  
			// 当然页面文件中还需要引入的文件如下：  
			// easyui.css 和其它页面用到的CSS文件  
			// jquery-1-8-3-min.js, easyui-lang-zh_CN.js, jquery-easyui-min.js, datagrid-detailview.js,  和其它页面用到的JS文件  
			//-------------------------------------------------------------------------------  
			//     结合SHIFT,CTRL,ALT键实现单选或多选  
			//-------------------------------------------------------------------------------  
				var KEY = { SHIFT:16, CTRL:17, ALT:18, DOWN:40, RIGHT:39, UP:38, LEFT:37};    
				var selectIndexs = {firstSelectRowIndex:0, lastSelectRowIndex:0};  
				var inputFlags = {isShiftDown:false, isCtrlDown:false, isAltDown:false};  
  
				function keyPress(event){//响应键盘按下事件  
				    var e = event || window.event;    
				    var code = e.keyCode | e.which | e.charCode;        
				    switch(code) {    
				        case KEY.SHIFT:    
				        inputFlags.isShiftDown = true;  
				        $('#t_user').datagrid('options').singleSelect = false;             
				        break;  
				    case KEY.CTRL:  
				        inputFlags.isCtrlDown = true;  
				        $('#t_user').datagrid('options').singleSelect = false;             
				        break;  
				    /* 
				    case KEY.ALT:    
				        inputFlags.isAltDown = true; 
				        $('#dataListTable').datagrid('options').singleSelect = false;            
				        break; 
				    */    
				    default:          
				    }  
			}  
	  
				function keyRelease(event) { //响应键盘按键放开的事件  
				    var e = event || window.event;    
				    var code = e.keyCode | e.which | e.charCode;        
				    switch(code) {    
				        case KEY.SHIFT:   
				        inputFlags.isShiftDown = false;  
				        selectIndexs.firstSelectRowIndex = 0;  
				        $('#t_user').datagrid('options').singleSelect = true;              
				        break;  
				    case KEY.CTRL:  
				        inputFlags.isCtrlDown = false;  
				        selectIndexs.firstSelectRowIndex = 0;  
				        $('#t_user').datagrid('options').singleSelect = true;  
				        break;  
				    /* 
				    case KEY.ALT:    
				        inputFlags.isAltDown = false; 
				        selectIndexs.firstSelectRowIndex = 0; 
				        $('#dataListTable').datagrid('options').singleSelect = true;             
				        break; 
				    */  
				    default:          
				    }  
				    /******************end shift*****************/
	}  
	
			$(function(){
			$('#writein').appendTo('.datagrid-toolbar');
			
					/**
					 * 	对于form表单的验证 
					 */
					//数值验证组件 
					$('#age').numberbox({
						min:0 , 
						max:150 ,
						required:true , 
						missingMessage:'年龄必填!' ,
						precision:0
					});
					
					//日期组件
					$('#birthday').datebox({
						required:true , 
						missingMessage:'生日必填!' ,
						editable:false
					});
					
					$('#salary').numberbox({
						min:1000 , 
						max:32000 ,
						required:true , 
						missingMessage:'薪水必填!' ,
						precision:2
					});
					
					//日期时间组件
					$('#startTime,#endtime').datebox({
						required:true , 
						missingMessage:'时间必填!' ,
						editable:false
					});
				
					
					var flag ;		//undefined 判断新增和修改方法 
					/**
					 *	初始化数据表格  
					 */
					$('#t_user').datagrid({
							idField:'id' ,		//只要创建数据表格 就必须要加 ifField
							title:'用户列表' ,
							//fit:true ,
							url:'user/getlist.do',
							fitColumns:true ,  
							striped: true ,					//隔行变色特性 
							//nowrap: false ,				//折行显示 为true 显示在一会 
							loadMsg: '数据正在加载,请耐心的等待...' ,
							rownumbers:true ,
							singleSelect:true ,				//单选模式 
							//remoteSort: false ,
							//sortName: 'salary' ,
							//sortOrder: 'desc' ,
							rowStyler: function(index ,record){
								/*年龄大于25行变红色*/
								 //if(record.age > 25){
								//	 return "background:red";
								// }
								 // console.info(index);
								 // console.info(record);
							} ,
							frozenColumns:[[				//冻结列特性 ,不要与fitColumns 特性一起使用 
								{
									field:'ck' ,
									width:50 ,
									checkbox: true
								}
							]],
							columns:[[
									{
										field:'usernum' ,
										title:'员工工号' ,
										width:90 ,
										
									},
									{
										field:'username' ,
										title:'用户名' ,
										width:100 ,
										align:'center' ,
										styler:function(value , record){
											if(value == 'admin'){
												return 'background:blue;';
											}
										} ,
										editor:{
											type:'validatebox' ,
											options:{
												required:true , 
												missingMessage:'用户名必填!'
											}
										}
									},
									{
										field:'userRole',
										title:'职务' ,
										width:100  ,
										formatter:function(value , record , index){
													return value.role.rolename; 
										} ,
										
									},{
										field:'age' ,
										title:'年龄' ,
										width:80 ,
										sortable : true ,
										
									},{
										field:'sex' , 
										title:'性别' ,
										width:50 ,
										formatter:function(value , record , index){
														if(value == 1){
															return '<span style=color:#eee8ff; >男</span>' ;
														} else if( value == 2){
															return '<span style=color:green; >女</span>' ; 
														}
										} , 
									},{
										field:'birthday' ,
										title:'生日' ,
										width:100 ,
										sortable : true ,
										
									},{
										field:'starttime' , 
										title:'开始时间' , 
										width:150 ,
									
									},{
										field:'endtime' , 
										title:'结束时间' ,  
										width:150 ,
										
									},{
										field:'city' ,
										title:'所属城市' ,
										width:100 ,
										formatter:function(value , record , index){
														return value.name;
										},
										
									},{
										field:'salary' ,
										title:'薪水' ,
										width:100 ,
										editor:{
											type:'numberbox' , 
											options:{
												required:true , 
												missingMessage:'薪水必填!' ,
												min:1000 , 
												max:32000 ,
												precision:2
											}
										}
									},{
										field:'description' ,
										title:'个人描述' ,
										width:150 , 
										formatter:function(value , record , index){
														return '<span title='+value+'>'+value+'</span>';
										} ,
									
									}
								]] ,
								onClickRow:function(index,row){   
						    //-------------for TEST 结合SHIFT,CTRL,ALT键实现单选或多选----------------      
						    if(index != selectIndexs.firstSelectRowIndex && !inputFlags.isShiftDown ){    
						        selectIndexs.firstSelectRowIndex = index; //alert('firstSelectRowIndex, sfhit = ' + index);  
						    }             
						    if(inputFlags.isShiftDown ) {  
						        $('#dataListTable').datagrid('clearSelections');                  
						        selectIndexs.lastSelectRowIndex = index;  
						        var tempIndex = 0;  
						        if(selectIndexs.firstSelectRowIndex > selectIndexs.lastSelectRowIndex ){  
						            tempIndex = selectIndexs.firstSelectRowIndex;  
						            selectIndexs.firstSelectRowIndex = selectIndexs.lastSelectRowIndex;  
						            selectIndexs.lastSelectRowIndex = tempIndex;  
						        }  
						        for(var i = selectIndexs.firstSelectRowIndex ; i <= selectIndexs.lastSelectRowIndex ; i++){  
						            $('#dataListTable').datagrid('selectRow', i);     
						        }     
						    }             
						    //-------------for TEST 结合SHIFT,CTRL,ALT键实现单选或多选----------------  
							} , 
							pagination: true , 
							pageSize: 10 ,
							onLoadSuccess: onloadS,
							pageList:[5,10,15,20,50] ,
							toolbar:[
								{
									text:'新增用户' ,
									iconCls:'icon-add' , 
									handler:function(){
										flag = 'add';
										$('#mydialog').dialog({
												title:'新增用户' 
										});
										//$('#myform').find('input[name!=sex]').val("");
										$('#myform').get(0).reset();
										//$('#myform').form('clear');
										$('#mydialog').dialog('open');
									
									}
									
								},{
									text:'修改用户' ,
									iconCls:'icon-edit' , 
									handler:function(){
										flag = 'edit';
										var arr =$('#t_user').datagrid('getSelections');
										if(arr.length != 1){
											$.messager.show({
												title:'提示信息!',
												msg:'只能选择一行记录进行修改!',
												timeout:320
											});
										} else {
											$('#mydialog').dialog({
												title:'修改用户'
											});
											$('#mydialog').dialog('open'); //打开窗口
											$('#myform').get(0).reset();   //清空表单数据 
											$('#myform').form('load',{	   //调用load方法把所选中的数据load到表单中,非常方便
												id:arr[0].id ,
												usernum:arr[0].usernum,
												username:arr[0].username ,
												password:arr[0].password ,
												sex:arr[0].sex ,
												age:arr[0].age ,
												birthday:arr[0].birthday ,
												cityname:arr[0].city.name,
												salary:arr[0].salary ,
												starttime:arr[0].starttime,
												endtime:arr[0].endtime ,
												description:arr[0].description
											});
										}
									
									}
								},{
									text:'删除用户' ,
									iconCls:'icon-remove' , 
									handler:function(){
											var arr =$('#t_user').datagrid('getSelections');
											if(arr.length <=0){
												$.messager.show({
													title:'提示信息!',
													msg:'至少选择一行记录进行删除!'
												});
											} else {
												
												$.messager.confirm('提示信息' , '确认删除这'+arr.length+'条数据?' , function(r){
														if(r){
																var ids = '';
																for(var i =0 ;i<arr.length;i++){
																	ids += arr[i].id + ',' ;
																}
																ids = ids.substring(0 , ids.length-1);
																$.post('user/delete.do' , {ids:ids} , function(result){
																	//1 刷新数据表格 
																	$('#t_user').datagrid('reload');
																	//2 清空idField   
																	$('#t_user').datagrid('unselectAll');
																	//3 给提示信息 
																	$.messager.show({
																		title:'提示信息!' , 
																		msg:'操作成功!',
																		timeout:320
																		
																	});
																});
														} else {
															return ;
														}
												});
											}
									}								
								},{
									text:'查询用户' , 
									iconCls:'icon-search' , 
									handler:function(){
											$('#lay').layout('expand' , 'north');
									}
								},
								/*start 导出EXL */
								{
									text:'导出EXL' , 
									iconCls:'icon-print' , 
									handler:function(){
								// 获得表头的列值
									var opts = $('#t_user').datagrid('getColumnFields'); //这是获取到所有的FIELD
											var TheadName=[];
											for(var i=0;i<opts.length;i++)
											{
											var col = $('#t_user').datagrid( "getColumnOption" , opts[i] );
											TheadName.push(col.title);//把TITLEPUSH到数组里去
											}			
												
								// 获得表头的列值 
												
												$.messager.confirm('提示信息' , '确认导出Exc文件?' , function(r){
														if(r){
																window.location.href="jump/manager/download.do?tablename=User&theadname="+encodeURI(encodeURI(TheadName));
																$.post('download.jsp' , {filename:'员工信息表',tablename:'User'} , function(result){
																	//3 给提示信息 
																	$.messager.show({
																		title:'提示信息!' , 
																		msg:'操作成功!',
																		timeout:320
																		
																	});
																});
														} else {
															return ;
														}
												});
									}
								},
								/*end  导出EXL */
								/* start 备份数据库  */
								{
									text:'备份数据库' , 
									iconCls:'icon-print' , 
									handler:function(){
												$.messager.confirm('提示信息' , '将覆盖原有的备份文件，确认备份?' , function(r){
														if(r){
																$.post('sys/backup.do' , {filename:'员工信息表',tablename:'User'} , function(result){
																	//3 给提示信息 
																	$.messager.show({
																		title:'提示信息!' , 
																		msg:'备份成功!'
																	});
																});
														} else {
															return ;
														}
												});
									}
								}
								/* end 备份数据库  */
							]
							
					});
					
					
					/**
					 *  提交表单方法
					 */
					$('#btn1').click(function(){
							if($('#myform').form('validate')){
								$.ajax({
									type: 'post' ,
									url: flag=='add'?'user/save.do':'user/update.do' ,
									cache:false ,
									data:$('#myform').serialize(),	
									dataType:'json' ,
									success:function(result){
										//1 关闭窗口
										$('#mydialog').dialog('close');
										//2刷新datagrid 
										$('#t_user').datagrid('reload');
										//3 提示信息
										$.messager.show({
											title:result.status , 
											msg:result.message,
											timeout:320
											
										});
									} ,
									error:function(result){
										$.meesager.show({
											title:result.status , 
											msg:result.message,
											timeout:320
											
										});
									}
								});
							} else {
								$.messager.show({
									title:'提示信息!' ,
									msg:'数据验证不通过,不能保存!',
									timeout:320
								});
							}
					});
					
					/**
					 * 关闭窗口方法
					 */
					$('#btn2').click(function(){
						$('#mydialog').dialog('close');
					});
					
						
					$('#searchbtn').click(function(){
						$('#t_user').datagrid('load' ,serializeForm($('#mysearch')));
					});
					
					
					$('#clearbtn').click(function(){
						$('#mysearch').form('clear');
						$('#t_user').datagrid('load' ,{});
					});
					

			});
			
			//js方法：序列化表单 			
			function serializeForm(form){
				var obj = {};
				$.each(form.serializeArray(),function(index){
					if(obj[this['name']]){
						obj[this['name']] = obj[this['name']] + ','+this['value'];
					} else {
						obj[this['name']] =this['value'];
					}
				});
				return obj;
			}
			//无数据提示信息
			function onloadS(data) {
					            if (data.total == 0) {
								    var body = $(this).data().datagrid.dc.body2;
								    body.find('table tbody').append('<div width="' + body.width() + '"style="text-align:center;color:black;" ><img src="images/no-data.png"/>未找到符合条件信息</div></td></tr>');
			  			     	 $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
								  }					          
					            else $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
					        }
	</script>
	</head>

	<body class="body01" onkeydown="javascript:keyPress(event);"onkeyup="javascript:keyRelease(event);">
		<div id="lay" class="easyui-layout" style="width: 100%; height: 95%">
		<!-- start search userinfo -->
			<div region="north" title="用户查询" collapsed=true
				style="height: 100px;">
				<form id="mysearch" method="post">
					用户名:&nbsp;&nbsp;&nbsp;
					<input name="username" class="easyui-validatebox" value="" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 开始时间:
					<input name="starttime" class="easyui-datebox" editable="false"
						style="width: 160px;" value="" />
					结束时间:
					<input name="endtime" class="easyui-datebox"  editable="false"
						style="width: 160px;" value="" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a id="searchbtn" class="easyui-linkbutton">查询</a>
					<a id="clearbtn" class="easyui-linkbutton">清空</a>
				</form>
			</div>
		<!-- end search userinfo -->
		<!-- start table userinfo -->
			<div region="center">
				<table id="t_user" style="width: 100%;height: 95%;"></table>
			</div>
		<!-- end table userinfo -->
		<!-- start dialog adduser-->
		<div id="mydialog" title="新增用户" modal="true" draggable="false"
			class="easyui-dialog" closed="true" style="width: 300px;">
			<form id="myform" action="" method="post">
				<input type="hidden" name="id" value="" />
				<table>
					<tr>
						<td>
							员工工号:
						</td>
						<td>
							<input type="text" name="usernum" value="" style=""/>
						</td>
					</tr>
					<tr>
						<td>
							用户名:
						</td>
						<td>
							<input type="text" name="username" class="easyui-validatebox"
								required=true validType="midLength[2,5]" missingMessage="用户名必填!"
								invalidMessage="用户名必须在2到5个字符之间!" value="" />
						</td>
					</tr>
					<tr>
						<td>
							密码:
						</td>
						<td>
							<input type="password" name="password" class="easyui-validatebox"
								required=true validType="equalLength[4]" missingMessage="密码必填!"
								value="" />
						</td>
					</tr>
					<tr>
						<td>
							所属职务:
						</td>
						<td>
							<input name="roleid" class="easyui-combobox" url="user/getRole.do"
								valueField="roleid" textField="rolename" value="" />
						</td>
					</tr>
					<tr>
						<td>
							性别:
						</td>
						<td>
							男
							<input type="radio" checked="checked" name="sex" value="1" />
							女
							<input type="radio" name="sex" value="2" />
						</td>
					</tr>
					<tr>
						<td>
							年龄:
						</td>
						<td>
							<input id="age" type="text" name="age" value="" />
						</td>
					</tr>
					<tr>
						<td>
							出生日期:
						</td>
						<td>
							<input id="birthday" style="width: 160px;" type="text"
								name="birthday" value="" />
						</td>
					</tr>
					<tr>
						<td>
							所属城市:
						</td>
						<td>
							<input name="cityname" type="text"  value="" />
						</td>
					</tr>
					<tr>
						<td>
							薪水:
						</td>
						<td>
							<input id="salary" type="text" name="salary" value="" />
						</td>
					</tr>
					<tr>
						<td>
							开始时间:
						</td>
						<td>
							<input id="starttime" style="width: 160px;" type="text"
								name="starttime" value="" />
						</td>
					</tr>
					<tr>
						<td>
							结束时间:
						</td>
						<td>
							<input id="endtime" style="width: 160px;" type="text"
								name="endtime" value="" />
						</td>
					</tr>
					<tr>
						<td>
							个人描述:
						</td>
						<td>
							<input type="text" name="description" class="easyui-validatebox"
								required=true validType="midLength[5,50]"
								missingMessage="个人描述必填!" invalidMessage="描述必须在5到50个字符之间!"
								value="" />
						</td>
					</tr>
					<tr align="center">
						<td colspan="2">
							<a id="btn1" class="easyui-linkbutton">确定</a>
							<a id="btn2" class="easyui-linkbutton">关闭</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<!-- end dialog adduser-->
	</div>
		<!-- start 批量导入 -->
			<script type="text/javascript">
				function checkfile() {
					//提交表单
	                 $('#writeform').form('submit',{
		              url: 'sys/inExcel.do',
	              	success: function(result){
	              	$('#t_user').datagrid('reload');
	             	 }
	        		 }); 
				}
			</script>
			 <form id="writeform"  method="post" enctype="multipart/form-data">  
			    <div>  
			        <input id="file" type="file" name="file" style="margin-top: 0px;"/>  
			        <input type="button" value="导入" onclick="checkfile();"/>  
			    </div>  
			    </form> 
		<!-- end 批量导入 -->
	</body>
</html>
