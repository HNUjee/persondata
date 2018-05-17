<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html class="loginHtml">
<head>
	<meta charset="utf-8">
	<title>登录</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="icon" href="assets/faico.ico">
	<link rel="stylesheet" href="${ctx}/assets/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="${ctx}/assets/css/public.css" media="all" />
</head>
<body class="loginBody">
	<form class="layui-form" action="login" method="post">
		<div class="" style="height:60px">
		</div>
		<div class="layui-form-item input-item">
			<label for="userName">用户名</label>
			<input type="text" name="name" placeholder="请输入用户名" autocomplete="off" id="userName" class="layui-input" lay-verify="required">
		</div>
		<div class="layui-form-item input-item">
			<label for="password">密码</label>
			<input type="password" name="password" placeholder="请输入密码" autocomplete="off" id="password" class="layui-input" lay-verify="required">
		</div>
		<div class="layui-form-item input-item" id="imgCode">
			<label for="code">验证码</label>
			<input type="text" placeholder="请输入验证码" name="vcode" autocomplete="off"  class="layui-input" lay-verify="required" style="width:120px"> 
			<img src="${ctx }/assets/images/getGifCode.gif" id="vcode" />
		</div>
		<div class="layui-form-item">
			<button class="layui-btn layui-block" lay-filter="login" lay-submit>登录</button>
		</div>
		<div class="layui-form-item tip">
			
		</div>
	</form>
	<script type="text/javascript" src="${ctx}/assets/layui/layui.js"></script>
	<script>
	layui.config({
		base : "assets/js/"
	}).use(['form','layer','jquery'],function(){
		var form = layui.form(),
		    layer = layui.layer,
			//layer = parent.layer === undefined ? layui.layer : parent.layer,
			$ = layui.jquery;
			var g_rootPath="${ctx }";
			 // 刷新验证码
			$("#vcode").on("click",function(){
				 $(this).attr("src", "${ctx}/getGifCode?temp=" + Math.random());
			}) 
			$("#vcode").attr("src", "${ctx}/getGifCode?temp=" + Math.random());
	
		
	   /*  //登录按钮
	    form.on("submit(login)",function(data){
	        $(this).text("登录中...").attr("rdisabled","disabled").addClass("layui-disabled");
	        setTimeout(function(){
	        	 $.ajax({
	        	url : g_rootPath+"/loginIn",
	 			data : 1,
	 			type:'POST',
	 			contentType:'application/json;charset=utf-8',
	 			dataType : 'json',
	 			success : function(obj) {
	 				
	 			}
	        }) 
	        },1000);
	        return false;
	    })
 */
	    //表单输入效果
	    $(".loginBody .input-item").click(function(e){
	        e.stopPropagation();
	        $(this).addClass("layui-input-focus").find(".layui-input").focus();
	    })
	    $(".loginBody .layui-form-item .layui-input").focus(function(){
	        $(this).parent().addClass("layui-input-focus");
	    })
	    $(".loginBody .layui-form-item .layui-input").blur(function(){
	        $(this).parent().removeClass("layui-input-focus");
	        if($(this).val() != ''){
	            $(this).parent().addClass("layui-input-active");
	        }else{
	            $(this).parent().removeClass("layui-input-active");
	        }
	    })
	    	//layer.msg('${msg}',{icon:5});
	  	 	
	})
	</script>
</body>
</html>