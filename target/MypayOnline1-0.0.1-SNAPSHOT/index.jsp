<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML>
<!--
/*
 * MyPay 在线支付 demo
 *
 * Copyright 2018, Sebastian Tschan
 *
 * auth：Caster Hsu
 * Date：2018/08/01
 */
-->
<html>

<head>
<title>MyPay 支付 Demo</title>
<meta charset="utf-8">
<link href="https://fonts.googleapis.com/css?family=Roboto+Mono"
	rel="stylesheet">
<style type="text/css">
body {
	font-family: 'Roboto Mono', monospace;
}

h5 {
	margin: 20px;
	font-size: 20px;
}

.formDiv {
	margin-left: 20px;
}

table.tftable {
	font-size: 12px;
	color: #333333;
	width: 700px;
	border-width: 1px;
	border-color: #444444;
	border-collapse: collapse;
	margin-bottom: 20px;
}

table.tftable th {
	font-size: 12px;
	background-color: #00DDDD;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #729ea5;
	text-align: left;
}

table.tftable tr {
	background-color: #77FFEE;
}

table.tftable td {
	font-size: 12px;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #444444;
}

.mask {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: #000;
	opacity: 0.5;
	filter: alpha(opacity = 50);
	display: none;
	z-index: 99;
}

.mess {
	position: absolute;
	display: none;
	width: 250px;
	height: 140px;
	border: 1px solid #ccc;
	background: #ececec;
	text-align: center;
	z-index: 101;
}

#functionDiv {
	position: fixed;
	left: 32px;
}
</style>
</head>

<body>
	<div id='functionDiv'>
		<input type="button" id='changeSendOrder' view='sendDiv' value='下单范例'
			style='display: none'> <input type="button"
			id='changeQueryOrder' view='queryDiv' value='查单范例'> <input
			type="button" id='changeSearchOrder' view='searchDiv' value='查詢接口'>
		<input type="button" id='changeAuthOrder' view='authDiv' value='獲取授權'>
	</div>

	<div id='authDiv' class='formDiv'
		style='display: none; position: fixed; top: 38px'>
		<h5>MyPay Auth Order 查詢是哪個授權</h5>
		<form id='SeaechAuthForm'
			action='<c:url value ="${request.contextPath}/serverlet/OAuth2" />'
			method='post' name='SeaechAuthForm'>

			<table id="tfhover" class="tftable" border="1">
				<tr>
					<th style="width: 150px;">参数名称</th>
					<th>参数值</th>
				</tr>
				<tr>
					<td>接口編號：</td>
					<td><input type='text' name='id' value='${param.id}' id="id" /></td>
				</tr>
				<tr>
					<td>支付網址：</td>
					<td><input type='text' name='url' value='${param.url}'
						id="url" /></td>
				</tr>
				<tr>
					<td>接口名稱：</td>
					<td><input type='text' name='name' value='${param.name}'
						id="name" /></td>
				</tr>

			</table>

			<input type="submit" value='送出' id="authSub" /> <input type="button"
				class="reset" value='清空' /> <input type="hidden" name="method"
				value="auth" />
		</form>

	</div>



	<div id='searchDiv' class='formDiv'
		style='display: none; position: fixed; top: 38px'>
		<h5>MyPay Query Order 查詢是哪個接口</h5>
		<form id='SeaechOrderForm'
			action='<c:url value ="${request.contextPath}/serverlet/ListServerlet" />'
			method='post' name='SeaechOrderForm'>

			<table id="tfhover" class="tftable" border="1">
				<tr>
					<th style="width: 150px;">参数名称</th>
					<th>参数值</th>
				</tr>
				<tr>
					<td>接口編號：</td>
					<td><input type='text' name='id' value='${param.id}' id="id" /></td>
				</tr>
				<tr>
					<td>支付網址：</td>
					<td><input type='text' name='url' value='${param.url}'
						id="url" /></td>
				</tr>
				<tr>
					<td>接口名稱：</td>
					<td><input type='text' name='name' value='${name}' id="name" /></td>
				</tr>

			</table>

			<input type="submit" value='送出' id="searchSub" /> <input
				type="button" class="reset" value='清空' /> <input type="hidden"
				name="method" value="query" />
		</form>

	</div>



	<div id='resultDiv' class='formDiv'
		style='display: none; position: relative; left: 800px'>
		<h5>查詢接口:${param.url}${name}</h5>


		<table id="tfhover" class="tftable" border="1">
			<tr>

				<th>接口ID</th>
				<th>接口</th>
				<th>支付网关</th>
				<th>操作</th>
				<th>商戶部分</th>
			</tr>
			<c:if test="${fn:length(list) eq 0 }">
				<tr>
					<td colspan="4">查無此資料</td>
				</tr>
			</c:if>
			<c:forEach items="${list }" var="data">
				<tr>
					<td>${data.id}</td>
					<td>${data.name}</td>
					<td>${data.url}</td>
					<td><input type="button" class="btn" value="修改"
						id="modifyPop${data.id}" dataId="${data.id}"
						dataName="${data.name}" dataUrl="${data.url}" /></td>
					<td><input type="button" value="新增mypay平台" id="insertMypay" dataId="${data.id}" dataName="${data.name}"
						onclick='insertMypay(this);' /> 
						<input type="button" id="merchantList" value="mypay商戶列表" dataId="${data.id}" dataName="${data.name}" onclick='showMerchList(this);'/></td>


				</tr>
			</c:forEach>
		</table>
		<input type="button" name="back" value="上一頁"
			onclick="javascript:history.back(-1);" /> <input type="button"
			id="home" value="回首頁" />
	</div>
	
	<!--  -->
	<form name='merchantListForm'
		action='<c:url value ="${request.contextPath}/serverlet/ListServerlet" />'
		method='post'>
		<input type='hidden' id='merchantListId' name='id' value=''>
	
		<input type="hidden" id='insertMypayForm' name="method"
			value="merchantList" />

	</form>
	
	


		<div id='merchantReDiv' class='formDiv'
		style='display: none; position: relative; left: 800px'>
		<h5>查詢商戶:</h5>


		<table id="tfhover" class="tftable" border="1">
			<tr>

				<th>接口</th>
				<th>商戶ID</th>
				<th>商戶名稱</th>
				<th>商戶號</th>
				<th>操作</th>
			</tr>
			<c:if test="${fn:length(merList) eq 0 }">
				<tr>
					<td colspan="5">查無此資料  新增一筆吧?</td>
					<td><input type="button" value="新增mypay商戶" id="insertMerchantMypay" dataId="${data.id}" dataName="${data.name}"
						onclick='insertMypay(this);' /> </td>
				</tr>
			</c:if>
			<c:forEach items="${merList }" var="data">
				<tr>
					<td>${data.PAYMENT_PLATFORM_ID}</td>
					<td>${data.ID}</td>
					<td>${data.NAME}</td>
					<td>${data.MERCHANT_NO}</td>
					<td>
					<input type="button"  value="詳情"  id="merListPop${data.id}" onclick='merchantDetal()' />
						<div	id='merchantDetalDiv' class='formDiv'
		style='display: none; position: relative; left: 800px'>
		<h5>商戶詳情:</h5>
					<table	id="tfhover" class="tftable" border="1">
			<tr>
			
				<th>詳情</th>
			</tr>
			<tr>
				<th>平台號 :</th>
				<th>${data.PLATFORM_NO}</th>
				<th>商戶密碼 :</th>
				<th>${data.MERCHANT_PWD}</th>
				<th>簽章種類 :</th>
				<th>${data.SIGNATURE_TYPE}</th>
				<th>MD5密鑰 :</th>
				<td>${data.PLATFORM_NO}</td>
				<th>RSA商戶私鑰 :</th>
				<td>${data.RSA_MERCHANT_PRIVATE_KEY}</td>
				<th>RSA商戶公鑰 :</th>
				<td>${data.RSA_MERCHANT_PUBLIC_KEY}</td>
				<th>RSA服務器公鑰 :</th>
				<td>${data.RSA_SERVER_PUBLIC_KEY}</td>
			</tr>
						</table>
					</div>
					
					</td>
					

				</tr>
			</c:forEach>
		</table>
		<input type="button" name="back" value="上一頁"
			onclick="javascript:history.back(-1);" /> <input type="button"
			id="home" value="回首頁" />
	</div>

	

	<form name='insertMypayForm'
		action='<c:url value ="${request.contextPath}/serverlet/ListServerlet" />'
		method='post'>
		<input type='hidden' id='insertMypayFormId' name='id' value=''>
		<input type='hidden' id='insertMypayFormName' name='name' value=''>
		<input type="hidden" id='insertMypayForm' name="method"
			value="insertMypay" />

	</form>


	<div id='modifyPop'>
		<div class="mask"></div>
		<div class="mess">
			原網址:
			<p id="showUrl"></p>
			<p>
				欲修改網址:<input type="text" id="toModifyUrl">
			</p>
			<p>
				<input type="button" value="确定" class="btn1" id="modifyUrl" /> <input
					type="button" value="取消" class="btn2" />
			</p>
		</div>
	</div>

	<div id='insertReDiv' class='formDiv'
		style='display: none; position: relative; left: 800px'>
		<table id="tfhover" class="tftable" border="1">
			<tr>
				<th>回傳信息</th>
				<td>${meString}</td>
			</tr>
		</table>
	</div>




	<script type="text/javascript" src="<c:url value ="/js/md5.js" />"></script>
	<script type="text/javascript"
		src="<c:url value ="/js/jquery-2.1.1.min.js" />"></script>
	<script type="text/javascript"
		src="<c:url value ="/js/jquery.validate.min.js" />"></script>
	<script type="text/javascript" src="<c:url value ="/js/pop.js" />"></script>
	<script type="text/javascript"
		src="<c:url value ="/js/indexFunction.js" />"></script>
	<c:if test="${method == 'query' }">
		<script>
			$('#searchDiv').show();
			$('#resultDiv').show();
			$('#sendDiv').hide();
		</script>
	</c:if>
	<c:if test="${method == 'insertMypay' }">
		<script>
			$('#searchDiv').show();
			$('#insertReDiv').show();
		</script>
	</c:if>
	<c:if test="${method == 'merchantList' }">
		<script>
			$('#merchantReDiv').toggle();
			$('#searchDiv').show();
			$('#merchantList').val('隱藏列表');
			$('#resultDiv').show();
		</script>
	</c:if>
</body>

</html>