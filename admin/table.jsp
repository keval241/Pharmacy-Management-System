<%-- 
    Document   : table
    Created on : Feb 11, 2025, 10:08:50 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="container-fluid">
    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Contact Details</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                    <!--                                    <div class="row">
                                                            <div class="col-sm-12 col-md-6">
                                                                <div class="dataTables_length" id="dataTable_length">
                                                                    <label>Show <select name="dataTable_length" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm">
                                                                            <option value="10">10</option>
                                                                            <option value="25">25</option>
                                                                            <option value="50">50</option>
                                                                            <option value="100">100</option></select> 
                                                                            entries</label></div></div>
                                                                    <div class="col-sm-12 col-md-6"><div id="dataTable_filter" class="dataTables_filter">
                                                                            <label>Search:<input type="search" class="form-control form-control-sm" placeholder="" aria-controls="dataTable"></label>
                                                                        </div></div></div>-->
                    <div class="row">
                        <div class="col-sm-12">
                            <table class="table table-bordered dataTable" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
                                <thead>
                                    <tr role="row">
                                        <th class="sorting sorting_asc" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 62px;">Name</th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending" style="width: 73px;">Position</th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending" style="width: 52px;">Office</th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Age: activate to sort column ascending" style="width: 31px;">Age</th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Start date: activate to sort column ascending" style="width: 69px;">Start date</th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Salary: activate to sort column ascending" style="width: 67px;">Salary</th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Salary: activate to sort column ascending" style="width: 67px;">Action</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th rowspan="1" colspan="1">Name</th>
                                        <th rowspan="1" colspan="1">Position</th>
                                        <th rowspan="1" colspan="1">Office</th>
                                        <th rowspan="1" colspan="1">Age</th>
                                        <th rowspan="1" colspan="1">Start date</th>
                                        <th rowspan="1" colspan="1">Salary</th>
                                        <th rowspan="1" colspan="1">Action</th>
                                    </tr>
                                </tfoot>
                                <tbody>

                                    <tr class="odd">
                                        <td class="sorting_1">Airi Satou</td>
                                        <td>Accountant</td>
                                        <td>Tokyo</td>
                                        <td>33</td>
                                        <td>2008/11/28</td>
                                        <td>$162,700</td>
                                        <td>
                                            <a href="#" class="mx-1"><i class="fas fa-edit text-success fa-2x"></i></a>
                                            <a href="#" class="mx-1"><i class="fas fa-trash text-danger fa-2x"></i></a>
                                        </td>
                                    </tr>
                                    <tr class="even">
                                        <td class="sorting_1">Angelica Ramos</td>
                                        <td>Chief Executive Officer (CEO)</td>
                                        <td>London</td>
                                        <td>47</td>
                                        <td>2009/10/09</td>
                                        <td>$1,200,000</td>
                                        <td>
                                            <a href="#" class="mx-1"><i class="fas fa-edit text-success fa-2x"></i></a>
                                            <a href="#" class="mx-1"><i class="fas fa-trash text-danger fa-2x"></i></a>
                                        </td>
                                    </tr>
                                    <tr class="odd">
                                        <td class="sorting_1">Ashton Cox</td>
                                        <td>Junior Technical Author</td>
                                        <td>San Francisco</td>
                                        <td>66</td>
                                        <td>2009/01/12</td>
                                        <td>$86,000</td>
                                        <td>
                                            <a href="#" class="mx-1"><i class="fas fa-edit text-success fa-2x"></i></a>
                                            <a href="#" class="mx-1"><i class="fas fa-trash text-danger fa-2x"></i></a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!--                          <div class="row">
                                                  <div class="col-sm-12 col-md-5">
                                                      <div class="dataTables_info" id="dataTable_info" role="status" aria-live="polite">Showing 1 to 10 of 36 entries</div></div>
                                                  <div class="col-sm-12 col-md-7">
                                                      <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
                                                          <ul class="pagination">
                                                              <li class="paginate_button page-item previous disabled" id="dataTable_previous">
                                                                      <a href="#" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
                                                              <li class="paginate_button page-item active">
                                                                  <a href="#" aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
                                                              <li class="paginate_button page-item ">
                                                                  <a href="#" aria-controls="dataTable" data-dt-idx="2" tabindex="0" class="page-link">2</a></li>
                                                              <li class="paginate_button page-item ">
                                                                  <a href="#" aria-controls="dataTable" data-dt-idx="3" tabindex="0" class="page-link">3</a></li>
                                                              <li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="4" tabindex="0" class="page-link">4</a></li>
                                                              <li class="paginate_button page-item next" id="dataTable_next"><a href="#" aria-controls="dataTable" data-dt-idx="5" tabindex="0" class="page-link">Next</a></li>
                                                          </ul>
                                                      </div>
                                                  </div>
                                              </div>-->
                </div>
            </div>
        </div>
    </div>
</div>
<!--response.sendRedirect("Admin/Home.jsp");
               HttpSession session=request.getSession();
               session.setAttribute("aid", rs.getInt("a_id"));
               session.setAttribute("username", rs.getString("a_name"));
<!-- End of Main Content ---->
<%@include file="Footer.jsp" %>