<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="http://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">	
	<link rel="stylesheet" href="${ctx }/assets/baguetteBox/css/baguetteBox.min.css">
	<link rel="stylesheet" href="${ctx }/assets/baguetteBox/css/fluid-gallery.css">
	<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css" media="all" />
</head>
<body>
<form class="layui-form">
</form>
	<div class="htmleaf-container">
		<div class="container gallery-container">
		    <div class="tz-gallery" >
			     <div class="row">
				    <c:forEach  items="${picturelist}" var="pic">
			    		<div class="col-sm-12 col-md-4" >
				    	  	<a class="lightbox" href="${ctx}/${pic}"> 
				    			<img src="${ctx}/${pic}"> 
				    		</a> 
			    		</div>
					</c:forEach>
				</div>
		    </div>
		</div>
	</div>
	
	<script type="text/javascript" src="${ctx }/assets/baguetteBox/js/baguetteBox.min.js"></script>
	<script>
	baguetteBox.run('.tz-gallery',{
		 animation: 'fadeIn',
		 async: true
	   });
	</script>
</body>
</html>