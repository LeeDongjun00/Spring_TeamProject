<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta charset="UTF-8">

<h2>신고</h2>

<div id="reportApp">
  <table>
    <tr>
      <th>신고 번호</th>  
      <th>신고 유형</th>
      <th>세부 유형</th>
      <th>신고된 회원 ID</th>
      <th>신고된 회원 닉네임</th>
      <th>신고 내용</th>
      <th>신고자</th>
    </tr>
    <tr v-for="item in list" :key="item.REPORTNUM">
        <td>{{ item.REPORTNUM }}</td>
        <td>
            <span v-if="item.BOARDNO != null">게시글 신고</span>
            <span v-else>댓글 신고</span>
        </td>
        <td>
            <span v-if="item.REPORT_TYPE === 'E'">오류 제보</span>
            <span v-else-if="item.REPORT_TYPE === 'I'">불편 사항</span>
            <span v-else-if="item.REPORT_TYPE === 'S'">사기 신고</span>
            <span v-else>기타 신고</span>
        </td>
        <td>{{item.REPORTED_USER_ID}}</td>
        <td>
          <span v-if="item.REPORTED_NICKNAME != null">{{item.REPORTED_NICKNAME}}</span>
          <span v-else>탈퇴한 사용자</span>
        </td>
        <td>{{item.CONTENT}}</td>
        <td>{{item.REPORT_USER_ID}}</td>
    </tr>
  </table>
</div>

<script>
  
(function() {
  const app = Vue.createApp({
    data() {
      return {
        list:[],
      };
    },
    methods: {
      async loadReport() {
          let self = this;

        try {
          const response = await fetch('/admin/report.dox');

          if (!response.ok) {
            throw new Error('서버 응답 오류');
          }

          const data = await response.json();

          console.log(data.reportList);
          
          self.list = data.reportList;

          console.log(self.list);

        } catch (error) {
          console.error('대시보드 데이터 조회 실패', error);
        }
      }
    },
    mounted() {
      let self = this;
      self.loadReport();
    }
  });

  window.currentVueApp = app;
  app.mount('#reportApp');
})();
// window.reportApp = reportApp;

// app.mount('#reportApp');
</script>
