<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>登    录</title>
    <link href="css/login/login.css" rel="stylesheet" type="text/css"/>
    <link href="css/drag.css" rel="stylesheet" type="text/css"/>
    <!--S photo  -->
    <link rel="stylesheet" href="css/login/showtp.css"/>
    <!--[if IE]><link rel="stylesheet" href="css/login/ie.css"><![endif]-->
    <!--[if lte IE 9]><script type="text/javascript" src="js/ie.js"></script><![endif]-->
    <!--E photo  -->
    <script src="js/jquery-1.9.1.js"type="text/javascript"></script>
    <script src="js/login/drag.js" type="text/javascript"></script>
    <style type="text/css">
        .autoplay{
            -webkit-box-shadow: 10px 10px 10px;
            -moz-box-shadow: 10px 10px 10px;
            box-shadow: 10px 10px 10px;
            /**/
            padding:8px;
            border: 1px solid #000000;
            -moz-border-radius: 15px;
            -webkit-border-radius: 20px;
            border-radius:20px;
        }
    </style>
</head>
<body class="login" >
<!-- S top  -->
<%--<div class="login_logo" style="height: 80px;" >--%>
    <%--<img src="images/logo.png" width="200px" height="80px" style="float: left"/>--%>
    <%--<div style="padding: 0px;"><div style="padding-top: 30px;font-size: 17px;">登录</div>--%>
        <%--<div style="font-size: 15px;margin-left: 950px;margin-bottom: 100px;"><a href="zhuce.jsp">获得账号</a> |&nbsp;| <a href="forgetmm.jsp">找回密码</a></div>--%>
    <%--</div>--%>
<%--</div>--%>
<!-- E top  -->
<hr>
<%--<!-- S test -->--%>
<%--<section id="rt-showcase-surround">--%>
    <%--<div id="rt-showcase" class="slider-container rt-overlay-dark" style="float: left;width: 500px;height: 400px;margin-left: 180px;margin-top: 135px;">--%>
        <%--<div class="rt-container slider-container">--%>
            <%--<div class="rt-grid-12 rt-alpha rt-omega">--%>
                <%--<div class="csslider1 autoplay">--%>
                    <%--<input name="cs_anchor1" autocomplete="off" id="cs_slide1_0" type="radio" class="cs_anchor slide" >--%>
                    <%--<input name="cs_anchor1" autocomplete="off" id="cs_slide1_1" type="radio" class="cs_anchor slide" >--%>
                    <%--<input name="cs_anchor1" autocomplete="off" id="cs_slide1_2" type="radio" class="cs_anchor slide" >--%>
                    <%--<input name="cs_anchor1" autocomplete="off" id="cs_play1" type="radio" class="cs_anchor" checked>--%>
                    <%--<input name="cs_anchor1" autocomplete="off" id="cs_pause1" type="radio" class="cs_anchor" >--%>
                    <%--<ul>--%>
                        <%--<div style="width: 100%; visibility: hidden; font-size: 0px; line-height: 0;">--%>
                            <%--<img src="images/1.jpg" style="width: 100%;">--%>
                        <%--</div>--%>
                        <%--<li class="num0 img">--%>
                            <%--<img src="images/1.jpg" alt="Clouds" title="Clouds" />--%>
                        <%--</li>--%>
                        <%--<li class="num1 img">--%>
                            <%--<img src="images/2.jpg" alt="Typewriter" title="Typewriter" />--%>
                        <%--</li>--%>
                        <%--<li class="num2 img">--%>
                            <%--<img src="images/3.jpg" alt="Bicycle" title="Bicycle" />--%>
                        <%--</li>--%>

                    <%--</ul>--%>
                    <%--<div class="cs_description">--%>
                        <%--<label class="num0">--%>
                            <%--<span class="cs_title"><span class="cs_wrapper">Clouds</span></span>--%>

                        <%--</label>--%>
                        <%--<label class="num1">--%>
                            <%--<span class="cs_title"><span class="cs_wrapper">Typewriter</span></span>--%>

                        <%--</label>--%>
                        <%--<label class="num2">--%>
                            <%--<span class="cs_title"><span class="cs_wrapper">Bicycle</span></span>--%>

                        <%--</label>--%>
                    <%--</div>--%>

                    <%--<div class="cs_arrowprev">--%>
                        <%--<label class="num0" for="cs_slide1_0"></label>--%>
                        <%--<label class="num1" for="cs_slide1_1"></label>--%>
                        <%--<label class="num2" for="cs_slide1_2"></label>--%>
                    <%--</div>--%>
                    <%--<div class="cs_arrownext">--%>
                        <%--<label class="num0" for="cs_slide1_0"></label>--%>
                        <%--<label class="num1" for="cs_slide1_1"></label>--%>
                        <%--<label class="num2" for="cs_slide1_2"></label>--%>
                    <%--</div>--%>

                    <%--<div class="cs_bullets">--%>
                        <%--<label class="num0" for="cs_slide1_0">--%>
                            <%--<span class="cs_point"></span>--%>
                            <%--<span class="cs_thumb"><img src="images/small/1.jpg" alt="Clouds" title="Clouds" /></span>--%>
                        <%--</label>--%>
                        <%--<label class="num1" for="cs_slide1_1">--%>
                            <%--<span class="cs_point"></span>--%>
                            <%--<span class="cs_thumb"><img src="images/small/2.jpg" alt="Typewriter" title="Typewriter" /></span>--%>
                        <%--</label>--%>
                        <%--<label class="num2" for="cs_slide1_2">--%>
                            <%--<span class="cs_point"></span>--%>
                            <%--<span class="cs_thumb"><img src="images/small/3.jpg" alt="Bicycle" title="Bicycle" /></span>--%>
                        <%--</label>--%>
                    <%--</div>--%>

                <%--</div>--%>

            <%--</div>--%>
            <%--<div class="clear"></div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</section>--%>
<%--<!-- E test -->--%>
<!-- S Login  -->
<div class="login_m" style="margin-right: 250px;margin-top: 160px;">
    <form action="" method="post" id="loginform">
        <div class="login_boder" >
            <div class="login_padding" style="margin-top: 10px;" >
                <div style="margin : 5px; font-weight:900;font-size: 13px;">登录名：</div>
                <label>
                    <input type="text" id="username" name="username" class="txt_input txt_input2" placeholder="手机号/用户名" value=""/>
                </label>
                <div style="margin : 5px;font-weight:900;font-size: 13px;">登录密码：</div>
                <label>
                    <input type="password" name="password" id="userpwd" class="txt_input"  value="" placeholder="***************"/>
                </label>
                <!-- S 滑动验证 -->
                <div id="drag"></div>
                <!-- E 滑动验证 -->
                <div class="rem_sub" style="">
                    <!-- s 记住密码 -->
                    <div class="rem_sub_l">
                        <input type="checkbox" name="checkbox" id="save_me"/>
                        <label for="checkbox">记住</label>
                    </div>
                    <!-- e 记住密码 -->
                    <input type="hidden" id="drags" value="" />
                    <label>
                        <input type="button" class="sub_button" name="button" id="button" value="登录" style="opacity: 0.7;" onclick="check();"/>
                    </label>
                </div>
            </div>
        </div><!--login_boder end-->
    </form>
</div><!--login_m end-->
<!-- E Login -->
<br />
<br />
<script type="text/javascript">
    $('#drag').drag();
    function check(){
        var username=$("#username").val();
        var password=$("#userpwd").val();
        if(username==""||password==""){
            alert("用户名或密码不能为空");
            return false;
        }
        else if($("#drags").val()==""){
            alert("请完成验证");
        }
        else{
            $.ajax({
                type:"post",
                url:"login.do",
                data:$("#loginform").serialize(),
                beforeSend:function(){
                    $("#button").val("正在登录....");
                },
                success:function(data){
                    if(data.href!=""){
                        window.location.href=data.href;
                    }
                    else{
                        alert(data.tip);
                        $("#button").val("登录");
                        //$('#drag').drag.drag_bg.css({'width': 0});
                        //$('#drag')
                    }
                }
            });
        }

    }


</script>
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"16"},"slide":{"type":"slide","bdImg":"1","bdPos":"right","bdTop":"100"},"image":{"viewList":["qzone","tsina","tqq","renren","weixin"],"viewText":"分享到：","viewSize":"16"},"selectShare":{"bdContainerClass":null,"bdSelectMiniList":["qzone","tsina","tqq","renren","weixin"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
<div style="text-align: center;color:rgb(202,202,202);font-size: 13px;margin-top: 30px;" align="center">© 2017 wddgsh.com 版权所有 ICP证：苏B2-20080101</div>
</body>
</html>
