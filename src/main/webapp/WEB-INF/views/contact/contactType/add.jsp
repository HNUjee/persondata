<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css" media="all" />
<title>添加</title>
</head>
<body class="childrenBody">
		<form class="layui-form layui-form-pane" action="${ctx }/contactType/save" method="post" enctype="multipart/form-data" style="margin-top:100px">
				<input type="hidden" class="layui-input id" name="id"  value=${category.id }>
				<label class="layui-form-label">分类</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input name" name="name" placeholder="请输入分类" value=${category.name }>
				</div>
		</form>
		<div class="layui-form-item">
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn addNews" lay-submit="" lay-filter="addNews">立即提交</button>
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
				},
				success : function() {
					$("form").find(".addNews").attr("disabled",true); 
					 layer.alert('添加成功',{icon: 1}); 
					 setTimeout(function(){
						parent.location.reload();
					 },2000);
				}
			});
		});
	// 保存用户
	 $(".childrenBody").find(".addNews").on("click", function() {
		$(".childrenBody").find("form").trigger("submit");
	});
});   
</script>		
</body>
</html>