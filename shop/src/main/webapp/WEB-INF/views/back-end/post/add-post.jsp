<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:include page="/WEB-INF/views/back-end/common/header.jsp"></jsp:include>
    <div id="layoutSidenav_content">
      <main>
        <div style="height: 50px;"></div>
        <div class="container-fluid">
          <h2 class="mb-4">Add Product</h2>
          <form method="post">
            <div class="form-group">
              <label>Category *</label>
              <select class="form-control form-control-line" path="categories.id" id="category">
                <options items="${categories}" itemValue="id" itemLabel="name" />
              </select>
            </div>
            <div class="form-group">
              <label>Title *</label>
              <input type="text" class="form-control" id="title" />
              <small id="emailHelp" class="form-text text-muted"></small>
            </div>
            <div class="form-group">
              <label>Content *</label>
              <textarea class="form-control summernote" name="editordata" id="content"></textarea>
            </div>
            <div class="form-group">
              <label>Slug</label>
              <input type="text" class="form-control" />
            </div>
            <div class="form-group">
              <label>Avatar</label> <input type="file" name="images" multiple="multiple">
            </div>
            <div class="form-check">
              <input class="form-check-input" type="checkbox" checked="true" id="flexCheckDefault">
              <label class="form-check-label" for="flexCheckDefault">
                Available
              </label>
            </div>
            <button type="submit" class="btn btn-primary mt-3">Add Post</button>
          </form>
        </div>
      </main>
      <footer class="py-4 bg-light mt-auto">
        <div class="container-fluid">
          <div class="d-flex align-items-center justify-content-between small">
            <div class="text-muted">Copyright &copy; Your Website 2020</div>
            <div>
              <a href="#">Privacy Policy</a>
              &middot;
              <a href="#">Terms &amp; Conditions</a>
            </div>
          </div>
        </div>
      </footer>
    </div>
  </div>
  <jsp:include page="/WEB-INF/views/back-end/common/footer.jsp"></jsp:include>

    $(document).ready(function () {
      $('.summernote').summernote();

      $('#add-tag').click(function(){
        $('#tags-form-container').append('<input type="text" class="form-control tags-form mb-1" />')
      })

      $('#add-color').click(function(){
        $('#colors-form-container').append('<input type="text" class="form-control colors-form mb-1" />')
      })
    }); 
  </script>
</body>

</html>