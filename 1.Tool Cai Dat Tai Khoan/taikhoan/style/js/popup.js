$().ready(function() {
	$("#payCardNL").validate({
		rules: {
			card_serial  : "required",
			pin_card : "required",
		},
		messages: {
			card_serial: "Bạn phải nhập số serial",
			pin_card: "Bạn phải nhập mã thẻ"
		}
	});
	
	
	
}); 
function check(){
	if($("#price").val()==''){alert("Số tiền nạp không được để trống");return false;}	
	if(isNaN($("#price").val())){alert("Số tiền nạp phải là số");return false;}
	else {if($("#price").val() < 2000){alert("Số tiền nạp phải lớn hơn 2000 VNĐ");return false;}	}
}

   	
           