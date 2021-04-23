<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:include page="/WEB-INF/views/back-end/common/header.jsp"></jsp:include>
    <div id="layoutSidenav_content">
      <main>
        <div class="container-fluid">
          <h1 class="mt-4">Tables</h1>
          <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
            <li class="breadcrumb-item active">Tables</li>
          </ol>
          <div class="card mb-4">
            <div class="card-body">
              DataTables is a third party plugin that is used to generate the demo table below. For more information
              about DataTables, please visit the
              <a target="_blank" href="https://datatables.net/">official DataTables documentation</a>
              .
            </div>
          </div>
          <div class="card mb-4">
            <div class="card-header">
              <i class="fas fa-table mr-1"></i>
              DataTable Example
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>Name</th>
                      <th>Description</th>
                      <th class="text-center">Status</th>
                      <th>Edit</th>
                      <th>Remove</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>Name</th>
                      <th>Description</th>
                      <th class="text-center">Status</th>
                      <th>Edit</th>
                      <th>Remove</th>
                    </tr>
                  </tfoot>
                  <tbody>
                    <tr>
                      <td>Tiger Nixon</td>
                      <td>Lorem ipsum</td>
                      <td class="text-center text-danger"><h5><i class="fas fa-minus-circle"></i></h5></td>
                      <td><button class="btn btn-warning"><i class="fas fa-edit"></i></button></td>
                      <td><button class="btn btn-danger"><i class="fas fa-trash-alt"></i></button></td>
                    </tr>
                    <tr>
                      <td>Tiger Tran</td>
                      <td>Lorem ispum</td>
                      <td class="text-center text-success"><h5><i class="fas fa-check-circle"></i></h5></td>
                      <td><button class="btn btn-warning"><i class="fas fa-edit"></i></button></td>
                      <td><button class="btn btn-danger"><i class="fas fa-trash-alt"></i></button></td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </main>
      <jsp:include page="/WEB-INF/views/back-end/common/footer.jsp"></jsp:include>
</body>

</html>