<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html >
<head>
    <base href="<%=basePath%>">
<title>获得账号</title>

<script src="js/jquery-1.9.1.js"type="text/javascript"></script>
<link href="css/zhuce/zhuce.css" rel="stylesheet" type="text/css"/>
</head>
<body>
	<div class="login_logo" style="height: 80px;margin-left: 80px;" >
		<img src="images/logo.png" width="200px" height="80px" style="float: left"/>
		<div style="padding: 0px;"><div style="padding-top: 30px;font-size: 17px;">注册</div>
		<div style="font-size: 15px;margin-left: 950px;margin-bottom: 100px;"><a href=""<%=basePath%>"/tologin.do">立即登录</a>||<a href=""<%=basePath%>"/toforgetmm.do">找回密码</a></div>
		</div>
	</div>
	<hr />
	<div class="form-bak" style="margin-top: 100px;background-image:images/login_bgx.gif;height: 500px;" >
		<form id="regForm">
			<div class="left">
				<div class="line" id="line_name">
					<div class="info">
						<strong>用户名</strong> <span class="tips">数字、字母或下划线组成<br />最多12个字符</span>
					</div>
					<div class="input">
						<input type="text" name="username" id="username" onblur="v_name();"
							onblur="v_name();"/>
						<div class="none">
							<span></span>
						</div>
					</div>
				</div>
				<div class="line" id="line_password">
					<div class="info">
						<strong>密码</strong> <span class="tips">6至16个字符</span>
					</div>
					<div class="input">
						<input type="password" name="password" id="password"
							onblur="v_password();" onkeyup="v_password();" />
						<div class="none">
							<span></span>
						</div>
					</div>
				</div>

				<div class="line" id="line_repeat">
					<div class="info">
						<strong>确认密码</strong> <span class="tips">再次输入密码</span>
					</div>
					<div class="input">
						<input type="password" name="repeat" id="repeat"
							onblur="v_repeat();" onkeyup="v_repeat();" />
						<div class="none">
							<span></span>
						</div>
					</div>
				</div>
				<div class="line" id="line_tel">
					<div class="info">
						<strong>手机号</strong> <span class="tips">绑定的信息</span>
					<input type="button" id="hsbtn" onclick="sendmsg();" value="获取验证码" style="width: 140px;margin-left : 220px;margin-top: 8px;" />
					</div>
					<div class="input">
						<input type="text" name="tel" id="tel"
							onblur="v_tel();" onkeyup="v_tel();" />
						<div class="none">
							<span></span>
						</div>
					</div>
				</div>
				<div class="line" id="line_telcode">
					<div class="info">
						<strong>验证码：</strong> <span class="tips">手机验证码</span>
						<input  type="hidden" id="code"/>
					</div>
					<div class="input">
						<input type="text" name="telcode" id="telcode" onblur="v_telcode();" />
						<div class="none">
							<span></span>
						</div>
					</div>
				</div>
				<script>
				 /*S 验证码按钮  
				  ,发送验证码 */
				  var wait = 60;
				  function sendmsg(){
				  var tel=$("#tel").val(); 
				  if(flags[0]){
			    	$.post('jump/gettelmsg.do',{tel:tel},function msg(data){
			    		$("#code").val(data.telmsg);
			    	});
				  	mytime();
				  	}
				  	else{
						lineState("tel", "error", "手机号格式不正确");
						flags[0] = false;
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
			                    mytime(btnObj);
			                },1000);
			        }
			    }
				/*E 验证码按钮 ,发送验证码 */
				</script>
				
			</div>

			<div class="right">
				<%--<input type="submit" id="submit" value="完成注册" disabled="disabled" />--%>
				<input type="button" id="submit" value="完成注册" disabled="disabled" onclick="login();" />

				<div class="readagreement-wrap" onclick="onReadAgreementClick();">
					<input type="checkbox" name="agree" id="agree" onclick="v_submitbutton();" /> 同意《<a id="readagreement"
						href="#agreement" onclick="showAgreement();" title="查看用户使用协议">用户使用协议</a>》
				</div>
			</div>
		</form>
	</div>

	<div id="agreement" class="agreement" style="display:none;">
		<h1>用户使用协议</h1>
		<iframe src=""></iframe>
		<input type="button" value="同意" onclick="agree();" /> <a href="#"
			class="backtotop">返回顶部</a>
	</div>

	<script type="text/javascript">
		function enableSubmit(bool) {
			if (bool)
				$("#submit").removeAttr("disabled");
			else
				$("#submit").attr("disabled", "disabled");
		}
	
		function v_submitbutton() {
		
			if (!$('#agree').is(':checked')) {
				enableSubmit(false);
				$(".readagreement-wrap").css("outline", "1px solid red");
				return;
			} else {
				$(".readagreement-wrap").css("outline", "1px solid green");
			}
			for (f in flags){
				if (!flags[f]) {
					enableSubmit(false);
					return;
					}
				}
			enableSubmit(true);
		}

		function showAgreement() {
			$("#readagreement").removeAttr("onclick");
			$("#agreement").show();
			$("#agreement iframe").attr("src", "agree.html");//此处为链接地址
		}

		function agree() {
			$("#agreement").hide();
			$("#readagreement").attr("onclick", "showAgreement();");
			if ($("#agree").attr("checked") != "checked")
				$("#agree").trigger("click");
		}

		function onReadAgreementClick() {
			return;
			if ($("#agree").attr("checked")) {
				$("#agree").removeAttr("checked");
			} else {
				$("#agree").attr("checked", "checked");
			}
			v_submitbutton();
		}

		var flags = [ false, false, false, false,false];

		//手机验证，网上找到的正则
		var RegEmail = /^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/;
		function lineState(name, state, msg) {
			if (state == "none") {
				$("#line_" + name + " .input div").attr("class", "none");
				return;
			}
			if (state == "corect") {
				$("#line_" + name + " .input div").attr("class", "corect");
				return;
			}
			$("#line_" + name + " .input span").text(msg);
			$("#line_" + name + " .input div").attr("class", "error");
		}

		function v_tel() {
			var tel = $("#tel").val();
			if (!RegEmail.test(tel)) {
				lineState("tel", "error", "手机号格式不正确");
				flags[0] = false;
			} else {
				lineState("tel", "corect", "");
				flags[0] = true;
			}
			v_submitbutton();
		}

	
		function v_name() {
			var name = $("#username").val();
			if (name.length == 0) {
				lineState("name", "error", "不得为空");
				flags[1] = false;
			} else {
				if (name.length > 12) {
					lineState("name", "error", "必须少于12个字符");
					flags[1] = false;
				} else {
					$.ajax({
						//请求方式
						type : "post",
						//发送请求地址 
						url : "user/checkname.do",
						data:{"username":name},  
						//data:"username="+encodeURI(encodeURI(name)), 
        				dataType:"json",  
						//超时时间：30秒 
						timeout : 30000,
						//设置返回数据的格式 
						//请求成功后的回调函数 data为json格式 
						success : function(data) {
							if (data.msg == "no") {
								lineState("name", "error", "用户名已存在！");
								flags[1] = false;
							} else {
								lineState("name", "corect", "");
								flags[1] = true;
							}
						},
						//请求出错的处理 
						error : function() {
							alert("请求出错");
						}
					});
				}
			}
			v_submitbutton();
		}

		function v_password() {
			var password = $("#password").val();
			if (password.length < 6) {
				lineState("password", "error", "必须多于或等于6个字符");
				flags[2] = false;
			} else {
				if (password.length > 16) {
					lineState("password", "error", "必须少于或等于16个字符");
					flags[2] = false;
				} else {
					lineState("password", "corect", "");
					flags[2] = true;
				}
			}
			v_repeat();
			v_submitbutton();
		}
		function  v_telcode() {
			var telcode = $("#telcode").val();
			var code=$("#code").val();
				if (telcode.length ==0||telcode!=code ) {
					lineState("telcode", "error", "请输入正确验证码");
					flags[4] = false;
				} else {
					lineState("telcode", "corect", "");
					flags[4] = true;
				}
			v_submitbutton();
		}
		function v_repeat() {
			if (!flags[2]) {
				lineState("repeat", "none", "");
				return;
			}
			if ($("#password").val() != $("#repeat").val()) {
				lineState("repeat", "error", "密码不一致");
				flags[3] = false;
			} else {
				lineState("repeat", "corect", "");
				flags[3] = true;
			}
			v_submitbutton();
		}
		function login() {
		    var data=$("#regForm").serialize();
            $.post("user/reg.do", function(data) {
                if (data.status == 'ok') {
                    if( confirm("注册成功现在去登录？")){
                        window.location.href("loginin.do");
					}
				}else{
                    alert("注册信息有误！");
				}
            });
        }
	</script>
<div style="text-align: center;color:rgb(202,202,202);font-size: 13px;margin-top: 30px;" align="center">© 2017 wddgsh.com 版权所有 ICP证：苏B2-20080101</div>

</body>
</html>