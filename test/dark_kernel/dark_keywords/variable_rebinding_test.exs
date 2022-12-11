defmodule DarkKernel.DarkKeywords.VariableRebindingTest do
  use ExUnit.Case, async: true
  import ExUnitProperties
  import StreamData

  import DarkKernel

  test "variable rebinding, example #1: 2 variables" do
    check all h7XiwEQkybhxj! <- term(),
              i <- term(),
              var1 <- term(),
              var2 <- term() do
      # Keyword lists built with ~k[] have the value we expect:
      # -------------------------------------------------------
      assert ~k[h7XiwEQkybhxj!, i] == [h7XiwEQkybhxj!: h7XiwEQkybhxj!, i: i]

      # Test that variables are rebound successfully:
      # ---------------------------------------------

      # 1) Rebind the variables
      ~k[h7XiwEQkybhxj!, i] = [h7XiwEQkybhxj!: var1, i: var2]

      # 2) Assert that each variable has the correct value
      assert h7XiwEQkybhxj! == var1
      assert i == var2
    end
  end

  test "variable rebinding, example #2: 3 variables" do
    check all q? <- term(),
              y_fW9_xZO <- term(),
              iSg <- term(),
              var1 <- term(),
              var2 <- term(),
              var3 <- term() do
      # Keyword lists built with ~k[] have the value we expect:
      # -------------------------------------------------------
      assert ~k[q?, y_fW9_xZO, iSg] == [q?: q?, y_fW9_xZO: y_fW9_xZO, iSg: iSg]

      # Test that variables are rebound successfully:
      # ---------------------------------------------

      # 1) Rebind the variables
      ~k[q?, y_fW9_xZO, iSg] = [q?: var1, y_fW9_xZO: var2, iSg: var3]

      # 2) Assert that each variable has the correct value
      assert q? == var1
      assert y_fW9_xZO == var2
      assert iSg == var3
    end
  end

  test "variable rebinding, example #3: 4 variables" do
    check all v2RUamIB <- term(),
              yf_yFpbZa? <- term(),
              lCW1AaoK3BsOPPWT <- term(),
              v_CiMahqeh? <- term(),
              var1 <- term(),
              var2 <- term(),
              var3 <- term(),
              var4 <- term() do
      # Keyword lists built with ~k[] have the value we expect:
      # -------------------------------------------------------
      assert ~k[v2RUamIB, yf_yFpbZa?, lCW1AaoK3BsOPPWT, v_CiMahqeh?] == [
               v2RUamIB: v2RUamIB,
               yf_yFpbZa?: yf_yFpbZa?,
               lCW1AaoK3BsOPPWT: lCW1AaoK3BsOPPWT,
               v_CiMahqeh?: v_CiMahqeh?
             ]

      # Test that variables are rebound successfully:
      # ---------------------------------------------

      # 1) Rebind the variables
      ~k[v2RUamIB, yf_yFpbZa?, lCW1AaoK3BsOPPWT, v_CiMahqeh?] = [
        v2RUamIB: var1,
        yf_yFpbZa?: var2,
        lCW1AaoK3BsOPPWT: var3,
        v_CiMahqeh?: var4
      ]

      # 2) Assert that each variable has the correct value
      assert v2RUamIB == var1
      assert yf_yFpbZa? == var2
      assert lCW1AaoK3BsOPPWT == var3
      assert v_CiMahqeh? == var4
    end
  end

  test "variable rebinding, example #4: 5 variables" do
    check all vJ_6tXr? <- term(),
              h! <- term(),
              kiA33z_0R6 <- term(),
              de <- term(),
              xqgw! <- term(),
              var1 <- term(),
              var2 <- term(),
              var3 <- term(),
              var4 <- term(),
              var5 <- term() do
      # Keyword lists built with ~k[] have the value we expect:
      # -------------------------------------------------------
      assert ~k[vJ_6tXr?, h!, kiA33z_0R6, de, xqgw!] == [
               vJ_6tXr?: vJ_6tXr?,
               h!: h!,
               kiA33z_0R6: kiA33z_0R6,
               de: de,
               xqgw!: xqgw!
             ]

      # Test that variables are rebound successfully:
      # ---------------------------------------------

      # 1) Rebind the variables
      ~k[vJ_6tXr?, h!, kiA33z_0R6, de, xqgw!] = [
        vJ_6tXr?: var1,
        h!: var2,
        kiA33z_0R6: var3,
        de: var4,
        xqgw!: var5
      ]

      # 2) Assert that each variable has the correct value
      assert vJ_6tXr? == var1
      assert h! == var2
      assert kiA33z_0R6 == var3
      assert de == var4
      assert xqgw! == var5
    end
  end

  test "variable rebinding, example #5: 6 variables" do
    check all ya <- term(),
              pC2o! <- term(),
              zE <- term(),
              p_Q? <- term(),
              uGLX? <- term(),
              t? <- term(),
              var1 <- term(),
              var2 <- term(),
              var3 <- term(),
              var4 <- term(),
              var5 <- term(),
              var6 <- term() do
      # Keyword lists built with ~k[] have the value we expect:
      # -------------------------------------------------------
      assert ~k[ya, pC2o!, zE, p_Q?, uGLX?, t?] == [
               ya: ya,
               pC2o!: pC2o!,
               zE: zE,
               p_Q?: p_Q?,
               uGLX?: uGLX?,
               t?: t?
             ]

      # Test that variables are rebound successfully:
      # ---------------------------------------------

      # 1) Rebind the variables
      ~k[ya, pC2o!, zE, p_Q?, uGLX?, t?] = [
        ya: var1,
        pC2o!: var2,
        zE: var3,
        p_Q?: var4,
        uGLX?: var5,
        t?: var6
      ]

      # 2) Assert that each variable has the correct value
      assert ya == var1
      assert pC2o! == var2
      assert zE == var3
      assert p_Q? == var4
      assert uGLX? == var5
      assert t? == var6
    end
  end

  test "variable rebinding, example #6: 7 variables" do
    check all emmuvDkRG__! <- term(),
              iXp6FDfec_G <- term(),
              mFB <- term(),
              cs <- term(),
              wC9s? <- term(),
              n5AEjWJ0CM9? <- term(),
              o_wrp8nr9hHzw_! <- term(),
              var1 <- term(),
              var2 <- term(),
              var3 <- term(),
              var4 <- term(),
              var5 <- term(),
              var6 <- term(),
              var7 <- term() do
      # Keyword lists built with ~k[] have the value we expect:
      # -------------------------------------------------------
      assert ~k[emmuvDkRG__!, iXp6FDfec_G, mFB, cs, wC9s?, n5AEjWJ0CM9?, o_wrp8nr9hHzw_!] == [
               emmuvDkRG__!: emmuvDkRG__!,
               iXp6FDfec_G: iXp6FDfec_G,
               mFB: mFB,
               cs: cs,
               wC9s?: wC9s?,
               n5AEjWJ0CM9?: n5AEjWJ0CM9?,
               o_wrp8nr9hHzw_!: o_wrp8nr9hHzw_!
             ]

      # Test that variables are rebound successfully:
      # ---------------------------------------------

      # 1) Rebind the variables
      ~k[emmuvDkRG__!, iXp6FDfec_G, mFB, cs, wC9s?, n5AEjWJ0CM9?, o_wrp8nr9hHzw_!] = [
        emmuvDkRG__!: var1,
        iXp6FDfec_G: var2,
        mFB: var3,
        cs: var4,
        wC9s?: var5,
        n5AEjWJ0CM9?: var6,
        o_wrp8nr9hHzw_!: var7
      ]

      # 2) Assert that each variable has the correct value
      assert emmuvDkRG__! == var1
      assert iXp6FDfec_G == var2
      assert mFB == var3
      assert cs == var4
      assert wC9s? == var5
      assert n5AEjWJ0CM9? == var6
      assert o_wrp8nr9hHzw_! == var7
    end
  end

  test "variable rebinding, example #7: 8 variables" do
    check all aGrLji1iNn? <- term(),
              d0dSyO9Gh__PFw6? <- term(),
              t_ru_WjdCmc <- term(),
              d <- term(),
              bXVVrTn_d <- term(),
              tICP0_mN969Ap! <- term(),
              e8iKepRIS__AXSc? <- term(),
              g0uQEChDL__7v! <- term(),
              var1 <- term(),
              var2 <- term(),
              var3 <- term(),
              var4 <- term(),
              var5 <- term(),
              var6 <- term(),
              var7 <- term(),
              var8 <- term() do
      # Keyword lists built with ~k[] have the value we expect:
      # -------------------------------------------------------
      assert ~k[aGrLji1iNn?, d0dSyO9Gh__PFw6?, t_ru_WjdCmc, d, bXVVrTn_d, tICP0_mN969Ap!, e8iKepRIS__AXSc?, g0uQEChDL__7v!] ==
               [
                 aGrLji1iNn?: aGrLji1iNn?,
                 d0dSyO9Gh__PFw6?: d0dSyO9Gh__PFw6?,
                 t_ru_WjdCmc: t_ru_WjdCmc,
                 d: d,
                 bXVVrTn_d: bXVVrTn_d,
                 tICP0_mN969Ap!: tICP0_mN969Ap!,
                 e8iKepRIS__AXSc?: e8iKepRIS__AXSc?,
                 g0uQEChDL__7v!: g0uQEChDL__7v!
               ]

      # Test that variables are rebound successfully:
      # ---------------------------------------------

      # 1) Rebind the variables
      ~k[aGrLji1iNn?, d0dSyO9Gh__PFw6?, t_ru_WjdCmc, d, bXVVrTn_d, tICP0_mN969Ap!, e8iKepRIS__AXSc?, g0uQEChDL__7v!] =
        [
          aGrLji1iNn?: var1,
          d0dSyO9Gh__PFw6?: var2,
          t_ru_WjdCmc: var3,
          d: var4,
          bXVVrTn_d: var5,
          tICP0_mN969Ap!: var6,
          e8iKepRIS__AXSc?: var7,
          g0uQEChDL__7v!: var8
        ]

      # 2) Assert that each variable has the correct value
      assert aGrLji1iNn? == var1
      assert d0dSyO9Gh__PFw6? == var2
      assert t_ru_WjdCmc == var3
      assert d == var4
      assert bXVVrTn_d == var5
      assert tICP0_mN969Ap! == var6
      assert e8iKepRIS__AXSc? == var7
      assert g0uQEChDL__7v! == var8
    end
  end

  test "variable rebinding, example #8: 9 variables" do
    check all ot__s_o3x? <- term(),
              de? <- term(),
              l1_9n6uM! <- term(),
              hk_8eZ! <- term(),
              f <- term(),
              hq90oRL5_w4W28O! <- term(),
              lgdSYM2iv <- term(),
              pDprsTcaQWfncAz? <- term(),
              a0VBPRsPaVU_p <- term(),
              var1 <- term(),
              var2 <- term(),
              var3 <- term(),
              var4 <- term(),
              var5 <- term(),
              var6 <- term(),
              var7 <- term(),
              var8 <- term(),
              var9 <- term() do
      # Keyword lists built with ~k[] have the value we expect:
      # -------------------------------------------------------
      assert ~k[ot__s_o3x?, de?, l1_9n6uM!, hk_8eZ!, f, hq90oRL5_w4W28O!, lgdSYM2iv, pDprsTcaQWfncAz?, a0VBPRsPaVU_p] ==
               [
                 ot__s_o3x?: ot__s_o3x?,
                 de?: de?,
                 l1_9n6uM!: l1_9n6uM!,
                 hk_8eZ!: hk_8eZ!,
                 f: f,
                 hq90oRL5_w4W28O!: hq90oRL5_w4W28O!,
                 lgdSYM2iv: lgdSYM2iv,
                 pDprsTcaQWfncAz?: pDprsTcaQWfncAz?,
                 a0VBPRsPaVU_p: a0VBPRsPaVU_p
               ]

      # Test that variables are rebound successfully:
      # ---------------------------------------------

      # 1) Rebind the variables
      ~k[ot__s_o3x?, de?, l1_9n6uM!, hk_8eZ!, f, hq90oRL5_w4W28O!, lgdSYM2iv, pDprsTcaQWfncAz?, a0VBPRsPaVU_p] =
        [
          ot__s_o3x?: var1,
          de?: var2,
          l1_9n6uM!: var3,
          hk_8eZ!: var4,
          f: var5,
          hq90oRL5_w4W28O!: var6,
          lgdSYM2iv: var7,
          pDprsTcaQWfncAz?: var8,
          a0VBPRsPaVU_p: var9
        ]

      # 2) Assert that each variable has the correct value
      assert ot__s_o3x? == var1
      assert de? == var2
      assert l1_9n6uM! == var3
      assert hk_8eZ! == var4
      assert f == var5
      assert hq90oRL5_w4W28O! == var6
      assert lgdSYM2iv == var7
      assert pDprsTcaQWfncAz? == var8
      assert a0VBPRsPaVU_p == var9
    end
  end

  test "variable rebinding, example #9: 10 variables" do
    check all ezw5gpmLFnq5C? <- term(),
              tlZpvD5ALl? <- term(),
              eY00e_lH? <- term(),
              q749hO? <- term(),
              tQAj_f9pMy9_ <- term(),
              t_r_aTI_TKMY_b <- term(),
              aY <- term(),
              tE <- term(),
              k4D_r4bF_3lI_ <- term(),
              obUQ_ <- term(),
              var1 <- term(),
              var2 <- term(),
              var3 <- term(),
              var4 <- term(),
              var5 <- term(),
              var6 <- term(),
              var7 <- term(),
              var8 <- term(),
              var9 <- term(),
              var10 <- term() do
      # Keyword lists built with ~k[] have the value we expect:
      # -------------------------------------------------------
      assert ~k[ezw5gpmLFnq5C?, tlZpvD5ALl?, eY00e_lH?, q749hO?, tQAj_f9pMy9_, t_r_aTI_TKMY_b, aY, tE, k4D_r4bF_3lI_, obUQ_] ==
               [
                 ezw5gpmLFnq5C?: ezw5gpmLFnq5C?,
                 tlZpvD5ALl?: tlZpvD5ALl?,
                 eY00e_lH?: eY00e_lH?,
                 q749hO?: q749hO?,
                 tQAj_f9pMy9_: tQAj_f9pMy9_,
                 t_r_aTI_TKMY_b: t_r_aTI_TKMY_b,
                 aY: aY,
                 tE: tE,
                 k4D_r4bF_3lI_: k4D_r4bF_3lI_,
                 obUQ_: obUQ_
               ]

      # Test that variables are rebound successfully:
      # ---------------------------------------------

      # 1) Rebind the variables
      ~k[ezw5gpmLFnq5C?, tlZpvD5ALl?, eY00e_lH?, q749hO?, tQAj_f9pMy9_, t_r_aTI_TKMY_b, aY, tE, k4D_r4bF_3lI_, obUQ_] =
        [
          ezw5gpmLFnq5C?: var1,
          tlZpvD5ALl?: var2,
          eY00e_lH?: var3,
          q749hO?: var4,
          tQAj_f9pMy9_: var5,
          t_r_aTI_TKMY_b: var6,
          aY: var7,
          tE: var8,
          k4D_r4bF_3lI_: var9,
          obUQ_: var10
        ]

      # 2) Assert that each variable has the correct value
      assert ezw5gpmLFnq5C? == var1
      assert tlZpvD5ALl? == var2
      assert eY00e_lH? == var3
      assert q749hO? == var4
      assert tQAj_f9pMy9_ == var5
      assert t_r_aTI_TKMY_b == var6
      assert aY == var7
      assert tE == var8
      assert k4D_r4bF_3lI_ == var9
      assert obUQ_ == var10
    end
  end

  test "variable rebinding, example #10: 11 variables" do
    check all hgY0Q_Ii? <- term(),
              t <- term(),
              cr_4fWwW_ClEOA <- term(),
              kQG7coZL9gy? <- term(),
              fXkVzohNOF06mc71? <- term(),
              i2! <- term(),
              nToc <- term(),
              krYhVSLjTnFIR? <- term(),
              fIOEDh2! <- term(),
              rPisYozw_s5mH <- term(),
              plw_e4PsE9s_I21i <- term(),
              var1 <- term(),
              var2 <- term(),
              var3 <- term(),
              var4 <- term(),
              var5 <- term(),
              var6 <- term(),
              var7 <- term(),
              var8 <- term(),
              var9 <- term(),
              var10 <- term(),
              var11 <- term() do
      # Keyword lists built with ~k[] have the value we expect:
      # -------------------------------------------------------
      assert ~k[hgY0Q_Ii?, t, cr_4fWwW_ClEOA, kQG7coZL9gy?, fXkVzohNOF06mc71?, i2!, nToc, krYhVSLjTnFIR?, fIOEDh2!, rPisYozw_s5mH, plw_e4PsE9s_I21i] ==
               [
                 hgY0Q_Ii?: hgY0Q_Ii?,
                 t: t,
                 cr_4fWwW_ClEOA: cr_4fWwW_ClEOA,
                 kQG7coZL9gy?: kQG7coZL9gy?,
                 fXkVzohNOF06mc71?: fXkVzohNOF06mc71?,
                 i2!: i2!,
                 nToc: nToc,
                 krYhVSLjTnFIR?: krYhVSLjTnFIR?,
                 fIOEDh2!: fIOEDh2!,
                 rPisYozw_s5mH: rPisYozw_s5mH,
                 plw_e4PsE9s_I21i: plw_e4PsE9s_I21i
               ]

      # Test that variables are rebound successfully:
      # ---------------------------------------------

      # 1) Rebind the variables
      ~k[hgY0Q_Ii?, t, cr_4fWwW_ClEOA, kQG7coZL9gy?, fXkVzohNOF06mc71?, i2!, nToc, krYhVSLjTnFIR?, fIOEDh2!, rPisYozw_s5mH, plw_e4PsE9s_I21i] =
        [
          hgY0Q_Ii?: var1,
          t: var2,
          cr_4fWwW_ClEOA: var3,
          kQG7coZL9gy?: var4,
          fXkVzohNOF06mc71?: var5,
          i2!: var6,
          nToc: var7,
          krYhVSLjTnFIR?: var8,
          fIOEDh2!: var9,
          rPisYozw_s5mH: var10,
          plw_e4PsE9s_I21i: var11
        ]

      # 2) Assert that each variable has the correct value
      assert hgY0Q_Ii? == var1
      assert t == var2
      assert cr_4fWwW_ClEOA == var3
      assert kQG7coZL9gy? == var4
      assert fXkVzohNOF06mc71? == var5
      assert i2! == var6
      assert nToc == var7
      assert krYhVSLjTnFIR? == var8
      assert fIOEDh2! == var9
      assert rPisYozw_s5mH == var10
      assert plw_e4PsE9s_I21i == var11
    end
  end

  test "variable rebinding, example #11: 12 variables" do
    check all nKo9DtVMD <- term(),
              gW_H__Fb_RG_lZ <- term(),
              wW45 <- term(),
              oKi1CmarKYyX__3? <- term(),
              v4TaAxcr_6fCJ! <- term(),
              htR! <- term(),
              u79kDK9sk? <- term(),
              uwUWqKIRwFYXI! <- term(),
              jROQmVEMbN_ <- term(),
              tsYK3ZYr <- term(),
              k_37pChYfnZ <- term(),
              gu_uuIAyV7! <- term(),
              var1 <- term(),
              var2 <- term(),
              var3 <- term(),
              var4 <- term(),
              var5 <- term(),
              var6 <- term(),
              var7 <- term(),
              var8 <- term(),
              var9 <- term(),
              var10 <- term(),
              var11 <- term(),
              var12 <- term() do
      # Keyword lists built with ~k[] have the value we expect:
      # -------------------------------------------------------
      assert ~k[nKo9DtVMD, gW_H__Fb_RG_lZ, wW45, oKi1CmarKYyX__3?, v4TaAxcr_6fCJ!, htR!, u79kDK9sk?, uwUWqKIRwFYXI!, jROQmVEMbN_, tsYK3ZYr, k_37pChYfnZ, gu_uuIAyV7!] ==
               [
                 nKo9DtVMD: nKo9DtVMD,
                 gW_H__Fb_RG_lZ: gW_H__Fb_RG_lZ,
                 wW45: wW45,
                 oKi1CmarKYyX__3?: oKi1CmarKYyX__3?,
                 v4TaAxcr_6fCJ!: v4TaAxcr_6fCJ!,
                 htR!: htR!,
                 u79kDK9sk?: u79kDK9sk?,
                 uwUWqKIRwFYXI!: uwUWqKIRwFYXI!,
                 jROQmVEMbN_: jROQmVEMbN_,
                 tsYK3ZYr: tsYK3ZYr,
                 k_37pChYfnZ: k_37pChYfnZ,
                 gu_uuIAyV7!: gu_uuIAyV7!
               ]

      # Test that variables are rebound successfully:
      # ---------------------------------------------

      # 1) Rebind the variables
      ~k[nKo9DtVMD, gW_H__Fb_RG_lZ, wW45, oKi1CmarKYyX__3?, v4TaAxcr_6fCJ!, htR!, u79kDK9sk?, uwUWqKIRwFYXI!, jROQmVEMbN_, tsYK3ZYr, k_37pChYfnZ, gu_uuIAyV7!] =
        [
          nKo9DtVMD: var1,
          gW_H__Fb_RG_lZ: var2,
          wW45: var3,
          oKi1CmarKYyX__3?: var4,
          v4TaAxcr_6fCJ!: var5,
          htR!: var6,
          u79kDK9sk?: var7,
          uwUWqKIRwFYXI!: var8,
          jROQmVEMbN_: var9,
          tsYK3ZYr: var10,
          k_37pChYfnZ: var11,
          gu_uuIAyV7!: var12
        ]

      # 2) Assert that each variable has the correct value
      assert nKo9DtVMD == var1
      assert gW_H__Fb_RG_lZ == var2
      assert wW45 == var3
      assert oKi1CmarKYyX__3? == var4
      assert v4TaAxcr_6fCJ! == var5
      assert htR! == var6
      assert u79kDK9sk? == var7
      assert uwUWqKIRwFYXI! == var8
      assert jROQmVEMbN_ == var9
      assert tsYK3ZYr == var10
      assert k_37pChYfnZ == var11
      assert gu_uuIAyV7! == var12
    end
  end
end