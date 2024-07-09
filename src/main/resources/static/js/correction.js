$(document).ready(function() {
    test();
    document.querySelector("#searchAddress").addEventListener("click", execDaumPostcode);
});

// 이미지를 미리 불러오는 js
function prevImage(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById('preview').src = e.target.result;
            document.getElementById('myfie').src=e.target.result;
        };
        reader.readAsDataURL(input.files[0]);
    } else {
        document.getElementById('preview').src = "";

    }
}

//유효성검사
function test() {
    let p1 = document.getElementById('childName').value;
    let p2 = document.getElementById('childInstruct').value;
    let p3 = document.getElementById('presentNew').value;

    if (p3 != p2) {
        alert("비밀번호가 일치 하지 않습니다");
        return false;
    } else if (p1 == p3) {
        alert("현재 비밀번호와 같습니다");
        return false;
    } else {
        var newPassword = document.getElementById('hiddenPassword');
        newPassword.value = p2;
        console.log(p2);
        const btnSubmitModal=document.querySelector('.regist-btn');
        btnSubmitModal.addEventListener("click", ()=>{
            modal.style.display="none";
        });
        alert("성공적으로 수정되었습니다.");
    }
    document.getElementById('childName').value = '';
    document.getElementById('presentNew').value = '';
    document.getElementById('childInstruct').value = '';
}

$(document).ready(function() {
    prevImage();
    test();
    document.querySelector("#searchAddress").addEventListener("click", execDaumPostcode);
});

// 이미지를 미리 불러오는 js
function prevImage(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById('preview').src = e.target.result;
            document.getElementById('img').src=e.target.result;
        };
        reader.readAsDataURL(input.files[0]);
    } else {
        document.getElementById('preview').src = "";

    }


}

//유효성검사
function test() {
    let p1 = document.getElementById('childName').value;
    let p2 = document.getElementById('childInstruct').value;
    let p3 = document.getElementById('presentNew').value;

    if (p3 != p2) {
        alert("비밀번호가 일치 하지 않습니다");
        return false;
    } else if (p1 == p3) {
        alert("현재 비밀번호와 같습니다");
        return false;
    } else {
        var newPassword = document.getElementById('hiddenPassword');
        newPassword.value = p2;
        console.log(p2);
        const btnSubmitModal=document.querySelector('.regist-btn');
        btnSubmitModal.addEventListener("click", ()=>{
            modal.style.display="none";
        });
        alert("성공적으로 수정되었습니다.");
    }
    document.getElementById('childName').value = '';
    document.getElementById('presentNew').value = '';
    document.getElementById('childInstruct').value = '';
}

