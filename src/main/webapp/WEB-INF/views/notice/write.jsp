<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp"%>

<div class="page-wrapper">
  <!-- ============================================================== -->
  <!-- Bread crumb and right sidebar toggle -->
  <!-- ============================================================== -->
  <div class="page-breadcrumb">
    <div class="row">
      <div class="col-12 d-flex no-block align-items-center">
        <h4 class="page-title">공지사항</h4>
        <div class="ml-auto text-right">
          <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Notice</li>
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
        <div class="col-lg-12 mb-4">
          <!-- general form elements -->
          <div class="card card-primary">
            <div class="card-header">
              <h3 class="card-title">공지사항 작성</h3>
            </div>
            <!-- /.card-header -->
            <!-- form start -->
            <form id="form1" action="/notice/write" method="post">
              <div class="card-body">
                <div class="form-group">
                  <label for="exampleInputEmail1">제목</label>
                  <input type="text" name="noticeTitle" class="form-control" id="exampleInputEmail1" placeholder="제목 입력">
                </div>
                <div class="row">
                  <div class="col-sm-12">
                    <!-- textarea -->
                    <div class="form-group">
                      <label>내용</label>
                      <textarea name="noticeContent" class="form-control" rows="3" placeholder="내용 입력"></textarea>
                    </div>
                  </div>
                </div>
              </div>
              <!-- /.card-body -->

              <div class="temp"></div>

              <div class="card-footer" style="background-color: #141619">
                <button type="submit" id="submitBtn" class="btn btn-primary py-1 px-2">등록</button>
              </div>
            </form>

            <style>
              .uploadResult {
                display: flex;
                justify-content: center;
                flex-direction: row;
              }
            </style>

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

            </div>

          </div>
          <!-- /.card -->
        </div>
      </div>
    </div>
  </section>
</div>
<!-- /.content-wrapper -->

<%@include file="../includes/footer.jsp"%>

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

    console.log(formData)

    const headerObj = { headers: {'Content-Type': 'multipart/form-data'}}

    axios.post("/upload", formData, headerObj).then((response) => {
      const arr = response.data
      console.log(arr)
      let str = ""
      for(let i = 0; i < arr.length; i++){
        const {uuid,fileName,uploadPath,image,thumbnail,fileLink} = {...arr[i]}

        if(image){
          str += `<div data-uuid='\${uuid}' data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}' ><img src='/viewFile?file=\${thumbnail}'/><span>\${fileName}</span>
                            <button onclick="javascript:removeFile('\${fileLink}',this)" >x</button></div>`
        }else {
          str += `<div data-uuid='\${uuid}'data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}'><a href='/downFile?file=\${fileLink}'>\${fileName}</a></div>`
        }


      }//end for
      uploadResultDiv.innerHTML += str

    })


  },false)

  function removeFile(fileLink,ele){
    console.log(fileLink)
    axios.post("/removeFile", {fileName:fileLink}).then(response => {
      const targetDiv = ele.parentElement
      targetDiv.remove()
    })
  }


  document.querySelector("#submitBtn").addEventListener("click",(e) => {
    e.stopPropagation()
    e.preventDefault()
    //현재 화면에 있는 파일 정보를 hidden태그들로 변화
    const form1 = document.querySelector("#form1")
    const fileDivArr = uploadResultDiv.querySelectorAll("div")

    if(!fileDivArr){

      form1.submit()

      return
    }

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
    }

    document.querySelector(".temp").innerHTML = str
    //form1.innerHTML += str
    form1.submit()
    //form을 submit

  },false)

</script>

</body>
</html>