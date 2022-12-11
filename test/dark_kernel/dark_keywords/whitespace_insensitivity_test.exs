defmodule DarkKernel.DarkKeywords.WhitespaceInsensitivityTest do
  use ExUnit.Case, async: true
  import ExUnitProperties
  import StreamData

  import DarkKernel

  # ----------------------------------------------
  # ~k[] lists are not whitespace sensitive
  # ----------------------------------------------

  test "~k[] are whitespace insensitive, example #1: 2 variables" do
    check all a_2nGD5R__wM0Fr <- term(),
              hdlS6bNkWyIyLCzL <- term() do
      # Check for equality with different amounts of whitespace
      assert ~k[a_2nGD5R__wM0Fr, hdlS6bNkWyIyLCzL] == ~k[a_2nGD5R__wM0Fr,hdlS6bNkWyIyLCzL]
    end
  end

  test "~k[] are whitespace insensitive, example #2: 3 variables" do
    check all xcZC_syIqIH? <- term(),
              qeC_w2! <- term(),
              goZiGE <- term() do
      # Check for equality with different amounts of whitespace
      assert ~k[xcZC_syIqIH?, qeC_w2!, goZiGE] == ~k[xcZC_syIqIH?,qeC_w2! ,goZiGE  ]
    end
  end

  test "~k[] are whitespace insensitive, example #3: 4 variables" do
    check all v__864wz7qor? <- term(),
              fIHGs8GOw1? <- term(),
              je! <- term(),
              fKQweh3w6nye! <- term() do
      # Check for equality with different amounts of whitespace
      assert ~k[v__864wz7qor?, fIHGs8GOw1?, je!, fKQweh3w6nye!] ==
               ~k[v__864wz7qor?,fIHGs8GOw1?,je!,fKQweh3w6nye!]
    end
  end

  test "~k[] are whitespace insensitive, example #4: 5 variables" do
    check all cgFynNm? <- term(),
              z8_wGm <- term(),
              dreceZlZMEe! <- term(),
              mWP_G? <- term(),
              bEN? <- term() do
      # Check for equality with different amounts of whitespace
      assert ~k[cgFynNm?, z8_wGm, dreceZlZMEe!, mWP_G?, bEN?] ==
               ~k[cgFynNm?,z8_wGm,dreceZlZMEe!  ,mWP_G? ,bEN?]
    end
  end

  test "~k[] are whitespace insensitive, example #5: 6 variables" do
    check all e9GP_60o <- term(),
              xQVpizE <- term(),
              s_tx <- term(),
              aK_3_l2wG9t1? <- term(),
              nvYh5_Ad_ <- term(),
              k! <- term() do
      # Check for equality with different amounts of whitespace
      assert ~k[e9GP_60o, xQVpizE, s_tx, aK_3_l2wG9t1?, nvYh5_Ad_, k!] == ~k[e9GP_60o ,xQVpizE,
s_tx,aK_3_l2wG9t1?,nvYh5_Ad_    ,k!  ]
    end
  end

  test "~k[] are whitespace insensitive, example #6: 7 variables" do
    check all b? <- term(),
              tbTqhBm_V? <- term(),
              mp5yxxYW__f5WpM7 <- term(),
              tft_h_t_rTLuOtR! <- term(),
              fE_nc_xD_jT <- term(),
              d? <- term(),
              tCq_CBT7_E0p9BjR <- term() do
      # Check for equality with different amounts of whitespace
      assert ~k[b?, tbTqhBm_V?, mp5yxxYW__f5WpM7, tft_h_t_rTLuOtR!, fE_nc_xD_jT, d?, tCq_CBT7_E0p9BjR] ==
               ~k[b?,tbTqhBm_V?,mp5yxxYW__f5WpM7,tft_h_t_rTLuOtR!   , fE_nc_xD_jT,  d?,      tCq_CBT7_E0p9BjR ]
    end
  end

  test "~k[] are whitespace insensitive, example #7: 8 variables" do
    check all g <- term(),
              f <- term(),
              k <- term(),
              t? <- term(),
              xL_C! <- term(),
              wP1 <- term(),
              yE2o_ <- term(),
              q? <- term() do
      # Check for equality with different amounts of whitespace
      assert ~k[g, f, k, t?, xL_C!, wP1, yE2o_, q?] == ~k[g, f, k,  
t?  ,xL_C!,wP1   ,  yE2o_    ,     q?  ]
    end
  end

  test "~k[] are whitespace insensitive, example #8: 9 variables" do
    check all b1JF <- term(),
              gPtPde2VP! <- term(),
              zoXmOrk <- term(),
              zgI83IM_FIP_4l0 <- term(),
              svl_Oz3iu7? <- term(),
              f7R__vyW_Lv <- term(),
              f_YWZGrCZev2R? <- term(),
              o_Czxs? <- term(),
              mhf_UW_2o34X <- term() do
      # Check for equality with different amounts of whitespace
      assert ~k[b1JF, gPtPde2VP!, zoXmOrk, zgI83IM_FIP_4l0, svl_Oz3iu7?, f7R__vyW_Lv, f_YWZGrCZev2R?, o_Czxs?, mhf_UW_2o34X] ==
               ~k[b1JF, gPtPde2VP!, 
zoXmOrk, zgI83IM_FIP_4l0,
 svl_Oz3iu7?  ,f7R__vyW_Lv,f_YWZGrCZev2R?,  o_Czxs?,mhf_UW_2o34X ]
    end
  end

  test "~k[] are whitespace insensitive, example #9: 10 variables" do
    check all ogBLvI_sEW <- term(),
              z! <- term(),
              si4L <- term(),
              leLwzZPKGLsqwR1t <- term(),
              jE! <- term(),
              e676m <- term(),
              ul36_jyEk <- term(),
              vah_pDzAy_OI_Q_ <- term(),
              gaP1iT <- term(),
              tv38sLLx3pA_st <- term() do
      # Check for equality with different amounts of whitespace
      assert ~k[ogBLvI_sEW, z!, si4L, leLwzZPKGLsqwR1t, jE!, e676m, ul36_jyEk, vah_pDzAy_OI_Q_, gaP1iT, tv38sLLx3pA_st] ==
               ~k[ogBLvI_sEW,z!,si4L,  leLwzZPKGLsqwR1t    ,jE!,e676m,ul36_jyEk,vah_pDzAy_OI_Q_ ,gaP1iT,tv38sLLx3pA_st]
    end
  end

  test "~k[] are whitespace insensitive, example #10: 11 variables" do
    check all jlMR! <- term(),
              xSbCL <- term(),
              nR9z56! <- term(),
              lwuHr? <- term(),
              g2! <- term(),
              lZM5! <- term(),
              gHH <- term(),
              j_cgA <- term(),
              gbCl <- term(),
              jZO <- term(),
              hqXeoOI! <- term() do
      # Check for equality with different amounts of whitespace
      assert ~k[jlMR!, xSbCL, nR9z56!, lwuHr?, g2!, lZM5!, gHH, j_cgA, gbCl, jZO, hqXeoOI!] ==
               ~k[jlMR!,xSbCL,nR9z56!, lwuHr? ,g2!   , 
 lZM5!    ,gHH,j_cgA,gbCl,    jZO,hqXeoOI!]
    end
  end

  test "~k[] are whitespace insensitive, example #11: 12 variables" do
    check all rZ1B8m6 <- term(),
              eCVI! <- term(),
              pgVl_Iv <- term(),
              ra <- term(),
              y60! <- term(),
              pl <- term(),
              a8? <- term(),
              cc8TB <- term(),
              kMtezibanNf! <- term(),
              kYr_3su? <- term(),
              oVh_yICE_nk <- term(),
              eCzJZ! <- term() do
      # Check for equality with different amounts of whitespace
      assert ~k[rZ1B8m6, eCVI!, pgVl_Iv, ra, y60!, pl, a8?, cc8TB, kMtezibanNf!, kYr_3su?, oVh_yICE_nk, eCzJZ!] ==
               ~k[rZ1B8m6, eCVI!  , pgVl_Iv,  ra,y60!,  pl,a8?,cc8TB,kMtezibanNf! ,kYr_3su?,oVh_yICE_nk, 
 eCzJZ!]
    end
  end
end