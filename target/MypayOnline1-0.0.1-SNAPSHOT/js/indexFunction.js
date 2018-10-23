		$(function() {
			$('.submitForm').bind('click', subminForm);
			$("input:enabled").bind('change', sign);
			$('table select').bind('change', sign);
			$('.reset').bind('click', resetData);
			$('#home').bind('click', home);
			$('#functionDiv input').bind('click', changeDiv);
			$('#merchantList input').bind('click', showMerchList);
		});

		var sign = function() {

			var form = $(this).closest('form');

			var signStr = '';
			if ($(this).closest('form').attr('id') == 'sendOrderForm') {
				signStr = 'amount=' + form.find('input[name=amount]').val()
						+ '&clientIp='
						+ form.find('input[name=clientIp]').val() + '&merId='
						+ form.find('input[name=merId]').val() + '&merchantNo='
						+ form.find('input[name=merchantNo]').val()
						+ '&notifyUrl='
						+ form.find('input[name=notifyUrl]').val()
						+ '&payType=' + form.find('input[name=payType]').val()
						+ '&terminalClient='
						+ form.find('input[name=terminalClient]').val()
						+ '&tradeDate='
						+ form.find('input[name=tradeDate]').val()
						+ '&key=094B4D71F54F9D1FC29B0AB441723716';
			} else {
				console.log('here');
				signStr = 'merId=' + form.find('input[name=merId]').val()
						+ '&merchantNo='
						+ form.find('input[name=merchantNo]').val() + '&orgId='
						+ form.find('input[name=orgId]').val()
						+ '&key=094B4D71F54F9D1FC29B0AB441723716';
			}

			var sign = md5(signStr).toUpperCase();

			$('.sign').val(sign);
			$('.signTd').html(sign);
			$('.signStr').text('签名排序：' + signStr);
		};

		var subminForm = function() {

			var form = $(this).closest('form');

			if ($('.sign').val() == 0) {
				alert('请先 生成验签 再送单');
				return;
			}
			if (form.attr('id') == 'sendOrderForm') {
				var amount = form.find('input[name=amount]').val();
				var regex = /[\d]+.[\d]{2}$/
				if (!regex.test(amount)) {
					alert('金额错误! 请参阅文檔.');
					return;
				}
			}
			$(this).closest('form').submit();
		}

		var removeSign = function() {
			$('.signTd').text('');
			$('.signStr').text('签名排序：');
			$('.sign').val('');
		}

		var resetData = function() {
			$('table input[type=text]').each(function() {
				$(this).val('');
			});
		}
		
	

		var changeDiv = function() {
				
				console.log("aaaa");
				$('div').hide();
				var view2 = $(this).attr('view');
				$('#' + view2).show();
				$('#functionDiv').show();
				view2 = view2.replace('Div','');
				$('#'+view2+'Order').show();
		}
		
		var home = function(){
			window.location.href='/MypayOnline1/index.jsp';
		}
		
		var insertMypay = function(obj){
			var name = $(obj).attr('dataName');
			var id = $(obj).attr('dataId');
		
			console.log('name=='+ name);
			console.log('id=='+ id);
			
			$('#insertMypayFormId').val(id);
			$('#insertMypayFormName').val(name);
			document.forms['insertMypayForm'].submit();
		}
		
		//商戶列表
		var showMerchList = function(obj){
			var id = $(obj).attr('dataId');
			$('#merchantListId').val(id);
			document.forms['merchantListForm'].submit();
		}
		
		
		//商戶列表詳情
		var merchantDetal = function(obj){
			
			$('#merchantDetalDiv').toggle();
			
		}


		window.onload = function() {
			
				
			
			var tfrow = document.getElementById('tfhover').rows.length;
			var tbRow = [];
			for (var i = 1; i < tfrow; i++) {
				tbRow[i] = document.getElementById('tfhover').rows[i];
				tbRow[i].onmouseover = function() {
					this.style.backgroundColor = '#BBFFEE';
				};
				tbRow[i].onmouseout = function() {
					this.style.backgroundColor = '#77FFEE';
				};
			}
		};
