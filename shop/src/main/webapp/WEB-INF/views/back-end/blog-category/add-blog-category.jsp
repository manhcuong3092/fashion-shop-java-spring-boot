<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:include page="/WEB-INF/views/back-end/common/header.jsp"></jsp:include>
    <div id="layoutSidenav_content">
      <main>
        <div style="height: 50px;"></div>
        <div class="container-fluid">
          <h2 class="mb-4">Add Category</h2>
          <form method="post">
            <div class="form-group">
              <label>Name *</label>
              <input type="text" class="form-control" id="title" />
              <small id="emailHelp" class="form-text text-muted"> </small>
            <div class="form-group">
              <label>Description *</label>
              <input type="text" class="form-control" id="description" />
              <small id="emailHelp" class="form-text text-muted"> Show in product </small>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="checkbox" checked="true" id="flexCheckDefault">
              <label class="form-check-label" for="flexCheckDefault">
                Available
              </label>
            </div>
            <button type="submit" class="btn btn-primary mt-3">Add Category</button>
          </form>
        </div>
      </main>
      <jsp:include page="/WEB-INF/views/back-end/common/footer.jsp"></jsp:include>
</body>

</html>

</html>