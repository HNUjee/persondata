<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>文章类型</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8" />
	<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css" media="all" />
</head>
<body class="childrenBody">
	<form class="layui-form" action="" method="post" enctype="multipart/form-data">
		<input type="hidden" class="layui-input id" name="id"  value=${type.id }>
		<div class="layui-form-item">
			<label class="layui-form-label">文章类型</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input type" name="typeName" lay-verify="required|typeName" placeholder="请输入文章类型" value=${type.typeName }>
			</div>
		</div>                                                               
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit="" lay-filter="addNews">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
		</div>
	</form>
	<script type="text/javascript" src="${ctx }/assets/layui/layui.js"></script>
	<script type="text/javascript">
	layui.config({
		base : "assets/js/"
	}).use(['form','layer','jquery'],function(){
		var form = layui.form(),
			layer = parent.layer === undefined ? layui.layer : parent.layer,
			$ = layui.jquery;
		var g_rootPath = "${ctx}";
		//自定义验证
	 	form.verify({
	 		typeName: function(value){ //value：表单的值、
	 		    if(value.length > 15){
	 		      return '不能超过15字符';
	 		    }
	 		  }
	 		});      
	 	form.on("submit(addNews)",function(data){
	 		var str={"id":$(".id").val(),
	 				"typeName":$(".type").val(),
				}
	 		 $.ajax({
	 			url : g_rootPath+'/articletype/save',
	 			data : JSON.stringify(str),
	 			type:'POST',//默认以get提交，以get提交如果是中文后台会出现乱码
	 			contentType:'application/json;charset=utf-8',
	 			dataType : 'json',
	 			success : function(obj) {
	 				
	 			}
	 		});
	 		var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	        setTimeout(function(){
	            top.layer.close(index);
				top.layer.msg("添加成功！");
	 			layer.closeAll("iframe");
		 		//刷新当前页面
	 			parent.location.reload();
	        },2000);
	 		return false;
	 	})
		
	})
	</script>
</body>
</html>