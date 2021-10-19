<%@ page contentType="text/html;charset=UTF-8" language="java" %>

            <form id="answerform" action="/qna/writeAnswer" method="post">
              <div class="card-body">
                <div class="form-group">
                  <label for="exampleInputEmail1">제목</label>
                  <input type="text" name="qnaTitle" class="form-control" id="exampleInputEmail1" placeholder="제목 입력" readonly value="답변 : <c:out value="${qnaDTO.qnaTitle}"></c:out>">
                </div>
                <div class="form-group">
                  <label for="exampleInputEmail2">작성자</label>
                  <input type="text" name="qnaWriter" class="form-control" id="exampleInputEmail2" placeholder="Enter Writer" readonly value="<c:out value="${qnaDTO.qnaWriter}"></c:out>">
                </div>
                <div class="row">
                  <div class="col-sm-12">
                    <!-- textarea -->
                    <div class="form-group">
                      <label>답변 내용</label>
                      <textarea name="qnaContent" class="form-control" rows="3" placeholder="내용 입력"></textarea>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label for="exampleInputEmail0">답변 이메일</label>
                  <input type="text" name="qnaAnswerEmail" class="form-control" id="exampleInputEmail0" readonly value="<c:out value="${qnaDTO.qnaAnswerEmail}"></c:out>">
                  <input type="hidden" name="originId" value="${qnaDTO.originId}">
                  <%--이메일 자동입력 변경 필요 --%>
                </div>
              </div>

              <!-- /.card-body -->

              <div class="temp"></div>

              <div class="card-footer">
                <button type="button" id="submitBtn" class="btn btn-primary">등록</button>
              </div>
            </form>
