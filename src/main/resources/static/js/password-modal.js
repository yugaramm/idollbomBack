const modal = document.querySelector('.modal-pwd');
const btnOpenModal=document.querySelector('.btn-open-modal');
const btnCloseModal=document.querySelector('.close-btn');
const btnCloseModal2=document.querySelector('#close-btn');

btnOpenModal.addEventListener("click", ()=>{
    modal.style.display="flex";
});

btnCloseModal.addEventListener("click", ()=>{
    modal.style.display="none";
});

btnCloseModal2.addEventListener("click", ()=>{
    modal.style.display="none";
});