<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp" %>
    <div class="page-wrapper">
        <!-- ============================================================== -->
        <!-- Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <div class="page-breadcrumb">
            <div class="row">
                <div class="col-12 d-flex no-block align-items-center">
                    <h4 class="page-title">Charts</h4>
                    <div class="ml-auto text-right">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Library</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- End Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Container fluid  -->
        <!-- ============================================================== -->
        <div class="container-fluid">
            <!-- ============================================================== -->
            <!-- Start Page Content -->
            <!-- ============================================================== -->
            <!-- Chart-1 -->
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">실시간 방문자 수</h5>
                            <div id="real-time" style="height:400px;"></div>
                            <p>Time between updates:
                                <input id="updateInterval" type="text" value="" style="text-align: right; width:5em"> milliseconds
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ENd chart-1 -->
            <!-- Cards -->
            <div class="row">
                <div class="col-md-3">
                    <div class="card m-t-0">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="peity_line_neutral left text-center m-t-10"><span><span style="display: none;">10,15,8,14,13,10,10</span>
                                        <canvas width="50" height="24"></canvas>
                                        </span>
                                    <h6>10%</h6>
                                </div>
                            </div>
                            <div class="col-md-6 border-left text-center p-t-10">
                                <h3 class="mb-0 font-weight-bold">50</h3>
                                <span class="text-muted">신규 이용자</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card m-t-0">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="peity_bar_bad left text-center m-t-10"><span><span style="display: none;">3,5,6,16,8,10,6</span>
                                        <canvas width="50" height="24"></canvas>
                                        </span>
                                    <h6>-20%</h6></div>
                            </div>
                            <div class="col-md-6 border-left text-center p-t-10">
                                <h3 class="mb-0 font-weight-bold">60</h3>
                                <span class="text-muted">전일대비 게시물</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card m-t-0">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="peity_line_good left text-center m-t-10"><span><span style="display: none;">12,6,9,23,14,10,17</span>
                                        <canvas width="50" height="24"></canvas>
                                        </span>
                                    <h6>+60%</h6>
                                </div>
                            </div>
                            <div class="col-md-6 border-left text-center p-t-10">
                                <h3 class="mb-0 ">5672</h3>
                                <span class="text-muted">총 게시물</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card m-t-0">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="peity_bar_good left text-center m-t-10"><span>12,6,9,23,14,10,13</span>
                                    <h6>+5%</h6>
                                </div>
                            </div>
                            <div class="col-md-6 border-left text-center p-t-10">
                                <h3 class="mb-0 font-weight-bold">12560</h3>
                                <span class="text-muted">총 이용자</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End cards -->
            <!-- Chart-2 -->
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">일자별 통계</h5>
                            <div id="placeholder" style="height: 400px;"></div>
                            <p id="choices" class="m-t-20"></p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Chart-2 -->


            <!-- ============================================================== -->
            <!-- End PAge Content -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Right sidebar -->
            <!-- ============================================================== -->
            <!-- .right-sidebar -->
            <!-- ============================================================== -->
            <!-- End Right sidebar -->
            <!-- ============================================================== -->
        </div>
        <!-- ============================================================== -->
        <!-- End Container fluid  -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- footer -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Page wrapper  -->
    <!-- ============================================================== -->
</div>
<!-- ============================================================== -->
<!-- End Wrapper -->
<!-- ============================================================== -->
<!-- ============================================================== -->
<!-- All Jquery -->
<!-- ============================================================== -->
<%@include file="../includes/footer.jsp"%>
<script src="/resources/assets/libs/jquery//resources/dist/jquery.min.js"></script>
<!-- Bootstrap tether Core JavaScript -->
<script src="/resources/assets/libs/popper.js//resources/dist/umd/popper.min.js"></script>
<script src="/resources/assets/libs/bootstrap//resources/dist/js/bootstrap.min.js"></script>
<!-- slimscrollbar scrollbar JavaScript -->
<script src="/resources/assets/libs/perfect-scrollbar//resources/dist/perfect-scrollbar.jquery.min.js"></script>
<script src="/resources/assets/extra-libs/sparkline/sparkline.js"></script>
<!--Wave Effects -->
<script src="/resources/dist/js/waves.js"></script>
<!--Custom JavaScript -->
<script src="/resources/dist/js/custom.min.js"></script>
<!-- this page js -->
<script src="/resources/assets/libs/chart/matrix.interface.js"></script>
<script src="/resources/assets/libs/chart/excanvas.min.js"></script>
<script src="/resources/assets/libs/flot/jquery.flot.js"></script>
<script src="/resources/assets/libs/flot/jquery.flot.pie.js"></script>
<script src="/resources/assets/libs/flot/jquery.flot.time.js"></script>
<script src="/resources/assets/libs/flot/jquery.flot.stack.js"></script>
<script src="/resources/assets/libs/flot/jquery.flot.crosshair.js"></script>
<script src="/resources/assets/libs/chart/jquery.peity.min.js"></script>
<script src="/resources/assets/libs/chart/matrix.charts.js"></script>
<script src="/resources/assets/libs/chart/jquery.flot.pie.min.js"></script>
<script src="/resources/assets/libs/flot.tooltip/js/jquery.flot.tooltip.min.js"></script>
<script src="/resources/assets/libs/chart/turning-series.js"></script>
<script src="/resources/dist/js/pages/chart/chart-page-init.js"></script>
</body>

</html>