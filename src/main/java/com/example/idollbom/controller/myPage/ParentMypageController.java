package com.example.idollbom.controller.myPage;
import com.example.idollbom.domain.dto.logindto.ParentDTO;
import com.example.idollbom.domain.dto.myPagedto.parentdto.classSaveDTO;
import com.example.idollbom.domain.dto.myPagedto.parentdto.kidDTO;
import com.example.idollbom.domain.dto.myPagedto.parentdto.mailDTO;
import com.example.idollbom.domain.dto.myPagedto.parentdto.paymentDTO;
import com.example.idollbom.domain.dto.parentdto.ReviewDTO;
import com.example.idollbom.domain.vo.*;
import com.example.idollbom.mapper.loginmapper.ParentMapper;
import com.example.idollbom.service.applyservice.ClassListService;
import com.example.idollbom.service.myPageservice.parentservice.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.Console;
import java.io.IOException;
import java.time.LocalDate;
import java.time.Period;
import java.util.List;

@Controller
@RequestMapping("/ParentMyPage")
@RequiredArgsConstructor
@Slf4j
public class ParentMypageController {

    private final kidsService kidsService;
    private final reportService reportService;
    private final askService askService;
    private final myPostService myPostService;
    private final reviewService reviewService;
    private final noteService noteService;
    private final parentInfoService parentInfoService;
    private final classSaveService classSaveService;
    private final paymentService paymentService;
    private final reservationService reservationService;
    private final reservationDateService reservationDateService;
    private final ParentMapper parentMapper;
    private final ClassListService classListService;

//  kid 페이지로 이동
    @GetMapping("/kids")
    public String getKids(Model model){
        List<kidVO> kids = kidsService.selectKidsList();
        model.addAttribute("kid", new kidDTO());
        model.addAttribute("kids", kids);
        return "html/myPage/parent/myKids";
    }

//  아이등록
    @PostMapping("/insertKids")
    public String insertKids(@ModelAttribute kidDTO kid){
        log.info("HTML에서 넘어온 데이터: " + kid);

        //      날짜 문자열 뽑기
        LocalDate birthday = LocalDate.parse(kid.getChildAge());
        //      현재 날짜
        LocalDate currentDate = LocalDate.now();
        //      둘사이 기간
        Period period = Period.between(birthday, currentDate);
        //      년도만 뽑아서 저장
        int age = period.getYears();
        kid.setChildAge(String.valueOf(age));

        kidsService.insertKids(kid);

        return "redirect:/ParentMyPage/kids";
    }

    //  아이삭제
    @PostMapping("/deleteKids")
    public String deleteKids(@RequestBody Long kidNumber){
        log.info("받은거"+kidNumber);
        kidsService.deleteKids(kidNumber);
        return "redirect:/ParentMyPage/kids";
    }

    // 신고목록 페이지 이동
    @GetMapping("/reportPage")
    public String selectReport(Model model){
      List<reportVO> reportUser = reportService.selectReportList();
        model.addAttribute("reportUser", reportUser);
        return "html/myPage/parent/hateUser";
    }

    // 문의목록 페이지 이동
    @GetMapping("/askPage")
    public String selectAsk(Model model){
        List<askVO> askList = askService.selectAskList();
        model.addAttribute("askList",askList );
        return "html/myPage/parent/myAsk";
    }

    //내가쓴 글 페이지 이동
    @GetMapping("/myPost")
    public String selectMyPostList(Model model){
        List<myPostVO> postList = myPostService.selectPostList();
        model.addAttribute("myPost", postList);
        return "html/myPage/parent/myPost";
    }

    //내가쓴 리뷰 페이지로 이동
    @GetMapping("/Review")
    public String selectReviewList(Model model){
        List<reviewVO> reviewList = reviewService.selectRiviewList();
//        for(int i=0; i<reviewList.size(); i++){
//            Long parentId = reviewList.get(i).getParentNumber();
//
//        }
        model.addAttribute("ReviewList", reviewList);
        return "html/myPage/parent/myReview";
    }

    //찜한 목록으로 이동
    @GetMapping("/classSave")
    public String selectClassList(Model model){
        List<classSaveDTO> classList = classSaveService.selectClassList();

        model.addAttribute("saveClass", classList);
        log.info(String.valueOf(classList.size()));
        return "html/myPage/parent/myFavoriteClass";
    }

//    쪽지 목록으로 이동
    @GetMapping("/myNote")
    public String selectMyNoteList(Model model){
        List<mailDTO> noteList = noteService.selectAllMyNote();
        model.addAttribute("myNotes", noteList);
        return "html/myPage/parent/mail";
    }

    //  내정보 받아오기
    @GetMapping("/myInformation")
    public String selectMailId(Model model){
       ParentVO parentInfo = parentInfoService.selectParentInfo();
       model.addAttribute("parentInfo", parentInfo);
        return "html/myPage/parent/correction";
    }

    // 내정보 update
    @PostMapping("/updateMyInfo")
    public String updateParentInfo(@ModelAttribute ParentDTO parentDTO, @RequestParam("file") MultipartFile file) throws IOException {
        parentInfoService.update(parentDTO,file);
        return "redirect:/ParentMyPage/myInformation";
    }

    // 수업 찜 목록 추가 ( 수업 상세보기에서 찜 목록 추가 버튼 클릭 시 넘어오는 컨트롤러 )
    @GetMapping("/insertSaveClass")
    public String selectFavoriteClass(@RequestParam(value= "classNumber") Long classNumber,
                                      @RequestParam(value= "parentNumber") Long parentNumber,
                                      @RequestParam(value="proNumber") Long proNumber,
                                      RedirectAttributes redirectAttributes){

        log.info("수업 찜 클릭 받아온 데이터 : " + classNumber);
        log.info("수업 찜 클릭 받아온 데이터 : " + parentNumber);
        log.info("수업 찜 클릭 받아온 데이터 : " + proNumber);

        classSaveService.saveClass(classNumber, parentNumber);
        redirectAttributes.addAttribute("proNumber", proNumber);
        redirectAttributes.addAttribute("classNumber", classNumber);

        return "redirect:/class/detail"; // 수업 상세보기 페이지
    }

    // 수업 찜 목록 추가 ( 신청하기 페이지에서 찜 목록 버튼 클릭 시 넘어오는 컨트롤러 )
//    @PostMapping("/insertSaveClass/{classNumber}")
//    public String selectFavoriteClass(@PathVariable(value="classNumber") Long classNumber,
//                                      @RequestParam(value="bigCategory") String bigCategory,
//                                      @RequestParam(value="smallCategory") String smallCategory,
//                                      @RequestParam(value="pageNo", defaultValue = "1") int pageNo,
//                                      @RequestParam(value = "pageSize", defaultValue = "5") int pageSize,
//                                      RedirectAttributes redirectAttributes){
//        // 부모 정보를 받아오는 코드
//        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
//        String currentUserName = userDetails.getUsername();
//
//        log.info("classList.js 에서 받아온 데이터 : " + bigCategory);
//        log.info("classList.js 에서 받아온 데이터 : " + smallCategory);
//        log.info("classList.js 에서 받아온 데이터 : " + pageNo);
//        log.info("classList.js 에서 받아온 데이터 : " + pageSize);
//
//        // ==================== 수업 찜 목록 추가하는 로직 ==================== //
//        // String -> Long 변환
////        Long long_classNumber = Long.parseLong(classNumber);
//
//        ParentVO parent_info = parentMapper.selectOne(currentUserName);
//        classSaveService.saveClass(classNumber, parent_info.getParentNumber());
//
//        // ================================================================= //
//
//        // 리다이렉트되는 컨트롤러로 매개변수 전달
//        redirectAttributes.addAttribute("category", smallCategory);
//        redirectAttributes.addAttribute("pageNo", pageNo);
//        redirectAttributes.addAttribute("pageSize", pageSize);
//
//        // 카테고리에 따라 요청할 리다이렉트 주소가 다르다.
//        if(bigCategory.equals("돌봄")){
//            return "redirect:/class/classcare";
//        }else if(bigCategory.equals("예능")){
//            return "redirect:/class/classentertainment";
//        }else if(bigCategory.equals("운동")){
//            return "redirect:/class/classsport";
//        }else{
//            return "redirect:/class/classstudy";
//        }
//    }

    //  수업 찜 목록 삭제
    @GetMapping("/deleteFavorite/{classNumber}")
    public String deleteFavorite(@PathVariable(name = "classNumber") Long classNumber){
        classSaveService.deleteClass(classNumber);
        return "redirect:/ParentMyPage/classSave";
    }

    //  결제한 수업내역 보기
    @GetMapping("/myPayment")
    public String selectMyPayment(Model model){
        List<paymentDTO> payment = paymentService.paymentList();
        model.addAttribute("review", new ReviewDTO());
        model.addAttribute("Mypayment",  payment);
        log.info("Review object: " + model.getAttribute("Mypayment"));
        return "html/myPage/parent/Payment";
    }

//  리뷰쓰기
    @PostMapping("/writeReview")
    public String insertReview(@ModelAttribute ReviewDTO reviewDTO){
        System.out.println("Received ReviewDTO: " + reviewDTO);
        reviewService.insertReview(reviewDTO);

        ReservationDateVO reservationDate = reservationDateService.selectReservationDate(reviewDTO.getClassNumber());
        reservationService.reviewUpdate(reservationDate.getReservationDateNumber());
        return "redirect:/ParentMyPage/myPayment";
    }

}
