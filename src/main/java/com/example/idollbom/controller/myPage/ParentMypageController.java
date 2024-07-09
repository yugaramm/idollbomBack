package com.example.idollbom.controller.myPage;
import com.example.idollbom.domain.dto.logindto.ParentDTO;
import com.example.idollbom.domain.dto.myPagedto.parentdto.kidDTO;
import com.example.idollbom.domain.dto.myPagedto.parentdto.mailDTO;
import com.example.idollbom.domain.vo.*;
import com.example.idollbom.service.myPageservice.parentservice.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
//    @GetMapping("/classSave")
//    public String selectClassList(Model model){
//        List<classSaveVO> classList = classSaveService.selectClassList();
//        for(int i=0; i<classList.size(); i++){
//
//        }
//        model.addAttribute("myPost", postList);
//        return "html/myPage/parent/myPost";
//    }

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
    public String updateParentInfo(ParentDTO parentDTO, @RequestParam("files") MultipartFile files) throws IOException {
        parentInfoService.update(parentDTO,files);
        return "redirect:/ParentMyPage/myInformation";
    }
}
