<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp"%>


<style>
  .container
</style>

<div class="page-wrapper">
  <div class="page-breadcrumb">
    <div class="row">
      <div class="col-12 d-flex no-block align-items-center">
        <h4 class="page-title">자유게시판</h4>
        <div class="ml-auto text-right">
          <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">자유게시판</li>
            </ol>
          </nav>
        </div>
      </div>
    </div>
  </div>

  <!-- Main content -->
  <section class="content">
    <div class="container bg-light">
      <div class="row">
        <!-- left column -->
        <div class="col-md-12 mb-4">
          <!-- general form elements -->
          <div class="card card-primary">
            <!-- form start -->
            <form id="form1">
              <input type="hidden" name="mbNo" value="${miniDTO.mbNo}">
              <input type="hidden" name="page" value="${pageRequestDTO.page}">
              <input type="hidden" name="size" value="${pageRequestDTO.size}">
              <div class="card-body">
                <div class="form-group">
                  <label for="exampleInputEmail1">제목</label>
                  <input type="text" name="mbTitle" class="form-control" id="exampleInputEmail1" placeholder="제목 입력"value="<c:out value="${miniDTO.mbTitle}"></c:out>">
                  </div>
                <div class="col-sm-12">
                  <!-- textarea -->
                  <div class="form-group">
                    <label>내용</label>
                    <textarea name="mbContent" class="form-control" rows="3" placeholder="내용 입력"><c:out value="${miniDTO.mbContent}"></c:out></textarea>
                  </div>
                </div>
                <div class="form-group">
                  <label for="exampleInputEmail2">작성자</label>
                  <input type="text" name="mbWriter" class="form-control" id="exampleInputEmail2" placeholder="Enter Writer" readonly value="<c:out value="${miniDTO.mbWriter}"></c:out>">
                </div>
              </div>
              <div class="temp"></div>
              <!-- /.card-body -->
              <div class="card-footer" style="background-color: #141619">
                <button type="submit" class="btn btn-secondary btnMod">수정</button>
                <button type="submit" class="btn btn-danger btnDel">삭제</button>
                <button type="submit" class="btn btn-default btnList">목록</button>
              </div>
            </form>


            <label for="exampleInputFile">File input</label>
            <div class="input-group">
              <div class="custom-file">
                <input type="file" name="uploadFiles" class="custom-file-input" id="exampleInputFile" multiple>
                <label class="custom-file-label" for="exampleInputFile">Choose file</label>
              </div>
              <div class="input-group-append">
                <span class="input-group-text" id="uploadBtn">Upload</span>
              </div>
            </div>

            <div class="uploadResult">
              <c:forEach items="${miniDTO.files}" var="attach">
                <c:if test="${attach.image}">
                  <div data-uuid="${attach.uuid}" data-filename="${attach.fileName}"
                  data-uploadpath="${attach.uploadPath}" data-image="${attach.image}">
                  <img src="/viewFile?file=${attach.getThumbnail()}">
                  ${attach.fileName}
                  <button onclick="javascript:removeDiv(this)">삭제</button>
                </c:if>
                </div>
              </c:forEach>
            </div>

          </div>
          <!-- /.card -->
        </div>
      </div>
    </div>
  </section>
</div>
<!-- /.content-wrapper -->

<form id="actionForm" action="/miniboard/list" method="get">
  <input type="hidden" name="page" value="${pageRequestDTO.page}">
  <input type="hidden" name="size" value="${pageRequestDTO.size}">

  <c:if test="${pageRequestDTO.type != null}">
    <input type="hidden" name="type" value="${pageRequestDTO.type}">
    <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
  </c:if>
</form>

<%@include file="../includes/footer.jsp"%>

<script>
  const form = document.querySelector("#form1")
  const actionForm = document.querySelector("#actionForm")

  document.querySelector(".btnList").addEventListener("click", e => {
    e.preventDefault();
    e.stopPropagation();

    actionForm.submit();
  }, false)

  document.querySelector(".btnMod").addEventListener("click", e => {
    e.preventDefault();
    e.stopPropagation();

    const fileDivArr = uploadResultDiv.querySelectorAll("div")

    if(fileDivArr && fileDivArr.length > 0) {
      let str ="";
      for(let i = 0; i < fileDivArr.length; i++){
        const target = fileDivArr[i]
        const uuid = target.getAttribute("data-uuid")
        const fileName = target.getAttribute("data-filename")
        const uploadPath = target.getAttribute("data-uploadpath")
        const image = target.getAttribute("data-image")

        str += `<input type='hidden' name='files[\${i}].uuid' value='\${uuid}' >`
        str += `<input type='hidden' name='files[\${i}].fileName' value='\${fileName}' >`
        str += `<input type='hidden' name='files[\${i}].uploadPath' value='\${uploadPath}' >`
        str += `<input type='hidden' name='files[\${i}].image' value='\${image}' >`

      }//end for

      document.querySelector(".temp").innerHTML = str
    }//end if

    form.setAttribute("action", "/miniboard/modify")
    form.setAttribute("method", "post")
    form.submit()
  }, false)

  document.querySelector(".btnDel").addEventListener("click", e => {
    e.preventDefault();
    e.stopPropagation();

    form.setAttribute("action", "/miniboard/remove")
    form.setAttribute("method", "post")
    form.submit()
  }, false)



</script>

<%--axios스크립트--%>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>

  const uploadResultDiv = document.querySelector(".uploadResult")

  document.querySelector("#uploadBtn").addEventListener("click",(e) => {

    const formData = new FormData()
    const fileInput = document.querySelector("input[name='uploadFiles']")

    for(let i = 0; i < fileInput.files.length; i++){

      //console.log(fileInput.files[i])

      formData.append("uploadFiles", fileInput.files[i])
    }
    //append의 이름이 파라미터의 이름이 됨. 매우중요

    console.log(formData)

    const headerObj = { headers: {'Content-Type': 'multipart/form-data'}}
    //헤더객체 생성

    axios.post("/upload", formData, headerObj).then((response) => {
      const arr = response.data
      console.log(arr)
      let str = ""
      for(let i = 0; i < arr.length; i++){
        const {uuid,fileName,uploadPath,image,thumbnail,fileLink} = {...arr[i]}

        if(image){
          str += `<div data-uuid='\${uuid}' data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}' ><img src='/viewFile?file=\${thumbnail}'/><span>\${fileName}</span>
                            <br><button type="button" onclick="javascript:removeDiv(this)">삭제</button></div>`
        }else {
          str += `<div data-uuid='\${uuid}'data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}'><a href='/downFile?file=\${fileLink}'>\${fileName}</a></div>`
        }
      }//end for
      uploadResultDiv.innerHTML += str
    })

  },false)

  function removeDiv(ele){
    ele.parentElement.remove();
  }
</script>


</body>
</html>