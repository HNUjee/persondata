<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css" media="all" />
<title>创建相册</title>
</head>
<body class="childrenBody">
		<form class="layui-form layui-form-pane" action="${ctx }/pictureCategory/save" method="post" enctype="multipart/form-data" style="margin-top:100px">
		<input type="hidden" class="layui-input id" name="id"  value=${category.id }>
		<div class="layui-form-item">
			<label class="layui-form-label">创建相册</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input name" name="name" placeholder="请输入相册名称" value=${category.name }>
			</div>
		 </div>
		 <div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">描述</label>
		    <div class="layui-input-block">
		    	 <textarea placeholder="简介" name="description" class="layui-textarea"></textarea>
		    </div>
 		 </div>
		</form>
		<div class="layui-form-item">
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn addPic">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
		</div>
	<script type="text/javascript" src="${ctx }/assets/layui/layui.js"></script>
	<script type="text/javascript" src="${ctx }/assets/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="${ctx }/assets/jquery-form/jquery.form.min.js"></script>
	<script type="text/javascript">
	layui.use(['form', 'layer'], function(){
		  var layer = layui.layer,
		  	  form = layui.form();
		  		form.render();
		  
	 $("form").on("submit", function(e) {
		 // 阻止表单默认提交事件
			e.preventDefault();
			var $this = $(this);
			// jquery-form的异步提交方式
			$this.ajaxSubmit({
				beforeSubmit : function(data, $form) {
					var name = $form.find("input[name='name']");
					if ($.trim(name.val()) === "") {
						layer.msg("请输入分类",{icon: 6});
						return false; 
					}
					var name = $form.find("input[name='name']");
					if ($.trim(name.val()) === "") {
						layer.msg("请输入分类",{icon: 6});
						return false; 
					}
				},
				success : function() {
					 layer.alert('添加成功',{icon: 1}); 
					 setTimeout(function(){
						parent.location.reload();
					 },2000);
				}
			});
		});
	// 保存用户
	 $(".childrenBody").find(".addPic").on("click", function() {
		$(".childrenBody").find("form").trigger("submit");
	});
});   
</script>		
</body>
</html>