<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href='${pageContext.request.contextPath}/resources/calendar/core/main.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/calendar/daygrid/main.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath}/resources/calendar/core/main.js'></script>
<script src='${pageContext.request.contextPath}/resources/calendar/interaction/main.js'></script>
<script src='${pageContext.request.contextPath}/resources/calendar/daygrid/main.js'></script>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      plugins: [ 'interaction', 'dayGrid' ],
      header: {
        left: 'prevYear,prev,next,nextYear today',
        center: 'title',
        right: 'dayGridMonth,dayGridWeek,dayGridDay'
      },
	  navLinks: true, // can click day/week names to navigate views
      editable: false,
      eventLimit: true, // allow "more" link when too many events
      events: [
        {
        	 id: '신메뉴 발표회',
          title: '신메뉴 발표회',
          start: '2020-11-16'
        },
        {
        	id : '신입사원 부서배치',
          title: '신입사원 부서배치',
          start: '2020-11-16'
        },
        {
        	id : '신입사원 환영회',
          title: '신입사원 환영회',
          start: '2020-11-16'
        },
        {
        	id : '우수사원 발표',
          title: '우수사원 발표',
          start: '2020-11-16'
        },
        {
        	id : '10월 결산보고',
          title: '10월 결산보고',
          start: '2020-11-16'
        },
        {
        	id : '신메뉴개발 기간',
          title: '신메뉴개발 기간',
          start: '2020-11-09',
          end : '2020-11-14'
        },
        {
        	id : '창업설명회',
          title: '창업설명회',
          start: '2020-11-26'
        },       
      ]
    });
    calendar.render();
  });

</script>
<style>

  body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 900px;
    margin: 0 auto;
  }

</style>
</head>
<body>
	<header id = "header" class="header">
		<%@ include file=".././header.jsp"%>
	</header>
<%  %>
  <div id='calendar'></div>

	<footer class="footer">
		<%@ include file=".././footer.jsp"%>
	</footer>

</body>
</html>
