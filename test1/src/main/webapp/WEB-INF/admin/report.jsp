<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta charset="UTF-8">

<style>
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0,0,0,0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 9999;
}

.modal {
  background: #fff;
  padding: 20px 30px;
  border-radius: 8px;
  min-width: 300px;
}

.reportTip {
  font-size: 14px;
}
</style>

<h2>신고 관리</h2>

<div id="reportApp">
  <div class="reportTip">※신고글 번호를 클릭하여 내용 확인※</div>
  <!-- 신고 관리용 테이블 -->
  <table style="width: 98%;">
    <tr>
      <th>신고 번호</th>
      <th>신고 유형</th>
      <th>세부 유형</th>
      <th>신고글 번호</th>
      <!-- <th>신고된 회원 ID</th>
      <th>신고된 회원 닉네임</th> -->
      <th>신고 대상</th>
      <th>신고 내용</th>
      <th>신고자</th>
    </tr>
    <tr v-for="item in list" :key="item.REPORTNUM">
        <td>{{ item.REPORTNUM }}</td>
        <td>
            <span v-if="item.BOARDNO1 != null">게시글 신고</span>
            <span v-else>댓글 신고</span>
        </td>
        <td>
            <span v-if="item.REPORT_TYPE === 'E'">오류 제보</span>
            <span v-else-if="item.REPORT_TYPE === 'I'">불편 사항</span>
            <span v-else-if="item.REPORT_TYPE === 'S'">사기 신고</span>
            <span v-else>기타 신고</span>
        </td>
        <td>
          <a href="javascript:;" @click="fnGetInfo(item.REPORTED_USER_ID, item.BOARDNO2, item.COMMENTNO)"><span v-if="item.COMMENTNO != null">{{item.BOARDNO2}}</span></a>
          <a href="javascript:;" @click="fnGetInfo(item.REPORTED_USER_ID, item.BOARDNO1, null)"><span v-else>{{item.BOARDNO1}}</span></a>
        </td>
        <td>
          <span v-if="item.REPORTED_NICKNAME != null">{{item.REPORTED_USER_ID}} / {{item.REPORTED_NICKNAME}}</span>
          <span v-else>{{item.REPORTED_USER_ID}} / 탈퇴한 사용자</span>
        </td>
        <td>{{item.CONTENT}}</td>
        <td>{{item.REPORT_USER_ID}}</td>
    </tr>
  </table>

  <!-- 모달 -->
   <div v-if="showModal" class="modal-overlay" @click.self="closeModal">
    <div class="modal">
      <h3>신고 정보</h3>
      <p>BOARD NO : {{ selectedBoardNo }}</p>
      <p v-if="selectedCommentNo != null">COMMENT NO : {{ selectedCommentNo }}</p>
      <p>신고된 회원 ID : {{ reportedUserId }}</p>

      <button @click="closeModal">닫기</button>
    </div>
  </div>
</div>

<script>
  
(function() {
  const app = Vue.createApp({
    data() {
      return {
        list:[],
        showModal: false,
        selectedBoardNo: null,
        selectedCommentNo: null,
        reportedUserId: null
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

          // console.log(data.reportList);
          
          self.list = data.reportList;

          console.log(self.list);

        } catch (error) {
          console.error('대시보드 데이터 조회 실패', error);
        }
      },

      fnGetInfo(reportedUserId, boardNo, commentNo) {
        this.reportedUserId = reportedUserId;
        this.selectedBoardNo = boardNo;
        this.selectedCommentNo = commentNo;

        // this.fnGetBoardComment();

        this.showModal = true;
      },
      closeModal() {
        this.showModal = false;
        this.selectedBoardNo = null;
        this.selectedCommentNo = null;
        this.reportedUserId = null;
      },

      fnGetBoardComment() {
        let self = this;
        let param = {
          boardNo: self.selectedBoardNo,
          commentNo: self.selectedCommentNo
        };
        // if(self.selectedCommentNo){
        //   param.commentNo = self.selectedCommentNo;
        // }
        $.ajax({
            url: "/admin/getrbc.dox",
            dataType: "json",
            type: "POST",
            data: param,
            success: function (data) {
              console.log(data);
            }
        });
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
