
$(function(){ 
  $('.sp-sub-plus').click(function(){ 
    var n = $('.bt_up').index(this);
    var num = $(".num:eq("+n+")").val();
    num = $(".num:eq("+n+")").val(num*1+1); 
  });
  $('.sp-sub-minus').click(function(){ 
    var n = $('.bt_down').index(this);
    var num = $(".num:eq("+n+")").val();
    num = $(".num:eq("+n+")").val(num-1); 
   if($(".num:eq("+n+")").val() <= 0) {
          $(".num:eq("+n+")").val(0);
   }
  });
})


/*
function shoppingbag(gooscode, dpcode){
	var odrQty=1;

    if (gooscode !='') {

        var params = [];
        params.push({goosCode: gooscode, dpCode: dpcode,
                    odrQty: odrQty});
    	console.log(params);
        $.ajax({
            url: '/shoppingbag',
            method: 'POST',
            contentType: 'application/json',
            dataType: 'json',
            data: JSON.stringify(params)
        })
        .done(function(json, status, request) {
            if ('QTY_EXCE' === json.dpStat) {
                alert('쇼핑백 총 갯수를 초과하였습니다.');
            } else if ('ROST' === json.dpStat) {
                alert('품절 상품입니다.');
            } else if ('DD_PURC_LIMT_QTY' === json.dpStat) {
                alert('일일 구매 수량을 초과하였습니다.');
            } else if('SUCC' === json.dpStat) {
                commCounter(); // 쇼핑백카운트 증가
                alert('쇼핑백에 추가 하였습니다.')
            }
            shoppingbagGa();
            afRecordEvnt(gooscode,'s','');
        })
        .fail(function(xhr, status, errorThrown) {
            alert(xhr.responseText.errorMessage);
        });
    }
}

//바로구매 (위시리스트)
function purchase(guestYn, inflow,dpCode,goosCode){
	  var odrQty=1;

	  var params = [];


      params.push({goosCode: goosCode, dpCode: dpCode,
                  odrQty: Number(odrQty)});


      $.ajax({
          url: '/order/purchase',
          method: 'POST',
          contentType: 'application/json',
          dataType: 'json',
          data: JSON.stringify(params)
      })
      .done(function(json, status, request) {
          if (guestYn) {
              location.href = "/order/terms/guest?sbagNos=" + json.sbagNos[0];
          } else {
              location.href = "/order?sbagNos=" + json.sbagNos[0];
          }
      })
      .fail(function(xhr, status, errorThrown) {
          alert(xhr.responseText.errorMessage);
      });
}*/