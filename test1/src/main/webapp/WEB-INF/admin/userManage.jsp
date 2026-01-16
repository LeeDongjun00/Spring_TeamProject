<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta charset="UTF-8">

<h2>회원 관리</h2>

<div id="userManageApp">
  <table>
    <tr>
      <th>회원수</th>
      <th>문의</th>
    </tr>
    <!-- <tr>
      <td>{{ memberCnt }}</td>
      <td>{{ reportCnt }}</td>
    </tr> -->
  </table>
  <div>
    userManage
  </div>
</div>

<script>
(function() {
  const app = Vue.createApp({
    data() {
      return {
        
      };
    },
    methods: {
      
    },
    mounted() {
      
    }
  });
  window.currentVueApp = app;

  app.mount('#userManageApp');
})();
</script>
