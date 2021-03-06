<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
    <title>Document</title>
</head>
<style>
    table {border-collapse: collapse;}
    td {border:1px solid black; }
</style>
<body>
    <table style="width:1200px; height:700px; text-align: center; background-color: bisque;">
        <tr>
            <td>
                <table style="width:1200px; height:650px; margin:20px; background-color: burlywood;">
                    <tr style="text-align: center; background-color:chocolate">
                        <td><label>메뉴목록</label></td>
                        <td><label>주문목록</label></td>
                        <td><label>매출</label></td>
                    </tr>
                    <tr style="height:400px; background-color: burlywood">
                        <td rowspan="10">
                            <table style="width:390px; height:390px; margin:5px; background-color: bisque;">
                                <tr>
                                    <td>
                                        <select size="6" id="menulist" style="width:350px; height:350px; font-size:14pt;">
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td rowspan="10">
                            <table style="width:390px; height:390px; margin:5px; background-color: bisque;">
                                <tr>
                                    <td>
                                        <select id="orderlist" size="6" style="width:350px; height:350px; font-size:14pt;">
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td rowspan="10">
                            <table style="width:390px; height:390px; margin:5px; background-color: bisque;">
                                <tr>
                                    <td>
                                        <select id="receipt" size="6" style="width:350px; height:350px; font-size:11pt;">
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </td></tr>
                    <tr></tr>
                    <tr></tr>
                    <tr></tr>
                    <tr></tr>
                    <tr></tr>
                    <tr></tr>
                    <tr></tr>
                    <tr></tr>
                    <tr></tr>
                    <tr>
                        <td>  &nbsp;메뉴  <input type="text" id="menu" readonly></td>
                        <td>  &nbsp;모바일번호 <input type="text" id="mobile"></td>
                        <td rowspan="4">  &nbsp;매출합계 <input type=label id="totalNum"> 원</td>
                    </tr>
                    <tr>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;수량  <input type="number" id="qty"> 잔</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        총액  <input type="number" id="total" readonly> 원</td>
                    </tr>
                    <tr>
                        <td>  &nbsp;가격  <input type="number" id="price" readonly></td>
                        <td rowspan="2">
                            <input type="button" value="주문완료" id="complete">
                            <input type="button" value="취소" id="clorder">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="button" value="추가" id="addmenu">
                            <input type="button" value="취소" id="clmenu">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table><br>
    <a href='#' id="btnMenu">메뉴관리</a>
    <div id="dvMenu" style="display:none">
    <table>
    <tr>
        <td>
            <select id="selMenu1" size="12" style="width:180px">
            </select>
        </td>
        <td style="vertical-align:top">
            <input type="hidden" id="optype" value="add">
            <table style="width:100%">
            <tr><td>메뉴명&nbsp;<input type=text id="_name" size="12"></td></tr>
            <tr><td>가격&nbsp;<input type=number id=_price min="1" max="99999">원</td></tr>
            <tr><td>&nbsp;</td></tr>
            <tr><td><button id="btnAdd">등록</button><button id="btnDelete">삭제</button></td></tr>
            <tr><td><button id="btnRemove">지우기</button><button id=btnCancel>종료</button></td></tr>
            </table>
        </td>
    </tr>
    </table>
    </div>

</body>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
<script>
$(document)
.ready(function(){
	loadData()
    loadTotalData()
    $('#dvMenu').dialog({
        width:420,
        height:320,
        autoOpen:false, 1	
        open: function(){
        	loadData();
        },
        close:function(){
        	loadData();
        }
    })
})
.on('click','#btnAdd',function(){
	if($('#_name').val()=='') return false
    if($('#optype').val()=='update'){
    	$.ajax({
    		type:'get',
    		url:'update',
    		dataType:'text',
    		data:{seqNo:$('#selMenu1 option:selected').val(),
    			name:$('#_name').val(),price:$('#_price').val()},
    		success:function(data){
    			loadData()
    			$('#_name,#_price').val('')
    		}
    	})
    } else if($('#optype').val()=='add'){
    	$.ajax({
    		type:'get',
    		url:'addnewMenu',
    		data:{name:$('#_name').val(),price:$('#_price').val()},
    		dataType:'text',
    		success:function(data){
    			loadData()
    			$('#_name,#_price').val('')
    		}
    	})
    }
    $('#optype').val('add')
	$('#_name,#_price').val('')
})

.on('click','#btnDelete',function(){
	let seqNo = $('#selMenu1 option:selected').val();
	$.ajax({
		type:'get',url:'delete',data:'seqNo='+seqNo,dataType:'text',
		success:function(){
			$('#selMenu1 option:selected').remove();
		    $('#_name,#_price').val('')
		    $('#optype').val('add')
		}
	})
})
.on('click','#btnRemove',function(){
    $('#_name,#_price').val('')
    $('#optype').val('add')
})
.on('click','#btnMenu',function(){
    $('#dvMenu').dialog('open')
})
.on('click','#btnCancel',function(){
    $('#dvMenu').dialog('close')
})
.on('click','#selMenu1 option',function(){
    str=$(this).text()
    ar=str.split(',')
    $('#_name').val(ar[0])
    $('#_price').val(parseInt(ar[1]))
    $('#optype').val('update')
})

.on('click','#menulist option',function(){
    str=$('#menulist option:selected').text()
    ar=str.split(',')
    $('#menu').val(ar[0])
    $('#price').val(parseInt(ar[1]))
    $('#qty').val(1)
})

.on('click','#addmenu',function(){
    if($('#name').val()==''||$('#qty').val()==''||$('#price').val==''){
        alert('값이 주어지지 않았습니다')
        return false;
    }
    str='<option value='+$('#menulist option:selected').val()+'>'+$('#menu').val()
    	+', '+$('#qty').val()+', '+($('#price').val()*$('#qty').val())+'</option>'
    $('#orderlist').append(str)
    $('#total').val(0)
    let a=0;
    a+=parseInt($('#price').val())
    $('#total').val(a)
    console.log($('#total').val())
    $('#name,#qty,#price').val()
})

.on('click','#clmenu',function(){
    $('#menu,#qty,#price').val('')
})

.on('click','#complete',function(){
    if($('#mobile').val()==''){
        alert('값이 주어지지 않았습니다')
        return false
    } else {
		for(i=0; i<$('#orderlist option').length; i++){
			str=$('#orderlist option:eq('+i+')').text()
			arr=str.split(',')
	    	$.ajax({
		    	type:'get',url:'addtotal',
		    	data:{mobile:$('#mobile').val(),
		    		seqno:$('#orderlist option:eq('+i+')').val(),
		    		qty:arr[1], 
		    		price:arr[2]},
		    	dataType:'text',
		    	success:function(data){
		    		loadTotalData()
	    		}
		 	})
		}
    	/*
    	$.ajax({
    		type:'get', url:'getsum', dataType:'text',
    		success: function(data){
    			$('#lblSum').text(data);
    		}
    	})
    	*/
	    $('#orderlist option').remove()
	    $('#mobile,#total').val('')
    }
})

.on('click','#clorder',function(){
    $('#orderlist option').remove()
    $('#mobile,#total').val('')
})

function getToday(){
	dt=new Date()
	str=dt.getFullYear()+'-'+(dt.getMonth()+1)+'-'+dt.getDate()+' '+dt.getHours()+':'
		+dt.getMinutes()+':'+dt.getSeconds()
	return str
}

function loadData(){
	$.ajax({
       	type:'get',url:'menulist',dataType:'json',
       	success:function(data){
           	$('#menulist,#selMenu1').empty();
           	for(let i=0; i<data.length; i++){
           		let jo = data[i];
           		let str = '<option value='+jo['seqno']+'>'+jo['name']+", "+jo['price']+'</option>'
               	$('#menulist,#selMenu1').append(str);
           	}
        }
    })
}

function loadTotalData(){
	$.ajax({
    	type:'get',url:'totallist',dataType:'json',
    	success:function(data){
   			$('#receipt').empty();
   			let total = 0;
   			for(i=0; i<data.length; i++){
   				let jo = data[i];
   				let _str = '<option>'+jo['mobile']+", "+jo['name']+", "+jo['qty']+", "
   					+jo['price']+", "+jo['income_date']+'</option>'
   	   			total += parseInt(jo['price']);
   				$('#receipt').append(_str);
    	    	$('#totalNum').val(total);
    		}
    	}
 	})
}
</script>
</html>